# Make GUIDE_DIR point to your Diderot guide directory
GUIDE_DIR = ..
META_DIR = $(GUIDE_DIR)/meta

PDFLATEX = pdflatex
LATEX = latex

PREAMBLE = ./templates/preamble-diderot.tex
PANDOC = pandoc --mathjax -f latex


ifeq ($(OS),Windows_NT)
	DC_HOME = $(GUIDE_DIR)/bin/windows
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		DC_HOME = $(GUIDE_DIR)/bin/ubuntu
	endif
	ifeq ($(UNAME_S),Darwin)
		DC_HOME = $(GUIDE_DIR)/bin/macos
	endif
endif

DC = $(DC_HOME)/dc -meta $(META_DIR) 


default: pdf

FORCE: 

.PHONY: book html pdf

clean: 
	rm *.aux *.idx *.log *.out *.toc */*.aux */*.idx */*.log */*.out 

reset: 
	make clean; rm *.pdf; rm*.html; rm  *~; rm */*~; rm  \#*\#; rm */\#*\#; 

# Include xml rules
include $(GUIDE_DIR)/resources/makefile-xml-target

######################################################################
## BEGIN: PDF
######################################################################
book: 
	$(PDFLATEX) --jobname="book" '\input{book}' ; 
	$(PDFLATEX) --jobname="book" '\input{book}' ; \

pdf: book

## Any chapter pdf, e.g., make skyline/main.pdf
%.pdf : %.tex book
	$(PDFLATEX) --shell-escape --jobname="target" "\includeonly{$*}\input{book} ";
	mv target.pdf $@


