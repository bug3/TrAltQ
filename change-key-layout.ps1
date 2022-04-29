(Get-WinUserLanguageList).InputMethodTips > imt2.txt

$inputTip = Compare-Object (Get-Content imt.txt) (Get-Content imt2.txt) | Select-Object -ExpandProperty InputObject
$newLang = New-WinUserLanguageList tr

$newLang[0].InputMethodTips.Clear()
$newLang[0].InputMethodTips.Add($inputTip)
