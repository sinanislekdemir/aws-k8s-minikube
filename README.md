# Handy Commands

## Start minikube with virtualbox

```
minikube start --driver=virtualbox
```
or to make it default
```
minikube config set driver virtualbox
```

## Set docker environment of minikube for local

```
eval $(minikube docker-env)
cd app
docker build .
docker tag <build hash> myapp:latest
```

# AWS ECS Script

Remember that minikube can't fetch images from private aws ecs registry without secrets set.

For any other namespace other than `default`, please define `--namespace <name>` to the belowe kubectl commands.

```
ACCOUNT=<12 digits aws account code>
REGION=eu-central-1
SECRET_NAME=${REGION}-ecr-registry
EMAIL=<aws user email address>

TOKEN=`aws ecr --region=$REGION get-authorization-token --output text \
    --query authorizationData[].authorizationToken | base64 -d | cut -d: -f2`

kubectl delete secret --ignore-not-found $SECRET_NAME
kubectl create secret docker-registry $SECRET_NAME \
    --docker-server=https://${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com \
    --docker-username=AWS \
    --docker-password="${TOKEN}" \
    --docker-email="${EMAIL}"

```

## Some Notes

### Reachint to ingress

```
kubectl get ingress
```

Add the IP Address with host to `/etc/hosts`
