import io

from fastapi import APIRouter
from starlette.responses import StreamingResponse, Response
from weasyprint import HTML

from app.gcs import GCS
from app.schema import GeneratePDF, Content

router = APIRouter()
gcs = GCS()


@router.post("/generate-pdf", response_model=dict)
async def generate_pdf(*, body: Content):
    html = HTML(string=body.content)
    pdf = html.write_pdf()

    return StreamingResponse(io.BytesIO(pdf), media_type="application/pdf")


@router.post("/pdf", response_model=dict)
async def upload_pdf(*, body: GeneratePDF):
    html = HTML(string=body.content)
    pdf = html.write_pdf()
    gcs.upload_blob(
        bucket=body.destination.bucket, path=body.destination.path, data=pdf
    )

    return Response(content="File uploaded", status_code=200)
