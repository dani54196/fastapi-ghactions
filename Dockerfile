# ---------- BASE ----------
FROM python:3.12-slim AS base

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

RUN useradd -m appuser

WORKDIR /app

COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

# ---------- DEV ----------
FROM base AS dev

RUN pip install --no-cache-dir uvicorn[standard]

# No code copy → will use volume
# CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
CMD ["fastapi", "dev", "main.py", "--host", "0.0.0.0", "--port", "8000"]


# ---------- TEST ----------
FROM base AS test

COPY requirements-dev.txt .

RUN pip install --no-cache-dir -r requirements-dev.txt

COPY . .

CMD ["pytest", "-v"]

# ---------- PROD ----------
FROM base AS prod

COPY app.py .

RUN chown -R appuser:appuser /app

USER appuser

EXPOSE 8000

CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]