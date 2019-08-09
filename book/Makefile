PDFLATEX = pdflatex
LATEX = latex

PREAMBLE = ./templates/preamble-mtl.tex
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

DC = $(MTL_HOME)/texml
DC_DBG = $(MTL_HOME)/texml.dbg

default: book

FORCE: 

.PHONY: book html book.pdf 


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
## PDFs


book:
	$(PDFLATEX) --jobname="book" '\input{book}' ; 
	$(PDFLATEX) --jobname="book" '\input{book}' ; \


book.pdf: book

## Probability
probability: book probability/theory.tex probability/randomvars.tex probability/expectation.tex
	$(PDFLATEX) --jobname="probability" '\includeonly{probability/part, probability/theory, probability/randomvars, probability/expectation} \input{book}'

## Graph-Contraction
graph-contraction: book graph-contraction/contraction.tex  graph-contraction/edge.tex  graph-contraction/star.tex graph-contraction/connectivity.tex

	$(PDFLATEX) --jobname="graph-contraction" '\includeonly{graph-contraction/part, graph-contraction/introduction, graph-contraction/edge, graph-contraction/star, graph-contraction/connectivity} \input{book}'

