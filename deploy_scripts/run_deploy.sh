#!/bin/bash

PATH=$PATH:/usr/local/bin; export PATH

export AWS_PROFILE="dtlv3-taeeyoul" 
aws sts get-caller-identity 2>&1 >> /home/ec2-user/app.log

aws eks --region ap-northeast-2 update-kubeconfig --name eks-cluster-dtlv3-t7-v1-prd 2>&1 >> /home/ec2-user/app.log
kubectl config current-context 2>&1 >> /home/ec2-user/app.log

kubectl version 2>&1 >> /home/ec2-user/app.log

cd /home/ec2-user/springmysql-deploy/deploy_scripts

kubectl apply -f springmysql-deploy.yaml 2>&1 >> /home/ec2-user/app.log
kubectl apply -f springmysql-svc.yaml 2>&1 >> /home/ec2-user/app.log

# CNT=`kubectl -n homeeee get ing | grep -v NAME | grep springmysql-ing | wc -l`
# if [ $CNT -eq 0 ]
# then
#   kubectl apply -f springmysql-ing.yaml 2>&1 >> /home/ec2-user/app.log
# fi

kubectl apply -f springmysql-ing.yaml 2>&1 >> /home/ec2-user/app.log

kubectl -n homeeee describe ing springmysql-ing 2>&1 >> /home/ec2-user/app.log

kubectl -n homeeee get pvc,deploy,pod,svc,ep,ing 2>&1 >> /home/ec2-user/app.log

CNT=`kubectl -n homeeee get hpa | grep -v NAME | grep springmysql-hpa | wc -l`
if [ $CNT -eq 0 ]
then
  kubectl apply -f springmysql-hpa.yaml 2>&1 >> /home/ec2-user/app.log
  kubectl -n homeeee get hpa 2>&1 >> /home/ec2-user/app.log
fi

