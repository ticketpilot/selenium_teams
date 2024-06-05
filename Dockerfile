FROM ubuntu:latest
RUN apt-get update
RUN apt-get install gnupg wget unzip -y
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
RUN apt update
RUN apt-get install google-chrome-stable -y

RUN wget https://storage.googleapis.com/chrome-for-testing-public/125.0.6422.141/linux64/chromedriver-linux64.zip
RUN unzip chromedriver-linux64.zip
RUN mv chromedriver-linux64/chromedriver /usr/bin/chromedriver
RUN chmod +x /usr/bin/chromedriver

RUN useradd -rm -d /home/teams_scrape -s /bin/bash -g root -G sudo -u 1001 teams_scrape


SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN echo 'teams_scrape:teams_scrape' | chpasswd

USER teams_scrape
WORKDIR /home/teams_scrape

#RUN rm -r ~/miniconda3
RUN mkdir -p ~/miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
RUN bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
RUN rm -rf ~/miniconda3/miniconda.sh
RUN ~/miniconda3/bin/conda init bash
RUN source ~/.bashrc
RUN ~/miniconda3/bin/conda install pip
RUN ~/miniconda3/bin/pip install  keyboard selenium==4.9.0
EXPOSE
