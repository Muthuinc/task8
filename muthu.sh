#!/bin/bash

set -e 

# creating a sample html for nginx

touch index.html
echo " <body> 
<h1> WELCOME TO MY PAGE </H1>
</body> " > index.html

#creating docker file for nginx

touch Dockerfile

echo "FROM ubuntu" > Dockerfile
echo "RUN apt update -y " >> Dockerfile
echo "RUN apt install nginx -y " >> Dockerfile
echo "COPY index.html /var/www/html" >> Dockerfile
echo 'CMD ["nginx", "-g", "daemon off;"]' >> Dockerfile


# creating docker image

docker build -t muthuinc/mycustom:latest .

#if you want to push that to your own repository change the image name by editing the below comment line
#docker tag muthuinc/mycustom "<your docker hub repository name>"

# pushing that to the repository

docker login -u muthuinc -p 
docker push muthuinc/mycustom:latest

# running the container

docker run -dp 80:80 --name ownpage muthuinc/mycustom:latest

if curl localhost:80
then 
  echo "successfully built"
else
  echo "try docker ps -a"
fi

docker ps

echo " !!!!succeeded the email verification!!!! "

