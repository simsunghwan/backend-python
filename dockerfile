FROM python:3.9

ENV PYTHONIOENCODING=utf-8

WORKDIR /app

COPY ./app .

RUN apt-get update && apt-get install -y \
  mecab \
  mecab-ipadic-utf8 \
  libmecab-dev
RUN cp /etc/mecabrc /usr/local/etc/

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install gunicorn
RUN pip install update

EXPOSE 5000
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]