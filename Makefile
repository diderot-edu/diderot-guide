PDFLATEX = pdflatex
LATEX = latex

FLAG_VERBOSE = -v 

PREAMBLE = templates/preamble-diderot.tex
PANDOC = pandoc --verbose --mathjax -f latex


ifeq ($(OS),Windows_NT)
	MTL_HOME = ./bin/windows
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		MTL_HOME = ./bin/ubuntu
	endif
	ifeq ($(UNAME_S),Darwin)
		MTL_HOME = ./bin/macos
	endif
endif


TEX2XML = $(MTL_HOME)/dc -meta ./meta
TEX2XML_DBG = $(MTL_HOME)/dc.dbg ./meta


default: guide

FORCE: 

.PHONY: guide 

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
	$(TEX2XML_DBG) $(FLAG_VERBOSE) $< -preamble $(PREAMBLE) -o $@
 else
	$(TEX2XML_DBG) $< -preamble $(PREAMBLE) -o $@
endif
else
ifdef verbose
	$(TEX2XML) $(FLAG_VERBOSE) $< -preamble $(PREAMBLE) -o $@
 else
	$(TEX2XML) $< -preamble $(PREAMBLE) -o $@
endif
endif


######################################################################
## END: XML
######################################################################

######################################################################
## BEGIN: PDF
######################################################################

guide:
	$(PDFLATEX) --jobname="guide" '\input{book}' ; 
	$(PDFLATEX) --jobname="guide" '\input{book}' ; \



