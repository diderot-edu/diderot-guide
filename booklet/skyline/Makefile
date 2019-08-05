PANDOC = pandoc --verbose
PARSE = $(METAL_HOME)/dex/parse.py
MLXDEX = $(METAL_HOME)/dex/mlxdex.py
PEXIFY = python $(METAL_HOME)/dex/pexify.py
PDFLATEX = pdflatex

LATEX_PREAMBLE=../latex/twotenhwk.tex

.PHONY: phony

main.html: main.dex phony
	@mkdir -p build
	$(PEXIFY) main.dex # generates main_pandoc.tex
	@mv main_pandoc.tex build/
	cat $(LATEX_PREAMBLE) build/main_pandoc.tex > build/main_pandoc_with_preamble.tex
	$(PANDOC) -f latex --mathjax -s build/main_pandoc_with_preamble.tex > main.html

main.pdf: main.dex phony
	@mkdir -p build
	$(PEXIFY) main.dex # generates main_pandoc.tex
	@mv main_pandoc.tex build/
	cat $(LATEX_PREAMBLE) build/main_pandoc.tex > build/main_pandoc_with_preamble.tex
	$(PDFLATEX) --jobname main build/main_pandoc_with_preamble.tex

main.mlx: main.dex phony
	$(MLXDEX) main.dex $(LATEX_PREAMBLE)

phony:
