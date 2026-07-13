import os
from dotenv import load_dotenv

load_dotenv()

APP_NAME = os.getenv("APP_NAME")
APP_VERSION = os.getenv("APP_VERSION")
DATABASE_NAME = os.getenv("DATABASE_NAME")