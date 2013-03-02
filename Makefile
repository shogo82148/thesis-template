# Copyright (c) 2012 @shogo82148
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the ``Software''), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED ``AS IS'', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

LATEX = platex
LATEXFLAGS = -kanji=utf-8 -halt-on-error
DVIPDFM = dvipdfm
DVIPDFMFLAGS = -p a4
BIBTEX = pbibtex
BIBTEXFLAGS = -kanji=utf-8
LATEXML = latexml
LATEXMLFLAGS = --preload=url.sty
LATEX2EPUB = latex2epub.rb

DOCUMENT = thesis

TEXDEPS = \
	kslab.sty \
	overcite.sty \
	pxjahyper.sty

TEXMLDEPS = \
	hyperref.sty.ltxml \
	kslab.sty.ltxml \
	overcite.sty.ltxml \
	pxjahyper.sty.ltxml

all: $(DOCUMENT).pdf

.PHONY: all archive archive-utf8 archive-sjis archive-euc
.SUFFIXES: .dvi .pdf

$(DOCUMENT).dvi: $(DOCUMENT).tex $(TEXDEPS)
	$(LATEX) $(LATEXFLAGS) $<

.dvi.pdf:
	$(DVIPDFM) $(DVIPDFMFLAGS) $<

thesis-bib.xml: thesis.bib
	$(LATEXML) $(LATEXMLFLAGS) --dest=$@ $<

thesis.epub: thesis-bib.xml thesis.yaml $(TEXDEPS) $(TEXMLDEPS)
	$(LATEX2EPUB) thesis.tex thesis.yaml

archive: archive-utf8 archive-sjis archive-euc
archive-utf8: archive-utf8.zip
archive-sjis: archive-sjis.zip
archive-euc: archive-euc.zip

archive-utf8.zip: $(DOCUMENT).tex $(TEXDEPS)
	-mkdir archive-utf8
	cp $? archive-utf8/
	zip -ju $@ archive-utf8/*

archive-sjis.zip: $(DOCUMENT).tex $(TEXDEPS)
	-mkdir archive-sjis
	for f in $?; do iconv -f UTF8 -t SJIS < $$f > archive-sjis/$$f; done
	zip -ju $@ archive-utf8/*

archive-euc.zip: $(DOCUMENT).tex $(TEXDEPS)
	-mkdir archive-euc
	for f in $?; do iconv -f UTF8 -t EUCJP < $$f > archive-euc/$$f; done
	zip -ju $@ archive-euc/*
