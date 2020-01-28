# Maintenance page

This is a Docker container that can be used to display a maintenance page. It is configured
through environment variables in the file .env.maintenance.

`TITLE`: the title to show on the page
`MESSAGE`: the message to show on the page
`MESSAGE_FILE`: if no message is provided, the content of the given message file (html) will be used.

## Deployment

The deployment is two separate phases `push` and `release`.

    # On local machine
    make deploy.push

    # On target
    make -f Makefile.maintenance deploy.release

## Starting and stopping maintenance page server

    # On target
    make -f Makefile.maintenance docker.run
    make -f Makefile.maintenance docker.restart
    make -f Makefile.maintenance docker.stop

## Setup

### 1. Retrieve the files on the server

    # if not done in the previous setup
    scp -P 22 Makefile {username}@{host}:~/Makefile.maintenance
    scp -P 22 env.maintenance.sample {username}@{host}:~

### 3. SSH into the remote server

See 1Password for details.

### 4. Configure .env

    cp env.maintenace.sample .env.maintenace
    # configure file
