from typing import List, Optional
from pydantic import Field, BaseModel
from datetime import datetime
from enum import StrEnum

class Template(BaseModel):
    id: int
    name: str
    external_id: Optional[str] = None
    folder_name: Optional[str] = None
    created_at: datetime
    updated_at: datetime

class Submission(BaseModel):
    id: int
    status: str
    url: str
    audit_log_url: Optional[str] = None
    combined_document_url: Optional[str] = None
    created_at: datetime

class Document(BaseModel):
    name: str
    url: str

class FieldValue(BaseModel):
    field: str
    value: str

class SubmitterData(BaseModel):
    id: int
    submission_id: int
    email: str
    name: Optional[str] = None
    phone: Optional[str] = None
    role: str
    external_id: Optional[str] = None
    status: str
    completed_at: Optional[datetime] = None
    declined_at: Optional[datetime] = None
    metadata: Optional[dict] = None
    values: List[FieldValue]
    template: Template
    submission: Submission
    documents: List[Document]

class WebhookPayload(BaseModel):
    event_type: str
    timestamp: datetime
    data: SubmitterData