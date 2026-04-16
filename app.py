from fastapi import FastAPI
from datetime import datetime

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.get("/ping")
async def ping():
    return {"message": "Pong"}

@app.get("/health")
def health_check():
    return {
            "status": "ok",
            "message": "Service is running",
            "date": datetime.now().isoformat()
        }