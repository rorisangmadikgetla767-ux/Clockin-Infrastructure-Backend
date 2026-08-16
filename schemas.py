from pydantic import BaseModel
from typing import Optional 
from datetime import datetime 

class EmployeeCreate(BaseModel):
    name: str 
    role: str 
    location_id: int
    active: bool = True
    
class EmployeeUpdate(BaseModel):
    name: Optional[str] = None
    role: Optional[str] = None
    location_id: Optional[int] = None
    active: Optional[bool] = None
    
class EmployeeOut(BaseModel): 
    id: int
    name: str
    role: str 
    location_id: int
    active: bool
    created_at: datetime