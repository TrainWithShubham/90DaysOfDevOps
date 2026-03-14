FROM nginx:latest

RUN apt-get update

WORKDIR /app

COPY index.html .

EXPOSE 80

CMD ["nginx","-g","daemon off;"]
