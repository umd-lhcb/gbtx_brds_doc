# Author: Yipeng Sun <syp at umd dot edu>
#
# Based on: https://tex.stackexchange.com/questions/40738/how-to-properly-make-a-latex-project
# Last Change: Thu Oct 11, 2018 at 04:43 PM -0400

# Set default programs for compiling and archiving
MAKE_TEX	:=	lualatex
ZIP_FILE	:=	gbtx_communication_doc.zip

# We assume if the generated file is newer than the source, then it is good enough.
.PHONY: all clean pack

all: gbtx_communication_doc.pdf

gbtx_communication_doc.pdf: gbtx_communication_doc.tex .git/gitHeadInfo.gin include/*
	@latexmk -pdf \
		-pdflatex="$(MAKE_TEX) -interaction=nonstopmode -synctex=1" \
		-use-make \
		-jobname=build/gbtx_communication_doc \
		gbtx_communication_doc
	@mv build/gbtx_communication_doc.pdf .
	@mv build/gbtx_communication_doc.synctex.gz .

clean:
	@rm -rf build/*

pack:
	@echo "Packing all files into a zip bundle..."
	@apack $(ZIP_FILE) ./Makefile ./README.md ./*.tex ./*.pdf ./.latexmkrc ./res
