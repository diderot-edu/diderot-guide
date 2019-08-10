PDFLATEX = pdflatex
LATEX = latex
PREAMBLE = templates/preamble-diderot.tex
FLAG_VERBOSE = -v 

ifeq ($(OS),Windows_NT)
	DC_HOME = ./bin/windows
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		DC_HOME = ./bin/ubuntu
	endif
	ifeq ($(UNAME_S),Darwin)
		DC_HOME = ./bin/macos
	endif
endif

# DC_HOME = ~/DC
DC = $(DC_HOME)/dc
DC_DBG = $(DC_HOME)/dc.dbg
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
	$(DC_DBG) $(FLAG_VERBOSE)  -meta ./meta -preamble $(PREAMBLE) $< -o $@
 else
	$(DC_DBG)  -meta ./meta -preamble $(PREAMBLE)  $< -o $@
endif
else
ifdef verbose
	$(DC) $(FLAG_VERBOSE)  -meta ./meta -preamble $(PREAMBLE) $< -o $@
 else
	$(DC)  -meta ./meta -preamble $(PREAMBLE)  $< -o $@
endif
endif

%.xml : %.md FORCE
ifdef debug
ifdef verbose
	$(DC_DBG) $(FLAG_VERBOSE) $< -o $@
 else
	$(DC_DBG) $< -o $@
endif
else
ifdef verbose
	$(DC) $(FLAG_VERBOSE) $< -o $@
 else
	$(DC) $< -o $@
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



