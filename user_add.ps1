$Domain = "DC=corp,DC=local"

$DefaultPassword = ConvertTo-SecureString "XXXXXXXXXXXXXXXXXXXX-" -AsPlainText -Force

$CsvPath = "C:\Users\Administrator\Desktop\AD_NewEmployees_100.csv"

$UserList = Import-Csv -Path $CsvPath -Encoding UTF8

Write-Host "CSV from $($UserList.Count)" -ForegroundColor Yellow

foreach ($User in $UserList) {
    $TargetOU = "OU=$($User.OU),$Domain"
    $TargetGroup = $User.Group

    New-ADUser -Name $User.Name `
    -SamAccountName $User.SamAccountName `
    -AccountPassword $DefaultPassword `
    -Path $TargetOU `
    -Enabled $true `
    -ChangePasswordAtLogon $true

    Add-ADGroupMember -Identity $TargetGroup -Members $User.SamAccountName
}
