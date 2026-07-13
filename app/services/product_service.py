from sqlalchemy.orm import Session
from app.logger import logger
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
    logger.info(f"Product created: ID={db_product.id}")

    return db_product

def get_products(db: Session):
    products = db.query(Product).all()
    logger.info(f"Retrieved {len(products)} products.")
    return products

def get_product_by_id(db: Session, product_id: int):
    logger.info(f"Retrieved product ID={product_id}")
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
    logger.info(f"Updated product ID={product.id}")
    return product

def delete_product_by_id(db: Session, product_id: int):
    product = db.query(Product).filter(Product.id == product_id).first()

    if product is None:
        return None

    db.delete(product)
    db.commit()
    logger.info(f"Deleted product ID={product.id}")
    return product