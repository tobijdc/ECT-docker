docker build -t tobijdc/ect-docker ../.
docker tag tobijdc/ect-docker tobijdc/ect-docker:0.9.5
docker tag tobijdc/ect-docker tobijdc/ect-docker:0.9
docker push tobijdc/ect-docker
docker push tobijdc/ect-docker:0.9.5
docker push tobijdc/ect-docker:0.9
