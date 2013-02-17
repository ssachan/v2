<?
$hash = "ebskey"."|".$_POST['account_id']."|".$_POST['amount']."|".$_POST['reference_no']."|".$_POST['return_url']."|".$_POST['mode'];

$secure_hash = md5($hash);


?>
<form  method="post" action="https://secure.ebs.in/pg/ma/sale/pay" name="frmTransaction" id="frmTransaction" onSubmit="return validate()">
<input name="account_id" type="hidden" value="<?echo $_POST['account_id'] ?>">
     
 <input name="return_url" type="hidden" size="60" value="<? echo $_POST['return_url'] ?>" />
 <input name="mode" type="hidden" size="60" value="<? echo $_POST['mode']?>" />
  <input name="reference_no" type="hidden" value="<? echo  $_POST['reference_no'] ?>" />
  <input name="amount" type="hidden" value="<? echo $_POST['amount']?>"/>
  <input name="description" type="hidden" value="<? echo $_POST['description'] ?>" /> 
 <input name="name" type="hidden" maxlength="255" value="<? echo $_POST['name'] ?>" />
<input name="address" type="hidden" maxlength="255" value="<? echo $_POST['address'] ?>" />
<input name="city" type="hidden" maxlength="255" value="<? echo $_POST['city'] ?>" />
<input name="state" type="hidden" maxlength="255" value="<? echo $_POST['state'] ?>" />
<input name="postal_code" type="hidden" maxlength="255" value="<? echo $_POST['postal_code'] ?>" />
<input name="country" type="hidden" maxlength="255" value="<? echo $_POST['country'] ?>" />
 <input name="phone" type="hidden" maxlength="255" value="<? echo $_POST['phone'] ?>" />
   <input name="email" type="hidden" size="60" value="<? echo $_POST['email']?>" />
   <input name="secure_hash" type="hidden" size="60" value="<? echo $secure_hash;?>" />
 <input name="submitted" value="Submit" type="submit" />
 
</form>

