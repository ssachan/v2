<?php

class bases{

 public static $values = array(
    "UNSEEN"                   => 0,
    "CORRECT_LOW_LEVEL"        => 20,
    "CORRECT_LOW_VAL"          => 3,
    "CORRECT_HIGH_LEVEL"       => 80,
    "CORRECT_HIGH_VAL"         => 1,
    "INCORRECT_LOW_LEVEL"      => 20,
    "INCORRECT_LOW_VAL"        => -1,
    "INCORRECT_HIGH_LEVEL"     => 80,
    "INCORRECT_HIGH_VAL"       => -3,
    "SKIPPED_ABOVE_LOW_LEVEL"  => 20,
    "SKIPPED_ABOVE_LOW_VAL"    => 1.5,
    "SKIPPED_ABOVE_HIGH_LEVEL" => 80,
    "SKIPPED_ABOVE_HIGH_VAL"   => 0.5,
    "SKIPPED_BELOW_LOW_LEVEL"  => 20,
    "SKIPPED_BELOW_LOW_VAL"    => -0.5,
    "SKIPPED_BELOW_HIGH_LEVEL" => 80,
    "SKIPPED_BELOW_HIGH_VAL"   => -1.5,
     );

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
        "CORRECT_HIGH"       => 0.5,
        "CORRECT_LOW"        => 2,
        "INCORRECT_HIGH"     => 2,
        "INCORRECT_LOW"      => 0.5,
        "SKIPPED_ABOVE_HIGH" => 0.5,
        "SKIPPED_ABOVE_LOW"  => 2,
        "SKIPPED_BELOW_HIGH" => 2,
        "SKIPPED_BELOW_LOW"  => 0.5 );

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
    "M1" => 0.03,
    "M2" => 0.0075 );

    public static function set($key, $value, $default = null){
        self::$values[$key] = is_null($value) ? $default : $value;
    }

    public static function get($key, $default = null){
        return array_key_exists($key, self::$values) ? self::$values[$key] : $default;
    }
}

class deltaCalculator{
    
    public static function calculate($state, $score, $qScore, $timeTaken, $avgTime, $sigmaTime){
        $base = self::getBaseScore($state,$score,$qScore);
        $timeFactor = self::timeFactor($state, $timeTaken, $avgTime, $sigmaTime, $score, $qScore);
        $abilityFactor = self::abilityFactor($score, $qScore, $state );
        $delta = round($base * $timeFactor * $abilityFactor,2);
        if(($score + $delta) > 100)
            $delta = (100-$score);
        elseif (($score + $delta) < 0)
            $delta = -$score;
        return $delta;
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
    public static function getBaseScore($state,$score,$qScore)
   {
        $base = self::getBase($state,$score,$qScore);
        $tmp = new bases;
        if($score <= $tmp->get($base."_LOW_LEVEL"))
            return $tmp->get($base."_LOW_VAL");
        elseif($score >= $tmp->get($base."_HIGH_LEVEL"))
            return $tmp->get($base."_HIGH_VAL");
        else
            return ($score - $tmp->get($base."_LOW_LEVEL")) /($tmp->get($base."_HIGH_LEVEL")-$tmp->get($base."_LOW_LEVEL"))*($tmp->get($base."_HIGH_VAL")-$tmp->get($base."_LOW_VAL"))+$tmp->get($base."_LOW_VAL");   
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
                    return (1 + ($tmp->get("M2") * $x));
                break;
                case analConst::INCORRECT :
                    return (1-($tmp->get("M1") * $x))/2;
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

    //Writing Constants
        fwrite($fp, "Bases => \n");
        foreach (bases::$values as $key => $value)
            fwrite($fp,$key.",".$value."\n");
        fwrite($fp, "\nTime Ranges => \n");
        foreach (timeRanges::$values as $key => $value)
            fwrite($fp,$key.",".$value."\n");
        fwrite($fp, "\nability factors => \n");
        foreach (abilityFactors::$values as $key => $value)
            fwrite($fp,$key.",".$value."\n");
        fwrite($fp,"\nData\nstate,qScore,timeTaken,avgTime,sigmaTime,score,delta,base,timeFactor,abilityFactor\n");
          $currentLine   = fgets($file);
          $vars          = explode(",",$currentLine);
          $score         = $vars[5];
          $state         = $vars[0]; $qScore = $vars[1]; $timeTaken = $vars[2]; $avgTime = $vars[3]; $sigmaTime = $vars[4];
          $delta         = deltaCalculator::calculate($state, $score, $qScore, $timeTaken, $avgTime, $sigmaTime);
          $base          = round(deltaCalculator::getBaseScore($state,$score,$qScore),2);
          $timeFactor    = deltaCalculator::timeFactor($state, $timeTaken, $avgTime, $sigmaTime, $score, $qScore);
          $abilityFactor = deltaCalculator::abilityFactor($score, $qScore, $state);
          $vars[]        = $delta; $vars[] = $base; $vars[] = $timeFactor; $vars[] = $abilityFactor;
          $vars          = implode(",", $vars);
          $vars          = str_replace("\n","",$vars);
		fwrite($fp, $vars."\n");
		$score += $delta; 
	while(!feof($file))
	  {   
        $currentLine   = fgets($file);
        $vars          = explode(",",$currentLine);
        $state         = $vars[0]; $qScore = $vars[1]; $timeTaken = $vars[2]; $avgTime = $vars[3]; $sigmaTime = $vars[4];
        $delta         = deltaCalculator::calculate($state, $score, $qScore, $timeTaken, $avgTime, $sigmaTime);
        $base          = round(deltaCalculator::getBaseScore($state,$score,$qScore),2);
        $timeFactor    = deltaCalculator::timeFactor($state, $timeTaken, $avgTime, $sigmaTime, $score, $qScore);
        $abilityFactor = deltaCalculator::abilityFactor($score, $qScore, $state);
        $vars[]        = $score;
        $vars[]        = $delta; $vars[] = $base; $vars[] = $timeFactor; $vars[] = $abilityFactor;
        $vars          = implode(",", $vars);
        $vars          = str_replace("\n","",$vars);
		fwrite($fp, $vars."\n");
		$score += $delta;
	  }
	fclose($file);	
}

//Possible values for $state = analConst::CORRECT, ::INCORRECT, etc.