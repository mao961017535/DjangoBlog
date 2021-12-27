FROM python:3
ENV PYTHONUNBUFFERED 1
WORKDIR /code/djangoblog/
RUN  apt-get install  default-libmysqlclient-dev -y && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
ADD requirements.txt requirements.txt
RUN pip3 install pip -U
RUN pip3 config set global.index-url http://mirrors.aliyun.com/pypi/simple
RUN pip3 config set install.trusted-host mirrors.aliyun.com
RUN pip install --upgrade pip  && \
        pip install -Ur requirements.txt  && \
        pip install gunicorn[gevent] && \
        pip cache purge
        
ADD . .
RUN chmod +x /code/djangoblog/bin/docker_start.sh
ENTRYPOINT ["/code/djangoblog/bin/docker_start.sh"]
