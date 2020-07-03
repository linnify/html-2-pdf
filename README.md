 # HTML to PDF Microservice

HTML to PDF microservice is responsible to convert a html in the form of a string to a PDF.

 ## Set up

This part will include what you need to do to use this micro-service in your project

 ### Download

Firstly you need to download the micro-service using git

```
git clone https://github.com/linnify/html-2-pdf.git
```

 ### Environment

Set up an environment file ``.env`` with only one value ``GOOGLE_CLOUD_PROJECT`` which sets your project in which you micro-service will be trying to upload the pdf in.

```.env
GOOGLE_CLOUD_PROJECT=example
```

 ## Deployment to GCP

You should be running the following commands. `GOOGLE_CLOUD_PROJECT` is the value of your project. 
`SERVICE_NAME` is the name of your cloud run instance by default it will be `pdfs`

```
scripts/build.sh GOOGLE_CLOUD_PROJECT \
scripts/deploy.sh GOOGLE_CLOUD_PROJECT
```

With this 2 commands you will be building the docker image of your service after which sed image will be deployed to GCP.

 ## Set up the environment

After you had you service deployed you should be looking to set up the environment variables inside it.
You can visit this link to understand more about adding environment variables in GCP [here](https://cloud.google.com/run/docs/configuring/environment-variables)


 ### Set up bucket

You should either create a new bucket or use the default bucket `[GOOGLE_CLOUD_PROJECT].appspot.com`
to use as a storing place. Depending on what you want you can manage the buckets permissions and 
granularity [here](https://cloud.google.com/storage/docs/access-control) is a link for this.

 ## Set up service permissions

To properly use the service you need to give it the permission to access your cloud storage with writing permission.
It is recommended that you create a service account and use it as this service's default service account then you can give it said permission.
You can find more information about service accounts and granting permissions to them [here](https://cloud.google.com/iam/docs/service-accounts)

## Endpoints

The micro-service has 2 endpoints: one for generating and returning the pdf and 
the other just for generating returning the pdf as a response.

Both endpoints are waiting for a field attribute inside your json named
`content` which is the html body in the form of a string which it will converted into a pdf.
 
 ### Generate Endpoint
 
This endpoint will be given the html and will convert it into a pdf and return it as a response.
 

Returns the PDF as response. Receive only the content as json body
```
/generate-pdf -> POST
```
Example Request:
```json
{
   "content": "your html content"
}
```

 ### Upload Endpoint

Generate the pdf and upload the pdf in Google Cloud Storage. The upload endpoint has something additional from `/generate-pdf`
endpoint as it needs the GCS bucket.
You need to specify the GCS bucket and path. You can see the setting up part of the bucket [here](#set-up-bucket)

```
/pdf -> POST
```

Example Request:
```json
{
  "content": "<body>....</body>",
  "destination": {
    "bucket": "your-bucket",
    "path": "path-in-the-bucket"
  }
}
```


