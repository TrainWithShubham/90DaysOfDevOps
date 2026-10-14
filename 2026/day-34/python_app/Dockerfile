FROM python:3.11-slim

WORKDIR /app

COPY requirement.txt requirement.txt

RUN pip install -r requirement.txt

COPY . .

CMD ["python", "app.py"]
