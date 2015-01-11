# make -f Makefile_latex

R = paper
STY = *.cls
FIG = images/*.eps

pdf: $(R).pdf

$(R).bbl: *.bib
	latex $(R).tex
	bibtex $(R)
	bibtex $(R)
	latex $(R).tex
	latex $(R).tex

$(R).ps: *.tex $(STY)
	latex $(R)
	dvips -Ppdf -G0 -t letter $(R)

$(R).pdf: $(R).ps
	ps2pdf -dPDFSETTINGS=/prepress \
	-dCompatibilityLevel=1.4 \
	-dAutoFilterColorImages=false \
	-dAutoFilterGrayImages=false \
	-dColorImageFilter=/FlateEncode \
	-dGrayImageFilter=/FlateEncode \
	-dMonoImageFilter=/FlateEncode \
	-dDownsampleColorImages=false \
	-dDownsampleGrayImages=false $(R).ps $(R).pdf

clean:
	rm -f $(R).log $(R).aux $(R).bbl $(R).blg $(R).dvi $(R).ps $(R).out
