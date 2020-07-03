from pydantic import Field
from pydantic.main import BaseModel


class Destination(BaseModel):
    bucket: str
    path: str


class GeneratePDF(BaseModel):
    content: str = ...
    destination: Destination = Field(...)


class Content(BaseModel):
    content: str = ...
