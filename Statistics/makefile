all: Statistics.html Statistics.R Statistics.pdf
    
Statistics.html: Statistics.Rmd 
	Rscript -e "rmarkdown::render('Statistics.Rmd', output_format = 'all')"

Statistics.pdf: Statistics.html Statistics.Rmd 
	electron-pdf Statistics.html Statistics.pdf --landscape

Statistics.R: Statistics.Rmd
	Rscript -e "knitr::purl('Statistics.Rmd')"

clean: 
	rm Statistics.html Statistics.R Statistics.pdf
