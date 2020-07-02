#!/bin/sh -ex

GCP_PROJECT=$1
SERVICE_NAME=${1:-pdfs}

gcloud builds submit --tag gcr.io/"$GCP_PROJECT"/"$SERVICE_NAME" --project "$GCP_PROJECT"
