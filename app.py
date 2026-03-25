from fastapi import FastAPI
from datetime import datetime

app = FastAPI()

@app.get("/")
async def root():
    return {"message": "Hello World Live 2"}

@app.get("/health")
def health_check():
    return {
            "status": "ok",
            "message": "Serice is running",
            "date": datetime.now().isoformat()
        }