from fastapi import FastAPI
from prometheus_fastapi_instrumentator import Instrumentator

from app.routers.health import router as health_router
from app.routers.products import router as product_router
from app.logger import logger
from app.database import Base, engine
from app.config import (
    APP_NAME,
    APP_VERSION
)


app = FastAPI(
    title=APP_NAME,
    version=APP_VERSION
)
Instrumentator().instrument(app).expose(app)

@app.on_event("startup")
def startup():
    Base.metadata.create_all(bind=engine)
    logger.info("Inventory Platform started successfully.")

app.include_router(health_router)
app.include_router(product_router)

@app.get("/")
def root():
    return {
        "message": "Welcome to {APP_NAME}",
        "version":  APP_VERSION
    }