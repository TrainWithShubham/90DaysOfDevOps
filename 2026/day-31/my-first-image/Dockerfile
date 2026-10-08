# start my image using ubuntu base image
FROM ubuntu

#this create working dir inside container
WORKDIR /app

#copy everything from my laptopn to current working container's directory
COPY . .

#update Ubuntu packages and install curl, run execute while building image, not while starting container
RUN apt-get update && apt-get install -y curl

# this run when container start
CMD ["echo","Hello Firiends"]