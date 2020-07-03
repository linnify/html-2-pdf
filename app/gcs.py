from google.cloud import storage

from app import constants


class GCS:
    _service = None

    @staticmethod
    def get_service():
        if GCS._service is None:
            GCS._service = storage.Client(project=constants.GOOGLE_CLOUD_PROJECT)
        return GCS._service

    def upload_blob(self, bucket, path: str, data, content_type="application/pdf"):
        bucket = self.get_service().get_bucket(bucket)
        blob = bucket.blob(path)
        blob.upload_from_string(data=data, content_type=content_type)
