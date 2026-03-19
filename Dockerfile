# Imagen base mínima
FROM python:3.12-slim

# Variables de entorno
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Crear usuario no-root
RUN useradd -m appuser

# Directorio de trabajo
WORKDIR /app

# Copiar solo dependencias primero (mejor cache)
COPY requirements.txt .

# Instalar deps
RUN pip install --no-cache-dir -r requirements.txt

# Copiar app
COPY app.py .

# Cambiar ownership (importante)
RUN chown -R appuser:appuser /app

# Cambiar a usuario no-root
USER appuser

# Exponer puerto
EXPOSE 8000

# Ejecutar app
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
