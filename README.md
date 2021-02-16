# やりたいこと
- terraformとansibleを用いてminecraftのバックアップしておいたファイルからサーバを立ち上げるところまでをやる。
- 概要
  - terraformでGCPを立ち上げる
  - ansibleでサーバセットアップする このときのインプットはwhitelistの人間のidリストとバックアップファイル
  - IPアドレスを出力して終了
- 疑似コード

```
# terraform
- GCP instance 1
- OUTPUT: ip

# ansible
- port
- install
  - java
  - minecraft
- eula
- whitelist
- OUTPUT: success/fail
```

# log
- gcloud, tfenvを入れておく
- terraform用GCPアカウント(GCEをeditできる権限をつけておく)と、予算アラートをやっておく。

```
gcloud auth login
```

Project Nameではなく、IDを指定する。

サービスアカウント terraform を作成
```
ubuntu-1804-bionic-v20210211                          ubuntu-os-cloud  
```

https://cloud.google.com/community/tutorials/getting-started-on-gcp-with-terraform?hl=ja-JP
これよさそう

firewallとGCEはタグでつながっている

```
# ブラウザが立ち上がるのでログイン
gcloud auth login
# project idを得る
gcloud config get-value project
# terraformユーザを作って権限を渡してcredentialをjsonに出力
gcloud config set project <project-id>
gcloud iam service-accounts create terraform
# 雑にeditor権限渡しているけど本当はもっと絞るべき
gcloud projects add-iam-policy-binding <project-id> --member serviceAccount:<account> --role roles/editor
gcloud iam service-accounts keys create ./cred.json --iam-account <account>
```

```
# 初回.tfファイルがあるディレクトリで、.terraform-versionファイルがあることを確認して行う
terraform init
# どんなリソースが作られるかチェック
terraform plan
# リソースを作成(尋ねられるので、yesとタイプする)
terraform apply
# リソースを消去する(yesとタイプ)
terraform destroy
```
