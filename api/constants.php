<?php

class bases{

 public static $values = array(
    "UNSEEN" => 0,
    "CORRECT_L_1" => 5,
    "CORRECT_L_2" => 4,
    "CORRECT_L_3" => 3,
    "CORRECT_L_4" => 2,
    "CORRECT_L_5" => 1,
    "INCORRECT_L_1" => -5,
    "INCORRECT_L_2" => -4,
    "INCORRECT_L_3" => -3,
    "INCORRECT_L_4" => -2,
    "INCORRECT_L_5" => -1,
    "SKIPPED_ABOVE_L_1" => 2.5,
    "SKIPPED_ABOVE_L_2" => 2.0,
    "SKIPPED_ABOVE_L_3" => 1.5,
    "SKIPPED_ABOVE_L_4" => 1.0,
    "SKIPPED_ABOVE_L_5" => 0.5,
    "SKIPPED_BELOW_L_1" => 2.5,
    "SKIPPED_BELOW_L_2" => 2,
    "SKIPPED_BELOW_L_3" => 1.5,
    "SKIPPED_BELOW_L_4" => 1,
    "SKIPPED_BELOW_L_5" => 0.5,
    "L_1" => 20,
    "L_2" => 40,
    "L_3" => 60,
    "L_4" => 80 );

    public static function set($key, $value, $default = null)
    {
        self::$values[$key] = is_null($value) ? $default : $value;
    }

    public static function get($key, $default = null)
    {
        return array_key_exists($key, self::$values) ? self::$values[$key] : $default;
    }
}

class timeRanges {
    public static $values = array(
	    "CORRECT_HIGH" => 0.5,
	    "CORRECT_LOW" => 2,
	    "INCORRECT_HIGH" => 0.5,
	    "INCORRECT_LOW" => 2,
	    "SKIPPED_ABOVE_HIGH" => 0.5,
	    "SKIPPED_ABOVE_LOW" => 2,
	    "SKIPPED_BELOW_HIGH" => 2,
	    "SKIPPED_BELOW_LOW" => 0.5 );

    public static function set($key, $value, $default = null)
    {
        self::$values[$key] = is_null($value) ? $default : $value;
    }

    public static function get($key, $default = null)
    {
        return array_key_exists($key, self::$values) ? self::$values[$key] : $default;
    }
}

class abilityFactors{
    public static $values= array(
    "M1" => 0.2,
    "M2" => 0.01 );

    public static function set($key, $value, $default = null){
        self::$values[$key] = is_null($value) ? $default : $value;
    }

    public static function get($key, $default = null){
        return array_key_exists($key, self::$values) ? self::$values[$key] : $default;
    }
}

class deltaCalculator{
    
    public static function calculate($state, $score, $qScore, $timeTaken, $avgTime, $sigmaTime){
        $tmp = new bases;
        $base = $tmp->get(self::getBase($state,$score,$qScore)."_".self::getLevel($score));
        $timeFactor = self::timeFactor($state, $timeTaken, $avgTime, $sigmaTime, $score, $qScore);
        $abilityFactor = self::abilityFactor($score, $qScore, $state );
        
        return $base * $timeFactor * $abilityFactor;
    }
    public static function getBase($state,$score,$qScore)
    {
    	$base = analConst::$enums[$state];
    	if($base == "SKIPPED")
    		if($score <= $qScore)
    			$base .= "_ABOVE";
    		else
    			$base .="_BELOW";
    	return $base;
    }
    public static function timeFactor($state, $value, $mu, $sigma, $score, $qScore){
        $tmp = new timeRanges;
        $percentile = self::getPercentile($value, $mu, $sigma);
        $percentile = ceil($percentile/5);
        $low = $tmp->get(self::getBase($state,$score,$qScore)."_LOW");
        $range = $tmp->get(self::getBase($state,$score,$qScore)."_HIGH") - $low;
        return ($low + ($percentile/20 * $range));
    }
    public static function abilityFactor($score, $qScore, $state){
        $x = $qScore - $score;
        $tmp = new abilityFactors;
        if($x>=0){
            switch($state){
                case analConst::CORRECT :
                    return (($tmp->get("M1") * $x) + 1);
                break;
                case analConst::INCORRECT :
                    return (1 - ($tmp->get("M2") * $x))/2;
                break;
                default:
                   return 1; 
                break;
            }
        }
        else{
            switch($state){
                case analConst::CORRECT :
                    return (1 - ($tmp->get("M2") * $x));
                break;
                case analConst::INCORRECT :
                    return (($tmp->get("M1") * $x) + 1)/2;
                break;
                default:
                   return 1; 
                break;
            }
        }
    }
    public static function getPercentile($value, $mu, $sigma){
        return self::cdf(($value-$mu)/$sigma)*100;
    }
    public static function getLevel($score){
    	$tmp = new bases;
        switch($score)
        {
            case ($score < $tmp->get("L_1")):
                return "L_1";
            break;
            case ($score < $tmp->get("L_2")):
                return "L_2";
            break;
            case ($score < $tmp->get("L_3")):
                return "L_3";
            break;
            case ($score < $tmp->get("L_4")):
                return "L_4";
            break;
            case ($score < $tmp->get("L_5")):
                return "L_5";
            break;
        }
    }
    static function erf($x) { 
        $pi = 3.1415927; 
        $a = (8*($pi - 3))/(3*$pi*(4 - $pi)); 
        $x2 = $x * $x; 
        $ax2 = $a * $x2; 
        $num = (4/$pi) + $ax2; 
        $denom = 1 + $ax2; 
        $inner = (-$x2)*$num/$denom; 
        $erf2 = 1 - exp($inner); 
        return sqrt($erf2); 
    } 
    static function cdf($n) { 
    	if($n < 0) 
        { 
                return (1 - self::erf($n / sqrt(2)))/2; 
        } 
        else 
        {
                return (1 + self::erf($n / sqrt(2)))/2; 
        } 
    } 
}

function testDelta()
{

	//($state, $qScore, $timeTaken, $avgTime, $sigmaTime, $score)
	$file = fopen("data.csv", "r") or exit("Unable to open file!");
	$fp = fopen('data-op.csv', 'w') or exit("Unable to write to file");
	//Output a line of the file until the end is reached
		$currentLine = fgets($file);
	  	$vars = explode(",",$currentLine);
		$delta = deltaCalculator::calculate($vars[0], $vars[5], $vars[1], $vars[2], $vars[3], $vars[4]);
		$vars[] = $delta;
		$score = $vars[5];
		$vars = implode(",", $vars);
		fwrite($fp, $vars."\n");
		$score += $delta; 
	while(!feof($file))
	  {
	  	$currentLine = fgets($file);
	  	$vars = explode(",",$currentLine);
		$delta = deltaCalculator::calculate($vars[0], $score, $vars[1], $vars[2], $vars[3], $vars[4]);
		$vars[]= $score;
		$vars[] = $delta;
		$vars = implode(",", $vars);
		fwrite($fp, $vars."\n");
		$score += $delta;
	  }
	fclose($file);

	
}

//Possible values for $state = analConst::CORRECT, ::INCORRECT, etc.