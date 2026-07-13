from sqlalchemy.orm import Session

from app.models.products import Product
from app.schemas.product import ProductCreate


def create_product(db: Session, product: ProductCreate):
    db_product = Product(
        name=product.name,
        category=product.category,
        price=product.price,
        quantity=product.quantity
    )

    db.add(db_product)
    db.commit()
    db.refresh(db_product)

    return db_product