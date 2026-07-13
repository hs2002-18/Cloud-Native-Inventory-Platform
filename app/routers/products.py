from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.schemas.product import(
    ProductCreate, 
    ProductResponse
) 
from app.services.product_service import (
    create_product, 
    get_products,
    get_product_by_id
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

@router.get("/{product_id}", response_model=ProductResponse)
def get_product(
    product_id: int,
    db: Session = Depends(get_db)
):
    product = get_product_by_id(db, product_id)

    if product is None:
        raise HTTPException(
            status_code=404,
            detail="Product not found"
        )

    return product