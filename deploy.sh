docker build -t tomaszpkaminski/multi-client:latest -t tomaszpkaminski/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t tomaszpkaminski/multi-server:latest -t tomaszpkaminski/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t tomaszpkaminski/multi-server:latest -t tomaszpkaminski/multi-server:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push tomaszpkaminski/multi-client:latest
docker push tomaszpkaminski/multi-client:$GIT_SHA
docker push tomaszpkaminski/multi-server:latest
docker push tomaszpkaminski/multi-server:$GIT_SHA
docker push tomaszpkaminski/multi-worker:latest
docker push tomaszpkaminski/multi-worker:$GIT_SHA
kubctl apply -f k8s
kubctl set image deployments/server-deployment  server=tomaszpkaminski/multi-server:$GIT_SHA
kubctl set image deployments/client-deployment  client=tomaszpkaminski/multi-client:$GIT_SHA
kubctl set image deployments/worker-deployment  worker=tomaszpkaminski/multi-worker:$GIT_SHA