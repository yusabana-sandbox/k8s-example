## Setup

https://git-scm.com/book/ja/v2/Git-のさまざまなツール-サブモジュール

```
git clone https://github.com/yusabana-sandbox/k8s-example
cd k8s-example
git submodule init
git submodule update
```

kubectlコマンドを入れる

```
% curl -O https://storage.googleapis.com/kubernetes-release/release/v1.3.4/bin/darwin/amd64/kubectl
% chmod +x kubectl
% mv kubectl /usr/local/bin/kubectl  <= PATHのあるところに移動
```

```
curl -k -o kubectl https://kuar.io/darwin/kubectl && chmod +x kubectl && sudo mv kubectl /usr/local/bin/

kubectl get nodes
nodeが出力される
```


### DockerContainerの配備場所

* AWS の ECR https://aws.amazon.com/jp/ecr/

## example1

CoreOSをベースにkubernetesのクラスタ環境を構築する
* [vagrant + CoreOSでkubernetesのguestbookサンプルを動かす - Qiita](http://qiita.com/otakuto/items/2ef66520f8159b9a3f55)
* [coreos-kubernetes/kubernetes-on-vagrant.md at master · coreos/coreos-kubernetes](https://github.com/coreos/coreos-kubernetes/blob/master/Documentation/kubernetes-on-vagrant.md)

* Guestbookのサンプルドキュメント
  * [kubernetes/README.md at release-1.4 · kubernetes/kubernetes](https://github.com/kubernetes/kubernetes/blob/release-1.4/examples/guestbook/README.md)


### example1でクラスタ環境を作る coreos-kubernetesの実行
[coreos/coreos-kubernetes](https://github.com/coreos/coreos-kubernetes/) を設定するためには以下の記事を参照

https://coreos.com/kubernetes/docs/latest/kubernetes-on-vagrant.html

config.rbなどを設定する

#### configファイルについて

`KUBECONFIG=k8s.yaml` のように環境変数を設定することで config が `~/.kube/config` ではない設定を読み込むことができる
またはコマンド実行するときに `--kubeconfig=k8s.yaml` のようにオプションで指定することも可能。

```
export KUBECONFIG="${KUBECONFIG}:$(pwd)/kubeconfig"
kubectl config use-context vagrant-multi
```

config関連の設定を入れる

```
kubectl config set-cluster vagrant-multi-cluster --server=https://172.17.4.101:443 --certificate-authority=${PWD}/ssl/ca.pem
kubectl config set-credentials vagrant-multi-admin --certificate-authority=${PWD}/ssl/ca.pem --client-key=${PWD}/ssl/admin-key.pem --client-certificate=${PWD}/ssl/admin.pem
kubectl config set-context vagrant-multi --cluster=vagrant-multi-cluster --user=vagrant-multi-admin
kubectl config use-context vagrant-multi

# 以下の通りコマンドの結果が出力されれば完了
kubectl get nodes
```

### wantedlyのサンプル
http://qiita.com/koudaiii/items/d0b3b0b78dc44d97232a
https://github.com/koudaiii/docker-hello-world

### vagrant upすると次のエラーが出たので対処

```
% vagrant up
dyld: Library not loaded: /vagrant-substrate/staging/embedded/lib/libssl.1.0.0.dylib
  Referenced from: /opt/vagrant/embedded/bin/openssl
    Reason: image not found
    ./../../lib/init-ssl-ca: line 32: 25165 Trace/BPT trap: 5       $OPENSSL genrsa -out "$OUTDIR/ca-key.pem" 2048
    failed generating SSL artifacts
```

```
refs. https://github.com/mitchellh/vagrant/issues/7747
% sudo ln -sf /usr/local/opt/openssl/bin/openssl /opt/vagrant/embedded/bin/openssl
```


## example2

* minikube
  * http://kubernetes.io/docs/getting-started-guides/minikube/
  * [Minikube で簡易 kubernetes 環境構築](https://jedipunkz.github.io/blog/2016/07/25/minikube/)
  * [minikubeでローカルKubernetes クラスタを作成してみた - Qiita](http://qiita.com/tukiyo3/items/a62c59905e9d76becf15)


### インストール

https://github.com/kubernetes/minikube/releases

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.11.0/minikube-darwin-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/

minikube start

```

以下を実行して ~/.kube/config の minikube の context を利用する用に設定する

```
kubectl config use-context minikube
```

minikubeのビルトインしているDocker関連を操作できる。

```
eval $(minikube docker-env)
```

Dockerレジストリの用意がない場合はminikubeのホスト上で `docker build` して利用する。
その場合の注意として kubernetes は `:latest` タグの付いたものだとpullしようとするので、バージョンを固定する必要がある




## example3

CentOS7に手動でセットアップする

* [kubernetesによるDockerコンテナ管理入門 - さくらのナレッジ](http://knowledge.sakura.ad.jp/tech/3681/)

* [KubernetesをCentOS7 1台(AWS EC2)へインストール - Qiita](http://qiita.com/suzukihi724/items/4e120fdc66b014cfa972)
* [KubernetesをCentOS7 複数台(AWS EC2)へインストール - Qiita](http://qiita.com/suzukihi724/items/d3270121009120f9c9f0#_reference-f604af05b4df0ae3c065)


## example4

公式の手順

### pre-releaseを入れて試す
http://kubernetes.io/docs/getting-started-guides/binary_release/

* kubernetesのpre-releaesを入れるなら homebrew だけでも入れられる

```
http://kubernetes.io/docs/getting-started-guides/binary_release/#prebuilt-binary-release
brew install kubernetes-cli
```

* http://kubernetes.io/docs/getting-started-guides/binary_release/#download-kubernetes-and-automatically-set-up-a-default-cluster
  * bash script でkubernetesを入れつつデフォルトクラスタをセットアップする

```
export KUBERNETES_PROVIDER=YOUR_PROVIDER; curl -sS https://get.k8s.io | bash
```

## example5

[Kubernetes: クラスタ構築が簡単になるkubeadm - Qiita](http://qiita.com/tkusumi/items/5908c91807107551e796)
