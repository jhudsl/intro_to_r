all: index.html index.R index.pdf
    
index.html: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd', output_format = 'all')"

index.pdf: index.html index.Rmd 
	Rscript -e 'pagedown::chrome_print("index.html")'
	#electron-pdf index.html index.pdf --landscape

index.R: index.Rmd
	Rscript -e "knitr::purl('index.Rmd')"

lab/*.R: lab/*.Rmd
	Rscript -e "knitr::purl('index.Rmd')"	

clean: 
	rm index.html index.R index.pdf
