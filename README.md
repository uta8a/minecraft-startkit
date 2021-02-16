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
