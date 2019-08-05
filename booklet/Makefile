PDFLATEX = pdflatex
LATEX = latex

PREAMBLE = ./templates/preamble-diderot.tex
# resource paths don't seem to work
PANDOC = pandoc --verbose --mathjax -f latex


ifeq ($(OS),Windows_NT)
	MTL_HOME = ../../bin/windows
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		MTL_HOME = ../../bin/ubuntu
	endif
	ifeq ($(UNAME_S),Darwin)
		MTL_HOME = ../../bin/macos
	endif
endif


TEX2XML = $(MTL_HOME)/texml
TEX2XMLDBG = $(MTL_HOME)/texml.dbg


default: book.pdf

FORCE: 

.PHONY: book book.pdf 

clean: 
	rm *.aux *.idx *.log *.out *.toc */*.aux */*.idx */*.log */*.out 

reset: 
	make clean; rm *.pdf; rm*.html; rm  *~; rm */*~; rm  \#*\#; rm */\#*\#; 


######################################################################
## BEGIN: XML
######################################################################

%.xml : %.tex FORCE
	$(TEX2XML) -meta ./meta -preamble $(PREAMBLE) $< -o $@

%.xmldbg : %.tex
	$(TEX2XMLDBG) -meta ./meta -preamble $(PREAMBLE) $< -o $@


######################################################################
## END: XML
######################################################################

######################################################################
## BEGIN: PDF
######################################################################

book.pdf:
	$(PDFLATEX) --jobname="book" '\input{book}' ; 
	$(PDFLATEX) --jobname="book" '\input{book}' ; \


skyline.pdf : book.pdf skyline/main.tex
	$(PDFLATEX) --jobname="skyline" '\includeonly{skyline/main}\input{book}'


