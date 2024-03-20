FROM rocker/tidyverse:latest
LABEL maintainer="avamariehoffman@gmail.com"
WORKDIR /rocker-build/

# Install apt-getable packages to start
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils dialog
RUN apt-get install -y --no-install-recommends \
    libxt6 \
    libpoppler-cpp-dev \
    vim \
    libglpk40 \
    curl \
    gpg

# Install gh
RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg;
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null;
RUN apt update && apt install -y gh;

# Uninstall old version of pandoc
RUN sudo apt-get purge pandoc pandoc-citeproc pandoc-data \
  && sudo apt-get autoremove --purge

# Install pandoc
RUN wget https://github.com/jgm/pandoc/releases/download/2.14.1/pandoc-2.14.1-1-amd64.deb \
  && sudo apt-get install ./pandoc-2.14.1-1-amd64.deb

# Create new symlinks
RUN ln -s /usr/bin/pandoc /usr/lib/rstudio-server/bin/pandoc

# Add curl, bzip2, libbz2-dev, liblzma-dev
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    bzip2 \
    curl \ 
    libbz2-dev \
    liblzma-dev
    
# Install pip3 and installation tools
RUN apt-get -y --no-install-recommends install \
   python3-pip  python3-dev

# JHUR package
RUN Rscript -e "options(warn = 2); install.packages('remotes'); remotes::install_github('muschellij2/jhur');remotes::install_github('MatthewBJane/ThemePark')"

# R packages
RUN Rscript -e  "options(warn = 2);install.packages( \
    c('bookdown', \
      'here', \
      'kableExtra', \
      'naniar', \
      'pander'), \
      repos = 'https://cloud.r-project.org/')"

# Other packages
RUN Rscript -e  "devtools::install_github('hadley/emo')"	
RUN Rscript -e  "install.packages('esquisse')"
RUN Rscript -e  "install.packages('directlabels')"
RUN Rscript -e  "install.packages('plotly')"
RUN Rscript -e  "install.packages('tidylog')"
RUN Rscript -e  "install.packages('patchwork')"
RUN Rscript -e  "install.packages('corrplot')"
RUN Rscript -e  "install.packages('broom')"
RUN Rscript -e  "install.packages('config')"
RUN Rscript -e  "install.packages('optparse')"
RUN Rscript -e  "install.packages('faraway')"
RUN Rscript -e  "install.packages('epitools')"

# Install pdflatex
RUN apt-get install -y texlive-latex-base texlive-latex-extra
RUN apt-get install -y texlive-fonts-recommended texlive-latex-recommended

# Copy over git token
COPY git_token.txt .
  
# Set final workdir for commands
WORKDIR /home/rstudio
