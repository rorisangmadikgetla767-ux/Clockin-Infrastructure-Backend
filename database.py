import os 
import psycopg2
from psycopg2 import pool
from dotenv import load_dotenv

# load_dotenv reads .env and loads DB_HOST, DB_PORT etc into library called os, inside os the is environ
load_dotenv()
# This is the connection pool, it is reused across all db requests instead of opening a new connection everytime
connection_pool = psycopg2.pool.SimpleConnectionPool(
    #SimpleConnectionPool(1,10) keeps 1 to 10 connections ready to handout to us, instead of us having to go open postgresql ourselves which is time consuming 
    
    1, 10,
    host = os.environ.get("DB_HOST"),
    port=os.environ.get("DB_PORT"),
    dbname=os.environ.get("DB_NAME"),
    user=os.environ.get("DB_USER"),
    password=os.environ.get("DB_PASSWORD")
)

def get_connection():
    return connection_pool.getconn()

def lokolla_connection(conn):
    connection_pool.putconn(conn)
    
def create_employee(name,role,site):
    conn = get_connection()