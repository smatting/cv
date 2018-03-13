stefan-matting-cv.pdf: stefan-matting-cv.tex
	rubber -f --pdf -s stefan-matting-cv.tex

clean:
	rm -f *.pdf *.aux *.log
