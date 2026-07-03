# 保存するCSVファイルのパス
$csvPath = "C:\Users\Administrator\Desktop\diff_user.csv" 

# 3日前
$diffDate = (Get-Date).AddDays(-3) 

# 各OUのユーザー数
$ManagementCount     = (Get-ADUser -Filter * -SearchBase "OU=Management_OU,DC=corp,DC=local").Count
$GeneralAffairsCount = (Get-ADUser -Filter * -SearchBase "OU=GeneralAffairs_OU,DC=corp,DC=local").Count
$SalesCount          = (Get-ADUser -Filter * -SearchBase "OU=Sales_OU,DC=corp,DC=local").Count 
$FalseUser           = (Get-ADUser -Filter "Enabled -eq 'false'").Count
$diffLogonUser       = (Get-ADUser -Filter {LastLogonDate -lt $diffDate} -Properties LastLogonDate).Count

$Report = @(
    [PSCustomObject]@{ 項目名 = "管理部"; 人数 = $ManagementCount }
    [PSCustomObject]@{ 項目名 = "総務部"; 人数 = $GeneralAffairsCount }
    [PSCustomObject]@{ 項目名 = "営業部"; 人数 = $SalesCount }
    [PSCustomObject]@{ 項目名 = "無効ユーザー"; 人数 = $FalseUser }
    [PSCustomObject]@{ 項目名 = "三日ログオンしていないユーザー"; 人数 = $diffLogonUser }
)

$Report | Export-Csv -Path $csvPath -Encoding UTF8 -NoTypeInformation