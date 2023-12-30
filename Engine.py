from sqlalchemy import create_engine
import os

db_uri = os.environ["db_uri"]

engine = create_engine(db_uri)