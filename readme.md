docker build -t bladerf-image .
docker tag bladerf-image:latest localhost:5000/bladerf-image:latest
docker push localhost:5000/bladerf-image:latest