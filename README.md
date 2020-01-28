# Maintenance page

This is a Docker container that can be used to display a maintenance page. It is configured
through environment variables in file `.env.maintenance`.

- `TITLE`: the title to show on the page
- `MESSAGE`: the message to show on the page
- `MESSAGE_FILE`: if no message is provided, the content of the given message file (html) will be used. The container expects the file to be present in the current folder.

## Deployment

The deployment is done in two separate phases: `push` and `release`.

    # On local machine
    make deploy.push

    # On target
    make -f Makefile.maintenance deploy.release

## Starting and stopping the maintenance page server

Use the Makefile on the remote server to start, restart and stop the maintenance page server:

    make -f Makefile.maintenance docker.run
    make -f Makefile.maintenance docker.restart
    make -f Makefile.maintenance docker.stop

## Setup

### 1. Retrieve the files on the server

Copy files from local machine to the server that will host the maintenance page:

    scp -P 22 Makefile {username}@{host}:~/Makefile.maintenance
    scp -P 22 env.maintenance.sample {username}@{host}:~

### 3. SSH into the remote server

See 1Password for details.

### 4. Configure .env

    cp env.maintenance.sample .env.maintenance

Configure the file for your application.

## Local testing

To test the maintenance page locally, you can run the container on your machine:

    cp env.maintenance.sample .env.maintenance

Change port to 8080 in file `.env.maintenance`

    make docker.build
    make docker.run
    open http://localhost:8080
    make docker.stop
