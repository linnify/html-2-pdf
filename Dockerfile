FROM python:3.7

# Set some environment variables
ENV PYTHONUNBUFFERED 1
ENV APP_HOME /app

# create root directory for our project in the container
RUN mkdir $APP_HOME

# Set the working directory to /app.
WORKDIR $APP_HOME

# Install pipenv
RUN pip install pipenv

# Copy the current directory contents into the container at /app
COPY Pipfile* ./

#RUN apk add --update python python-dev py-pip build-base
RUN apt-get -y update && apt-get install -y libpango-1.0-0 libpangocairo-1.0-0 libgdk-pixbuf2.0-0 libffi-dev shared-mime-info

# Instal packages
RUN pipenv install --system

#Copy code into app directory
COPY . /app/

EXPOSE $PORT

# Run the gunicorn web server with 1 worker and 8 threads
CMD exec gunicorn --bind :$PORT --workers 2 --threads 8 --timeout 120 -k uvicorn.workers.UvicornWorker -b 0.0.0.0 app.main:app
