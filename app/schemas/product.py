from pydantic import BaseModel, ConfigDict


class ProductCreate(BaseModel):
    name: str
    category: str
    price: float
    quantity: int


class ProductResponse(ProductCreate):
    id: int

    model_config = ConfigDict(from_attributes=True)