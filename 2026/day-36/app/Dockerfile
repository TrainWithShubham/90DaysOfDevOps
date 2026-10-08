FROM python:3.12 AS builder

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .


FROM python:3.12-slim AS runtime 

WORKDIR /app

RUN addgroup -S chaitya && adduser -S chaitya -G chaitya



COPY --from=builder --chown=chaitya:chaitya /app /app

USER chaitya


EXPOSE 8080

CMD ["python", "app.py"]



