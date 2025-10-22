# Ubuntu 24.04 dockerized build environment for Pagerank ARI2025 submission
#
#
FROM ubuntu:24.04
#
ENV TZ="America/New_York"
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
#
RUN apt-get update \
    && apt-get install -y locales \
    && apt-get install -y python3 python3-pip python3-dev python3-numpy python3-scipy build-essential git cmake cython3 python3.12-venv \
    && apt-get install -y sudo screen tmux nano wget coreutils unrar \
    && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG=en_US.utf8

#
# customize the shell prompt
#
RUN echo "" >> ~/.bashrc
RUN echo "parse_git_branch()" >> ~/.bashrc
RUN echo "{" >> ~/.bashrc
RUN echo " git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'" >> ~/.bashrc
RUN echo "}" >> ~/.bashrc
RUN echo "" >> ~/.bashrc
RUN echo "PS1=\"pagerank_reproenv \[\e[32m\]\w\[\e[91m\] \\\$(parse_git_branch)\[\e[00m\] $ \"" >> ~/.bashrc
RUN echo "" >> ~/.bashrc
#
# change the default directory
#
RUN echo "cd /pagerank" >> ~/.bashrc
RUN echo "" >> ~/.bashrc
#
# EOF
#
