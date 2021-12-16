FROM python:3.9.5-slim-buster
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
RUN mkdir -p /opt/services/src/app/
COPY config.py rates.py requirements.txt wsgi.py /opt/services/src/app/
WORKDIR /opt/services/src/app/
RUN ls -lrt
RUN apt-get update && apt-get install -y python3-pip
RUN pip install -U gunicorn
RUN pip install -Ur requirements.txt
EXPOSE 3000
