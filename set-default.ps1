$inputTip = "041F:0000041F"
$newLang = New-WinUserLanguageList tr

$newLang[0].InputMethodTips.Clear()
$newLang[0].InputMethodTips.Add($inputTip)

Set-WinUserLanguageList $newLang -Force
Set-WinDefaultInputMethodOverride -InputTip $inputTip -Force
