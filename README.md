修論テンプレート
=====

## これはなに

某大学の修論のテンプレートです．


## 使い方

thesis.tex に素晴らしい論文を書きます．
PDFへの変換は [OMake](http://omake.metaprl.org/index.html)，
[GNU Make](http://www.gnu.org/software/make/)が使えます．
OMake を使うと継続監視ビルドをしてくれるので便利です．

``` bash
omake -P
```

``` bash
make
```

手動で変換するには次のようにします．

``` bash
platex -kanji=utf-8 thesis.tex
dvipdfm -p a4 thesis
```

## ライセンス
テンプレートはMITライセンスです．
[overcite.sty](http://www.ctan.org/tex-archive/macros/latex/contrib/cite) および
[pxjahyper.sty](https://github.com/zr-tex8r/PXjahyper) はそれぞれのライセンスに従います．
