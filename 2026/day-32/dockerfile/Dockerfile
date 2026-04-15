# Use the official NGINX image as the base

FROM nginx:alpine

# Copy custom static content

COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 (default HTTP port)

EXPOSE 80

# Command to run NGINX in the foreground so Docker can track the process

CMD ["nginx", "-g", "daemon off;"]