```
cd ~/.ssh
ssh-keygen -t rsa -b 4096
# minecraft-gcp という名前のsshkeyを作ります
```
- `~/.ssh/config`は以下のようになる
```
Host mc
    User <var.tfで決めたusername>
    HostName <terraform applyのoutputで見えるip>
    IdentityFile ~/.ssh/minecraft-gcp
```
- これで `ssh mc` でアクセスできるようになる。
- (別サーバにアクセスする時、キーを使い回すので警告が出るが、毎回サーバを消しているなら使い回しにならないので無視して警告に従い登録し直すとよい。)