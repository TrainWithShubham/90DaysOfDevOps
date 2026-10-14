FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY index.html .

RUN echo "hey devops" > hello.txt


CMD ["nginx", "-g", "daemon off;"]

