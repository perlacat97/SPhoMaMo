TEX = xelatex
BIB = bibtex

src = 2020-GS-ARTICLE.tex
bcf = 2020-GS-ARTICLE

PDF = 2020-GS-ARTICLE.pdf
TCH = :> includes/words.txt && :> includes/char.txt
WCN = pdftotext 2020-GS-ARTICLE.pdf - | wc -c > includes/char.txt
CCN = pdftotext 2020-GS-ARTICLE.pdf - | wc -w > includes/words.txt

publish :
	$(TCH) && $(TEX) $(src) && $(BIB) $(bcf) && $(TEX) $(src) && $(TEX) $(src) && $(WCN) && $(CCN) && $(TEX) $(src) && $(TCH) && rm *.aux *.log *.bbl *.blg *.out

build :
	$(TCH) && $(TEX) $(src) && $(BIB) $(bcf) && $(TEX) $(src) && $(TEX) $(src) && $(WCN) && $(CCN) && $(TEX) $(src)

step :
	$(TCH) && $(TEX) $(src)

.PHONY: clean
clean :
	$(TCH) && rm *.aux *.log *.toc *.run.xml *.bbl *.blg *.bcf *.fdb_latexmk *.fls *.idx *.ilg *.ind *.lof *.lot *.pdf *.out
