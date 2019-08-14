PDFLATEX = pdflatex
LATEX = latex
FLAG_VERBOSE = -v 

PREAMBLE = ./templates/preamble-diderot.tex
# resource paths don't seem to work
PANDOC = pandoc --mathjax -f latex


ifeq ($(OS),Windows_NT)
	DC_HOME = ../bin/windows
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		DC_HOME = ../bin/ubuntu
	endif
	ifeq ($(UNAME_S),Darwin)
		DC_HOME = ../bin/macos
	endif
endif


DC = $(DC_HOME)/texml -meta ./meta
DCDBG = $(DC_HOME)/texml.dbg -meta ./meta 


default: book.pdf

FORCE: 

.PHONY: book book.pdf 

html: FORCE
	$(PANDOC) -s book-html.tex > book.html

clean: 
	rm *.aux *.idx *.log *.out *.toc */*.aux */*.idx */*.log */*.out 

reset: 
	make clean; rm *.pdf; rm*.html; rm  *~; rm */*~; rm  \#*\#; rm */\#*\#; 


######################################################################
## BEGIN: XML
######################################################################

%.xml : %.tex FORCE
ifdef debug
ifdef verbose
	$(DC_DBG) $(FLAG_VERBOSE) $< -preamble $(PREAMBLE) -o $@
 else
	$(DC_DBG) $< -preamble $(PREAMBLE) -o $@
endif
else
ifdef verbose
	$(DC) $(FLAG_VERBOSE) $< -preamble $(PREAMBLE) -o $@
 else
	$(DC) $< -preamble $(PREAMBLE) -o $@
endif
endif


######################################################################
## END: XML
######################################################################

######################################################################
## BEGIN: PDF
######################################################################
book: 
	$(PDFLATEX) --jobname="book" '\input{book}' ; 
	$(PDFLATEX) --jobname="book" '\input{book}' ; \

book.pdf: book



skyline.pdf : book.pdf skyline/main.tex
	$(PDFLATEX) --jobname="skyline" '\includeonly{skyline/main}\input{book}'


