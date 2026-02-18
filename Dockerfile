# ── Build stage ──────────────────────────────────────────────────────────────
FROM python:3.12-slim AS base

# Keeps Python from buffering stdout/stderr so logs appear immediately
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1

WORKDIR /app

# Install dependencies first (better layer caching)
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the source
COPY bridge.py ./

# ── Runtime ───────────────────────────────────────────────────────────────────
# The container expects a .env file to be bind-mounted (or env vars to be
# injected by docker-compose / your orchestrator). No secrets are baked in.
CMD ["python", "bridge.py"]