FROM python:3.10-slim-buster

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip \
    && pip install -r requirements.txt

RUN useradd -m -u 1000 -s /bin/bash django_user

RUN chmod +x docker-entrypoint.sh

USER django_user

CMD [ "sh", "docker-entrypoint.sh" ]
