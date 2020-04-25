# Make this point to your Diderot guide directory
GUIDE_DIR = ./

PANDOC = pandoc --mathjax -f latex 
PDFLATEX = pdflatex

FLAG_VERBOSE = -v 
FLAG_DEBUG = -d

PREAMBLE = templates/preamble-diderot.tex


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

# DC_HOME = ~/DC
DC = $(DC_HOME)/dc
default: pdf

all:  guide html pdf

FORCE:

.PHONY: book

clean: 
	rm *.aux *.idx *.log *.out *.toc */*.aux */*.idx */*.log */*.out 

reset: 
	make clean; rm *.pdf; rm*.html; rm  *~; rm */*~; rm  \#*\#; rm */\#*\#; 


html: FORCE
	$(PANDOC) -s book-html.tex > book.html


######################################################################
## BEGIN: XML
######################################################################

%.xml : %.tex FORCE
ifdef debug
ifdef verbose
	$(DC) $(FLAG_DBG) $(FLAG_VERBOSE)  -meta ./meta -preamble $(PREAMBLE) $< -o $@
 else
	$(DC) $(FLAG_DBG) -meta ./meta -preamble $(PREAMBLE)  $< -o $@
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
	$(DC)  $(FLAG_DBG) $(FLAG_VERBOSE) $< -o $@
 else
	$(DC)  $(FLAG_DBG) $< -o $@
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

book:
	$(PDFLATEX) --jobname="book" '\input{book}' ; 
	$(PDFLATEX) --jobname="book" '\input{book}' ; \

%.pdf : %.tex book
	$(PDFLATEX) --shell-escape --jobname="target" "\includeonly{$*}\input{book} ";
	mv target.pdf $@

guide:
	$(PDFLATEX) --jobname="diderot-guide" '\includeonly{staff/staff, dc/dc, publish/publish, quiz/quiz, cli/cli}  \input{book}'


staff: book staff/staff.tex
	$(PDFLATEX) --jobname="staff" '\includeonly{staff/staff} \input{book}'
	cp staff.pdf staff/
dc: book dc/dc.tex
	$(PDFLATEX) --jobname="dc" '\includeonly{dc/dc} \input{book}'
	cp dc.pdf dc/
cli: book cli/cli.tex
	$(PDFLATEX) --jobname="cli" '\includeonly{cli/cli} \input{book}'
	cp cli.pdf cli/
publish: book publish/publish.tex
	$(PDFLATEX) --jobname="publish" '\includeonly{publish/publish} \input{book}'
	cp publish.pdf publish/

quiz: book quiz/quiz.tex
	$(PDFLATEX) --jobname="quiz" '\includeonly{quiz/quiz} \input{book}'
	cp quiz.pdf quiz/

student: book student/student.tex
	$(PDFLATEX) --jobname="student" '\includeonly{student/student} \input{book}'
	cp student.pdf student/

all-pdf: staff dc cli publish quiz 

all-xml: staff/staff.xml dc/dc.xml cli/cli.xml publish/publish.xml quiz/quiz.xml

######################################################################
## END: PDFs
######################################################################


