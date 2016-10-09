## Setup

```
git clone https://github.com/yusabana-sandbox/k8s-example
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

### configファイルについて

`KUBECOONFIG=k8s.yaml` のように環境変数を設定することで config が `~/.kube/config` ではない設定を読み込むことができる
またはコマンド実行するときに `--kubeconfig=k8s.yaml` のようにオプションで指定することも可能。


## example2

minikube
[Minikube で簡易 kubernetes 環境構築](https://jedipunkz.github.io/blog/2016/07/25/minikube/)
http://kubernetes.io/docs/getting-started-guides/minikube/
http://qiita.com/tukiyo3/items/a62c59905e9d76becf15


## example3

CentOS7に手動でセットアップする

* [kubernetesによるDockerコンテナ管理入門 - さくらのナレッジ](http://knowledge.sakura.ad.jp/tech/3681/)


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
