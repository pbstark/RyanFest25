SLIDES := $(patsubst %.md,%.md.slides.pdf,$(wildcard *.md))
HANDOUTS := $(patsubst %.md,%.md.handout.pdf,$(wildcard *.md))

all : $(SLIDES) $(HANDOUTS)

%.slides.pdf : %.md
	pandoc $^ -t beamer --template template-beamer.tex --slide-level 2 -o $@ 
	
%.slides.tex : %.md
	pandoc $^ -t beamer --template template-beamer.tex --slide-level 2 -o $@ 


%.handout.pdf : %.md
	pandoc $^ -t beamer --slide-level 2 -V handout -o $@ 
	pdfnup $@ --nup 1x2 --no-landscape --keepinfo \
		--paper letterpaper --frame true --scale 0.9 \
		--suffix "nup"
	mv $*.md.handout-nup.pdf $@
		

clobber : 
	rm -f $(SLIDES)
	rm -f $(HANDOUTS)
