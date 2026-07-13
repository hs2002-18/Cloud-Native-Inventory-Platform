from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.database import get_db
from app.schemas.product import(
    ProductCreate, 
    ProductResponse
) 
from app.services.product_service import (
    create_product, 
    get_products
)

router = APIRouter(
    prefix="/api/v1/products",
    tags=["Products"]
)


@router.post("/", response_model=ProductResponse)
def create(product: ProductCreate, db: Session = Depends(get_db)):
    return create_product(db, product)

@router.get("/", response_model=list[ProductResponse])
def get_products_endpoint(db: Session = Depends(get_db)):
    return get_products(db)