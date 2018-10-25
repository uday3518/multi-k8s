docker build -t uday0802/multi-client:latest -t uday0802/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t uday0802/multi-server:latest -t uday0802/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t uday0802/multi-worker:latest -t uday0802/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push uday0802/multi-client:latest
docker push uday0802/multi-server:latest
docker push uday0802/multi-worker:latest

docker push uday0802/multi-client:$SHA
docker push uday0802/multi-server:$SHA
docker push uday0802/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=uday0802/multi-server:$SHA
kubectl set image deployments/client-deployment client=uday0802/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=uday0802/multi-worker:$SHA