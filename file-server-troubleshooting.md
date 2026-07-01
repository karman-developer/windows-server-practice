# 障害シナリオ

- 「昨日の夜、別の管理者がManagementフォルダのアクセス権を変更したらしい。それ以降、moriだけでなくManagement_User全員がアクセスできなくなった。」

# 1. グループ存在確認

## 実行コマンド

```powershell
Get-ADGroup -Identity "Management_User"
```

## 実行結果

```text
DistinguishedName : CN=Management_User,OU=Groups_OU,DC=corp,DC=local
GroupCategory     : Security
GroupScope        : Global
Name              : Management_User
ObjectClass       : group
ObjectGUID        : 12d33f02-2b8d-4a74-ab63-2076d6410176
SamAccountName    : Management_User
SID               : S-1-5-21-1363074604-1009376980-2616276407-1322
```

## 確認結果

- Security グループとして正常に存在することを確認
- グローバルグループであることを確認

---

# 2. グループメンバー確認

## 実行コマンド

```powershell
Get-ADGroupMember -Identity "Management_User"
```

## 実行結果

```text
distinguishedName : CN=mori,OU=Management_OU,DC=corp,DC=local
name              : mori
objectClass       : user
SamAccountName    : mori

distinguishedName : CN=noda,OU=Management_OU,DC=corp,DC=local
name              : noda
objectClass       : user
SamAccountName    : noda

distinguishedName : CN=sato,OU=Management_OU,DC=corp,DC=local
name              : sato
objectClass       : user
SamAccountName    : sato
```

## 確認結果

Management_User グループに以下のユーザーが所属していることを確認。

|No|ユーザー|
|---|---|
|1|mori|
|2|noda|
|3|sato|

---

# 3. ユーザー有効状態確認

## 実行コマンド

```powershell
Get-ADUser -Identity "mori"
```

## 実行結果

```text
DistinguishedName : CN=mori,OU=Management_OU,DC=corp,DC=local
Enabled           : True
Name              : mori
ObjectClass       : user
SamAccountName    : mori
UserPrincipalName : mori@corp.local
```

## 確認結果

- mori アカウントは **有効（Enabled=True）** であることを確認。

---

# 4. SMB共有アクセス権確認

## 実行コマンド

```powershell
Get-SmbShareAccess -Name "Management"
```

## 実行結果

```text
Name        : Management
ScopeName   : *
AccountName : Everyone
AccessControlType : Allow
AccessRight : Full
```

## 確認結果

- Everyone に対して共有アクセス権（Full）が付与されていることを確認。

---

# 5. NTFSアクセス権確認

## 実行コマンド

```powershell
(Get-Acl -Path "C:\Share\Management").Access |
Format-Table IdentityReference, FileSystemRights, AccessControlType
```

## 実行結果

```text
IdentityReference        FileSystemRights AccessControlType
-----------------        ---------------- -----------------
CREATOR OWNER            FullControl      Allow
NT AUTHORITY\SYSTEM      FullControl      Allow
BUILTIN\Administrators   FullControl      Allow
CORP\Management_User     FullControl      Allow
```
