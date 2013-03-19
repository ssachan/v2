<?php
include 'xkcd.php';
$secret_key = "ebskey"; // Your Secret Key
if (isset($_GET['DR'])) {
    require('pay/Rc43.php');
    $DR = preg_replace("/\s/", "+", $_GET['DR']);

    $rc4 = new Crypt_RC4($secret_key);
    $QueryString = base64_decode($DR);
    $rc4->decrypt($QueryString);
    $QueryString = split('&', $QueryString);

    $response = array();
    foreach ($QueryString as $param) {
        $param = split('=', $param);
        $response[$param[0]] = urldecode($param[1]);
    }
    $sql = "update purchases set status=:status, billingPhone=:billingPhone, paymentId=:paymentId, transactionId=:transactionId, paymentMethod=:paymentMethod where id=:id";
    try {
        $db = getConnection();
        $stmt = $db->prepare($sql);
        $stmt->bindParam("status", $response['ResponseCode']);
        $stmt->bindParam("billingPhone", $response['BillingPhone']);
        $stmt->bindParam("paymentId", $response['PaymentID']);
        $stmt->bindParam("transactionId", $response['TransactionID']);
        $stmt->bindParam("paymentMethod", $response['PaymentMethod']);
        $stmt->bindParam("id", $response['MerchantRefNo']);
        $stmt->execute();
        $db = null;
        //$response["status"] = SUCCESS;
        //$response["data"] = $attemptedAs;
    } catch (PDOException $e) {
        //$response["status"] = ERROR;
        //$response["data"] = EXCEPTION_MSG;
        phpLog($e->getMessage());
    }
    $streamId = '1';
    //if it was a success add the packages
    if ($response['ResponseCode'] == '0') {
        // get the account id
        $sql = "SELECT p.accountId, pa.number as number from purchases p,packages pa where p.packageId=pa.id and p.id=:id";
        try {
            $db = getConnection();
            $stmt = $db->prepare($sql);
            $stmt->bindParam("id", $response['MerchantRefNo']);
            $stmt->execute();
            $record = $stmt->fetch(PDO::FETCH_OBJ);
            $accountId = $record->accountId;
            $number = intval($record->number);
        } catch (PDOException $e) {
            phpLog($e->getMessage());
        }
        $sql = "SELECT quizzesRemaining from students where accountId=:accountId and streamId=:streamId";
        try {
            $db = getConnection();
            $stmt = $db->prepare($sql);
            $stmt->bindParam("accountId", $accountId);
            $stmt->bindParam("streamId", $streamId);
            $stmt->execute();
            $record = $stmt->fetch(PDO::FETCH_OBJ);
            $quizzesRemaining = intval($record->quizzesRemaining);
            $quizzesRemaining += $number;
            $sql = "UPDATE students SET quizzesRemaining=:quizzesRemaining where accountId=:accountId and streamId=:streamId";
            try {
                $db = getConnection();
                $stmt = $db->prepare($sql);
                $stmt->bindParam("quizzesRemaining", $quizzesRemaining);
                $stmt->bindParam("accountId", $accountId);
                $stmt->bindParam("streamId", $streamId);
                $stmt->execute();
                $db = null;
            } catch (PDOException $e) {
                $response["status"] = ERROR;
                $response["data"] = EXCEPTION_MSG;
                phpLog($e->getMessage());
            }
        } catch (PDOException $e) {
            $response["status"] = ERROR;
            $response["data"] = EXCEPTION_MSG;
            phpLog($e->getMessage());
        }
    }else{
        echo 'Something went wrong try again.';
    }
}

?>
<HTML>
<HEAD>
<TITLE>PREPSQUARE PAYMENT STATUS PAGE</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<style>
	h1       { font-family:Arial,sans-serif; font-size:24pt; color:#08185A; font-weight:100; margin-bottom:0.1em}
    h2.co    { font-family:Arial,sans-serif; font-size:24pt; color:#FFFFFF; margin-top:0.1em; margin-bottom:0.1em; font-weight:100}
    h3.co    { font-family:Arial,sans-serif; font-size:16pt; color:#000000; margin-top:0.1em; margin-bottom:0.1em; font-weight:100}
    h3       { font-family:Arial,sans-serif; font-size:16pt; color:#08185A; margin-top:0.1em; margin-bottom:0.1em; font-weight:100}
    body     { font-family:Verdana,Arial,sans-serif; font-size:11px; color:#08185A;}
	th 		 { font-size:12px;background:#015289;color:#FFFFFF;font-weight:bold;height:30px;}
	td 		 { font-size:12px;background:#DDE8F3}
	.pageTitle { font-size:24px;}
</style>
</HEAD>
<BODY LEFTMARGIN=0 TOPMARGIN=0 MARGINWIDTH=0 MARGINHEIGHT=0 bgcolor="#ECF1F7">
<center>
   <table width='100%' cellpadding='0' cellspacing="0" ><tr><th width='90%'><h2 class='co'>&nbsp;PrepSquare</h2></th></tr></table>
     <center><h1>Payment Status</H1></center>
	<center><h3></H3></center>
    <table width="600" cellpadding="2" cellspacing="2" border="0">
        <tr>
            <th colspan="2">Transaction Details</th>
        </tr>
<?php
foreach ($response as $key => $value) {
?>			
        <tr>
            <td class="fieldName" width="50%"><?php echo $key; ?></td>
            <td class="fieldName" align="left" width="50%"><?php echo $value; ?></td>
        </tr>
<?php
}
?>		
	</table>
</center>
<table width='100%' cellpadding='0' cellspacing="0" ><tr><th width='90%'>&nbsp;</th></tr></table>
</body>
</html>
