#FROM jenkins:2.60.3
#FROM jenkins/jenkins:2.263.1
FROM jenkins/jenkins:2.277.4

USER root

#RUN  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys AA8E81B4331F7F50
RUN rm /etc/apt/sources.list.d/github_git-lfs.list
RUN  apt-get update \ 
     && apt-get install -y apt-transport-https \ 
        ca-certificates \
        curl \
        gnupg-agent \ 
        sudo \
        software-properties-common \
     && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
     && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - \ 
     && apt-get update \
     && apt-get install -y docker-ce \
     && rm -rf /var/lib/apt/lists/* 

RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers 

#RUN curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-'uname -s'-'uname -m' > /usr/local/bin/docker-compose ; chmod +x /usr/local/bin/docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose ; chmod +x /usr/local/bin/docker-compose

USER jenkins

COPY plugins.txt /usr/share/jenkins/plugins.txt
#RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt
