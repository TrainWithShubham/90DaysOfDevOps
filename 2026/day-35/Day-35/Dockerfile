# Use a minimal base image with a specific tag
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy application file
COPY app.js .

# Change ownership and switch to non-root user
RUN chown -R appuser:appgroup /app

USER appuser

# Run the application
CMD ["node", "app.js"]
