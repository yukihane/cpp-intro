# 江添亮の入門C++

~~まだ書きかけ。~~

~~モチベーション維持のために公開~~

江添氏はそんなことを言っていますが、実際には既に出版されています。

GitHub Pagesでの閲覧

<https://ezoeryou.github.io/cpp-intro/>

## PDFはどこ？
上の[Releases](https://github.com/yukihane/cpp-intro/releases)にあります。
Releaseを `Publish` すると、GitHub Actionsで以下の2つが自動生成され、Release assetsに添付されます。

- `cpp-intro.pdf`
  - 元の版面サイズのPDFです。
  - フォント埋め込み済みで、印刷向けの利用を想定しています。
- `cpp-intro-view.pdf`
  - `cpp-intro.pdf` をベースに、ページサイズを調整して余白を詰めた閲覧向けPDFです。
  - フォント埋め込み済みで、スマートフォンやタブレットでの閲覧を想定しています。

元のレポジトリではPDFファイルが転がってなかったので、いくつかの欠損ファイル(*.eps)を補完してPDFを作成しました。
難しい事を考えなくてもダウンロードして普通に使えます

現在のPDF生成は Docker 経由を前提にしています。
ビルド手順は `TeX/jcompile.sh` に集約されており、`uplatex` / `mendex` / `dvipdfmx` を実行した後、`cpp-intro-view.pdf` を生成します。

## 問題
フォントが出版版と少し違うようです。
「中ゴシックBBB」や「リュウミンライト」とかのフォントは持っていません。

図版(6点)を書き直したので若干違いがあるようです。

何より目立つのが、表紙を作り直したことです。
インパクトのある例の顔写真が利用できないので、動きをランダム生成した[デッサン人形モデル](https://github.com/kurema/RhinoArchitecturalLibrary)で代用しました。

トンボ付きのPDFなんて欲しい人はいないと思うので、トンボは削除しています。
トンボ付きにしたければTeX/cpp-intro.texの```%\Tombowtrue```周りを編集してください。
ただし、表紙がずれると思います。

## DockerでPDFをビルド
DockerとDocker Composeが使える環境で、以下を実行してください。

PDF生成:

```bash
UID=$(id -u) GID=$(id -g) docker compose run --build --rm pdf-builder
```

生成されたPDFは以下の2種類です。

- `TeX/cpp-intro.pdf` (元の版面のまま。印刷向け)
- `TeX/cpp-intro-view.pdf` (閲覧向け。ページサイズ調整で余白を詰めた版)

`TeX/jcompile.sh` の手順（`uplatex` / `mendex` / `dvipdfmx`）をそのままコンテナ内で実行します。
既存の `sleep 1` もそのまま利用します。閲覧向けPDFの余白量は
`TeX/jcompile.sh` 内の `VIEW_TRIM_*` / `VIEW_PAGE_*` 変数で調整できます。

`make` 経由で実行する場合は以下でも同じです。

```bash
make pdf-docker-build
make pdf-docker
```

## 紙の本が欲しい
紙の本は[こちら](https://www.amazon.co.jp/dp/4048930710/)から入手できます。
またはお近くの適当な書店まで。

## アプリ版が欲しい
Androidアプリ版を作ろうとしています。
あなたがこれを読んでる頃には飽きて開発を止めてたり、リリースされていたりするかもしれません。

## Thanks
[源ノ角ゴシック](https://github.com/adobe-fonts/source-han-sans)と[源ノ明朝](https://github.com/adobe-fonts/source-han-serif)を利用しています。

## ライセンス

GPLv3
