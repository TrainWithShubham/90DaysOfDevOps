# 1. Use a minimal, specific, trusted base image
FROM python:3.11.8-alpine3.19

# 2. Metadata labeling (best practice for maintainability)
LABEL maintainer="SUMIT" \
      version="1.0" \
      description="Optimized Python application"

# 3. Environment variables (prevent Python cache, ensure clean logs)
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# 4. Create non-root user early
RUN addgroup -S flask && adduser -S python -G flask

# 5. Set working directory
WORKDIR /app

# 6. Install system dependencies (only if needed)
# Combine RUN commands + cleanup
RUN apk add --no-cache build-base

# 7. Copy dependency file first (layer caching optimization)
COPY requirements.txt .

# 8. Install dependencies without cache
RUN pip install --no-cache-dir -r requirements.txt

# 9. Copy only necessary files (use .dockerignore!)
COPY . .

# 10. Adjust ownership (security)
RUN chown -R python:flask /app

# 11. Switch to non-root user
USER python

# 12. Expose only required port
EXPOSE 8000

# 13. Use exec form CMD (best signal handling)
CMD ["python", "app.py"]
