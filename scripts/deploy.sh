#!/bin/sh -ex

GCP_PROJECT=$1
SERVICE_NAME=${1:-foxclip-production}

gcloud run deploy "$SERVICE_NAME" \
   --image gcr.io/"$GCP_PROJECT"/"$SERVICE_NAME" \
   --platform managed \
   --project "$GCP_PROJECT" \
   --region europe-west1 \
   --no-allow-unauthenticated
