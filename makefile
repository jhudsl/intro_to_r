LIST  = Statistics
LIST += Data_Visualization
LIST += Knitr
LIST += Data_Summarization
LIST += RStudio
LIST += Manipulating_Data_in_R
LIST += Data_Cleaning
LIST += Data_IO
LIST += Data_Classes
LIST += Simple_Knitr
LIST += Basic_R
 LIST += Functions
LIST += Knitr
LIST += Arrays_Split
LIST += Subsetting_Data_in_R
LIST += Intro
LIST += Data_Classes_summary

all:
	zip -q -r Examples/shiny_knitr.zip Examples/shiny_knitr/
	for fol in $(LIST) ; do \
		pwd && echo $$fol && cp makefile.copy $$fol/makefile && cd $$fol && make all && cd ../; \
	done
	for fol in $(LIST) ; do \
		pwd && echo $$fol && cd $$fol && cp index.pdf $$fol.pdf && cp index.html $$fol.html && cp index.R $$fol.R && cd ../; \
	done	
	echo "Running main index";
	Rscript -e "rmarkdown::render('index.Rmd')"
	# echo "Running Starting"
	# Rscript -e "rmarkdown::render('starting_with_r.Rmd')"		

labs: 
	Rscript scripts/run_labs.R	

# https://superuser.com/questions/592974/how-to-print-to-save-as-pdf-from-a-command-line-with-chrome-or-chromium

index.html: index.Rmd 
	Rscript -e "rmarkdown::render('index.Rmd')"

syllabus_files:
	Rscript -e "rmarkdown::render('./Syllabus/syllabus.Rmd', output_format = 'all')"
	echo "Running module details";
	Rscript -e "for (i in c('day0.Rmd','day1.Rmd','day2.Rmd','day3.Rmd','day4.Rmd','day5.Rmd','day6.Rmd','day7.Rmd','day8.Rmd','day9.Rmd')) {rmarkdown::render(paste('./Syllabus/module_details/',i,sep = ''))}"

starting_with_r.html: starting_with_r.Rmd 
	Rscript -e "rmarkdown::render('starting_with_r.Rmd')"	

homework: HW/homework*.Rmd 
	cd HW/ && Rscript -e "rmarkdown::render('homework2.Rmd')";
	cd HW/ && Rscript -e "rmarkdown::render('homework3.Rmd')";
	cd HW/ && Rscript -e "rmarkdown::render('homework3_key.Rmd')";
	cd HW/ && Rscript -e "rmarkdown::render('homework2_key.Rmd')";

clean: 
	rm index.html
