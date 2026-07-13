from fastapi import FastAPI

from app.config import (
    APP_NAME,
    APP_VERSION
)
from app.database import initialise_database

app = FastAPI(
    title=APP_NAME,
    version=APP_VERSION
)

@app.on_event("startup")
def startup():
    initialise_database

@app.get("/")
def root():
    return {
        "message": "Welcome to {APP_NAME}",
        "version":  APP_VERSION
    }