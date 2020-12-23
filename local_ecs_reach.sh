ACCOUNT=368554718146
REGION=eu-central-1
SECRET_NAME=${REGION}-ecr-registry
EMAIL=sinan.islekdemir@iceye.fi

#
#

TOKEN=`aws ecr --region=$REGION get-authorization-token --output text \
    --query authorizationData[].authorizationToken | base64 -d | cut -d: -f2`

#
#  Create or replace registry secret
#


kubectl delete secret --ignore-not-found $SECRET_NAME
kubectl create secret docker-registry $SECRET_NAME \
    --docker-server=https://${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com \
    --docker-username=AWS \
    --docker-password="${TOKEN}" \
    --docker-email="${EMAIL}"

