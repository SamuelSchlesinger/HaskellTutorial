Tutorial:
	lhs2TeX -o Tutorial.tex Tutorial.lhs
	pdflatex Tutorial.tex
	rm *.aux *.log *.ptb *.tex *.out

view:
	make
	evince Tutorial.pdf

clean:
	rm *.aux *.log *.ptb *.tex *.pdf 2> /dev/null
