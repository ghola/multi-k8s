docker build -t ghola/multi-client:latest -t ghola/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ghola/multi-server:latest -t ghola/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ghola/multi-worker:latest -t ghola/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ghola/multi-client:latest
docker push ghola/multi-client:$SHA
docker push ghola/multi-server:latest
docker push ghola/multi-server:$SHA
docker push ghola/multi-worker:latest
docker push ghola/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ghola/multi-server:$SHA
kubectl set image deployments/client-deployment client=ghola/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ghola/multi-worker:$SHA
