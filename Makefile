# BEGIN: DIDEROT SETUP

LABEL_COURSE="15000:diderotguide:f19"

## Label for textbook
LABEL_TEXTBOOK="GUIDE"

GUIDE_DIR = ./
CLI_DIR = ../diderot-cli
DIDEROT_ADMIN = $(CLI_DIR)/diderot_admin

## XML target rules
include $(GUIDE_DIR)/resources/makefile-xml-target

## CLI upload targets
include $(CLI_DIR)/resources/makefile-upload-to-diderot

# END: DIDEROT SETUP


# BEGIN: Local setup
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

## DC_HOME = ~/DC
DC = $(DC_HOME)/dc

# END: local setup


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


book:
	$(PDFLATEX) --jobname="book" '\input{book}' ; 
	$(PDFLATEX) --jobname="book" '\input{book}' ; \

%.pdf : %.tex book
	$(PDFLATEX) --shell-escape --jobname="target" "\includeonly{$*}\input{book} ";
	mv target.pdf $@

guide:
	$(PDFLATEX) --jobname="diderot-guide" '\includeonly{lms/lms, dc/dc, publish/publish, quiz/quiz, cli/cli}  \input{book}'

overview: overview/overview.xml overview/overview.pdf
upload_overview: NO=1
upload_overview: FILE=overview/overview
upload_overview: overview upload_xml_pdf

lms: lms/lms.xml lms/lms.pdf
upload_lms: NO=2
upload_lms: FILE=lms/lms
upload_lms: ATTACH=lms/media
upload_lms: lms upload_xml_pdf_attach

dc: dc/dc.xml dc/dc.pdf
upload_dc: NO=3
upload_dc: FILE=dc/dc
upload_dc: dc upload_xml_pdf

publish: publish/publish.xml publish/publish.pdf
upload_publish: NO=4
upload_publish: FILE=publish/publish
upload_publish: publish upload_xml_pdf

quiz: quiz/quiz.xml quiz/quiz.pdf
upload_quiz: NO=5
upload_quiz: FILE=quiz/quiz
upload_quiz: quiz upload_xml_pdf

cli: cli/cli.xml cli/cli.pdf
upload_cli: NO=6
upload_cli: FILE=cli/cli
upload_cli: ATTACH=cli/attachments
upload_cli: cli upload_xml_pdf_attach
