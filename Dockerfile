FROM dasbastard/ulyana

RUN apt update; apt -y upgrade

RUN apt install -y build-essential \
    libssl-dev \
    zlib1g-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libgdbm-dev \
    libdb5.3-dev \
    libbz2-dev \
    libexpat1-dev \
    liblzma-dev \
    tk-dev \
    libffi-dev

RUN cd /tmp/ && \
    wget https://www.python.org/ftp/python/3.8.4/Python-3.8.4.tgz && \
    tar xzf Python-3.8.4.tgz && \
    cd Python-3.8.4 && \
    ./configure --prefix=/opt/python38 --enable-optimizations --with-lto --with-system-ffi --with-computed-gotos --enable-loadable-sqlite-extensions && \
    make -j "$(nproc)" && \
    make altinstall && \
    rm /tmp/Python-3.8.4.tgz

RUN ln -s /opt/python38/bin/python3.8 /usr/bin/python3 && \
    ln -s /opt/python38/bin/python3.8 /usr/bin/python38 && \
    ln -s /opt/python38/bin/python3.8 /usr/bin/python && \
    ln -s /opt/python38/bin/python3.8-config /usr/bin/python-config && \
    ln -s /opt/python38/bin/pydoc3.8 /usr/bin/pydoc && \
    ln -s /opt/python38/bin/idle3.8 /usr/bin/idle && \
    ln -s /opt/python38/bin/pip3.8 /usr/bin/pip3 && \
    ln -s /opt/python38/bin/pip3.8 /usr/bin/pip

RUN apt install -y apt-utils \
    aria2 \
    bash \
    build-essential \
    curl \
    figlet \
    neofetch \
    postgresql \
    pv \
    jq \
    ffmpeg \
    libxml2 \
    libssl-dev \
    wget \
    zip \
    unzip \
    rar \
    unar \
    git \
    libpq-dev \
    sudo \
    megatools

RUN sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    apt update && apt install -y google-chrome-stable

RUN wget -N https://chromedriver.storage.googleapis.com/83.0.4103.39/chromedriver_linux64.zip -P ~/ && \
    unzip ~/chromedriver_linux64.zip -d ~/ && \
    rm ~/chromedriver_linux64.zip && \
    mv -f ~/chromedriver /usr/bin/chromedriver && \
    chown root:root /usr/bin/chromedriver && \
    chmod 0755 /usr/bin/chromedriver

RUN python3 -m ensurepip && \
    pip3 install --upgrade pip setuptools && \
    pip3 install wheel

RUN pip3 install -r https://raw.githubusercontent.com/GengKapak/DCLXVI/master/requirements.txt

CMD ["bash"]
