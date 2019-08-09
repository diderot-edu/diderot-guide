PDFLATEX = pdflatex
LATEX = latex

FLAG_VERBOSE = -v 

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


DC = $(MTL_HOME)/dc


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
	$(DC) $(FLAG_VERBOSE)  -meta ./meta $<) -o $@
 else
	$(DC)  -meta ./meta $< -o $@
endif
else
ifdef verbose
	$(DC) $(FLAG_VERBOSE)  -meta ./meta $< -o $@
 else
	$(DC)  -meta ./meta $< -o $@
endif
endif

%.xml : %.md FORCE
ifdef debug
ifdef verbose
	$(DC) $(FLAG_VERBOSE) $< -o $@
 else
	$(DC) $< -o $@
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



