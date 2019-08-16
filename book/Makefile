PDFLATEX = pdflatex
PANDOC = pandoc --mathjax -f latex 

FLAG_VERBOSE = -v 
PREAMBLE = ./templates/preamble-diderot.tex

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

DC = $(DC_HOME)/dc -meta ./meta
DC_DBG = $(DC_HOME)/dc.dbg -meta ./meta

default: pdf

FORCE: 

.PHONY: book html pdf 

html: FORCE
	$(PANDOC) -s book-html.tex > book.html


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

clean: 
	rm *.aux *.idx *.log *.out *.toc */*.aux */*.idx */*.log */*.out 

reset: 
	make clean; rm *.pdf; rm*.html; rm  *~; rm */*~; rm  \#*\#; rm */\#*\#; 



######################################################################
## BEGIN: PDFs
######################################################################

book:
	$(PDFLATEX) --jobname="book" '\input{book}' ; 
	$(PDFLATEX) --jobname="book" '\input{book}' ; \

pdf: book


## Probability
probability: book probability/theory.tex probability/randomvars.tex probability/expectation.tex
	$(PDFLATEX) --jobname="probability" '\includeonly{probability/part, probability/theory, probability/randomvars, probability/expectation} \input{book}'

## Graph-Contraction
graph-contraction: book graph-contraction/contraction.tex  graph-contraction/edge.tex  graph-contraction/star.tex graph-contraction/connectivity.tex

	$(PDFLATEX) --jobname="graph-contraction" '\includeonly{graph-contraction/part, graph-contraction/introduction, graph-contraction/edge, graph-contraction/star, graph-contraction/connectivity} \input{book}'


######################################################################
## END: PDFs
######################################################################
