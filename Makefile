SOURCES = $(wildcard *.Rmd)
TARGETS = $(SOURCES:%.Rmd=%.html)

%.html : %.Rmd
	Rscript -e 'rmarkdown::render("$<")'

default: $(TARGETS)

clean:
	rm -rf $(TARGETS)
