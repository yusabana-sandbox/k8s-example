## Setup

```
git clone https://github.com/yusabana-sandbox/k8s-example
git submodule init
git submodule update
```

```
% curl -O https://storage.googleapis.com/kubernetes-release/release/v1.3.4/bin/darwin/amd64/kubectl
% chmod +x kubectl
% mv kubectl /usr/local/bin/kubectl  <= PATHのあるところに移動
```

## example1

http://qiita.com/koudaiii/items/d0b3b0b78dc44d97232a
https://coreos.com/kubernetes/docs/latest/configure-kubectl.html

```
mkdir ~/.kube/
touch ~/.kube/config   # <= とりあえず設定するものがないので
```


## example2

[VagrantとCoreOSでkubernetesをMacで使ってみる　①環境構築編 - Qiita](http://qiita.com/Clip-glass/items/1eb61f983a69f22ac8e3)
[VagrantとCoreOSでkubernetesをMacで使ってみる　②サンプル実行編 - Qiita](http://qiita.com/Clip-glass/items/61077a66693c8daa0bdd)

```yaml:自動で~/.kube/configに設定が書き込まれる
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: http://172.17.8.101:8080
  name: local
contexts:
- context:
    cluster: local
    namespace: default
    user: ""
  name: local
current-context: local
kind: Config
preferences: {}
users: []
```


## example3

[vagrant + CoreOSでkubernetesのguestbookサンプルを動かす - Qiita](http://qiita.com/otakuto/items/2ef66520f8159b9a3f55)


## example4

minikube
http://kubernetes.io/docs/getting-started-guides/minikube/
http://qiita.com/tukiyo3/items/a62c59905e9d76becf15

