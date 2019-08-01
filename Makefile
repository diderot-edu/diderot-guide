PDFLATEX = pdflatex
LATEX = latex
WWW-BOOK = ~/Google\ Drive/algorithms-book

PREAMBLE = ./preamble.tex

MTL_HOME = ~/MTL
#MTL_HOME = ../main-s19/MTL/bin

LABELTEX = $(MTL_HOME)/texel
TEX2XML = $(MTL_HOME)/texml -v -meta ./meta
TEX2XMLDBG = $(MTL_HOME)/texml.dbg

FORCE: 

.PHONY: book html book-www book.pdf 


#	printf '%s\n' '\def\targethtml{}' >> book-html.tex
html: FORCE
	$(PANDOC) -s book-pandoc.tex > book.html
#	rm book-html.tex

%_led.tex : %.tex FORCE
	$(LABELTEX) $<  -o $@

%.xml : %.tex FORCE
	$(TEX2XML) -preamble $(PREAMBLE)  $< -o $@

%.xmldbg : %.tex
	$(TEX2XMLDBG) $< -preamble $(PREAMBLE) -o $@

clean: 
	rm *.aux *.idx *.log *.out *.toc */*.aux */*.idx */*.log */*.out 

reset: 
	make clean; rm *.pdf; rm*.html; rm  *~; rm */*~; rm  \#*\#; rm */\#*\#; 

