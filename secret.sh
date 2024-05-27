ACCOUNT=882027629355
REGION=us-east-1
SECRET_NAME=aws-secret
EMAIL=email@email.com

########
# Fetch token (which will expire in 12 hours)
#

TOKEN=`aws ecr --region=$REGION get-authorization-token --output text --query authorizationData[].authorizationToken | base64 -d | cut -d: -f2`

#
# Create or replace registry secret
#

kubectl delete secret --ignore-not-found $SECRET_NAME
kubectl create secret docker-registry $SECRET_NAME \
 --docker-server=https://${ACCOUNT}.dkr.ecr.${REGION}.amazonaws.com \
 --docker-username=AWS \
 --docker-password="${TOKEN}" \
 --docker-email="${EMAIL}"
