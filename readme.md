
# Windows Server / Active Directory 学習・検証項目

## 環境
- PC（32GB / 1TB NVMe）
- Windows 11 Pro
- Hyper-V有効
- 外部仮想スイッチ作成
- Dドライブ（約750GB）
- Hyper-V用フォルダー整理
- Windows Server 2022 & 11 ISO準備

## 仮想環境
- VirtualBox上にWindows Server環境を構築
- Windowsクライアントを用意して検証環境を構築

## Active Directory
- Active Directory Domain Services（AD DS）の構築
- ドメインコントローラー（DC）の構築
- DNSサーバーの構築
- ホストオンリーアダプターを利用した内部ネットワークの構築
- NATとホストオンリーアダプターを組み合わせたネットワーク構成
- ドメイン参加
- OUの作成・管理
- ユーザーアカウントの作成・管理
- グループの作成・管理

## ファイルサーバー
- ファイルサーバーの構築
- 共有フォルダーの作成
- 共有アクセスの確認
- （必要に応じて）共有アクセス権・NTFSアクセス権の設定と確認

## PowerShell
### Active Directory コマンド
- `Get-ADUser`
- `Get-ADComputer`
- `Get-ADGroup`
- `Get-ADOrganizationalUnit`

### 操作・実践
- ユーザー情報の取得
- `Enabled` の確認
- `DistinguishedName` の確認
- ユーザー100件一括追加（初回パスワード変更付）
- ユーザー名に特定の文字列が入っているユーザーを一括削除

## トラブルシューティング
- ADユーザー作成時のエラー対応
- ユーザーが有効かどうかの確認
- OUの所属確認
- グループ所属の確認
- PowerShellによる原因調査

