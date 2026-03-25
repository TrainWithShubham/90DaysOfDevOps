FROM ubuntu:latest

WORKDIR /app

COPY file.txt .

RUN apt-get update && apt-get install -y curl

EXPOSE 8080

CMD ["bash", "-c", "echo Running container && cat file.txt"]