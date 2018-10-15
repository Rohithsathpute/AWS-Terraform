FROM python:3-alpine

COPY ./ /app/
WORKDIR /app
RUN pip install -r requirements.txt

CMD ["/usr/bin/env", "python", "-u", "/app/worker.py"]
