#FROM debian:8
FROM ubuntu

RUN apt-get update
RUN apt-get install -y libxml2-dev libxslt1-dev libpq-dev libffi-dev python python-dev python-distribute python-pip python-psycopg2
RUN easy_install pip
RUN pip install setuptools

COPY . /app
WORKDIR /app

RUN python setup.py install

EXPOSE 80
EXPOSE 443

#ENV DEBUG *
ENTRYPOINT ["newslynx"]
CMD ["runserver", "-d"]
