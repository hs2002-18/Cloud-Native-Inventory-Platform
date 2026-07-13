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

def get_products(db: Session):
    return db.query(Product).all()

def get_product_by_id(db: Session, product_id: int):
    return db.query(Product).filter(Product.id == product_id).first()

def update_product_by_id(db: Session, product_id: int, updated_product: ProductCreate):
    product = db.query(Product).filter(Product.id == product_id).first()

    if product is None:
        return None

    product.name = updated_product.name
    product.category = updated_product.category
    product.price = updated_product.price
    product.quantity = updated_product.quantity

    db.commit()
    db.refresh(product)

    return product