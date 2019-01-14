GCC
===

構成
----

```
/gcc/
├─bin/
├─lib/
└─build_gcc/
    ├─archives/               ←tarballダウンロード先
    ├─build/                  ←tビルド作業ディレクトリ
    ├─docker/
    │  ├─centos6/
    │  │  ├─Dockerfile
    │  │  └─opt/gcc-x.x.x/
    │  ├─ubuntu1404/
    │  │  ├─Dockerfile
    │  │  └─opt/gcc-x.x.x/
    │  └─docker-compose.yml
    ├─log/                    ←ビルド結果のログ出力
    └─scripts/
        ├─build-all.sh        ←ビルドスクリプト（個別のビルドスクリプトを全て実行する）
        ├─build-common.sh     ←共通設定用のスクリプト（個別のビルドスクリプトから呼び出される）
        ├─build-gmp.sh
        ├─build-mpfr.sh
        ├─build-mpc.sh
        ├─build-isl.sh
        └─build-gcc.sh

```


ビルド＆インストール
--------------------

```sh
$ ./scripts/build-all.sh
```

スクリプトテスト
----------------

異なるLinuxディストリビューションでのスクリプトの動作検証を行うため、
dockerでビルドとインストールを実行できるようにした。

```sh
$ cd docker
$ ./build.sh centos6
$ ./build.sh ubuntu1404
```
