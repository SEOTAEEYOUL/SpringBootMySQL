#!/bin/bash

date 2>&1 >> /home/ec2-user/app.log

PATH=$PATH:/usr/local/bin; export PATH

export AWS_PROFILE="dtlv3-taeeyoul"
aws sts get-caller-identity 2>&1 >> /home/ec2-user/app.log

cd /home/ec2-user/springmysql-deploy/deploy_scripts
pwd 2>&1 >> /home/ec2-user/app.log
ls -l 2>&1 >> /home/ec2-user/app.log

aws eks --region ap-northeast-2 update-kubeconfig --name eks-cluster-dtlv3-t7-v1-prd 2>&1 >> /home/ec2-user/app.log
kubectl config current-context 2>&1 >> /home/ec2-user/app.log

echo "kubectl version" 2>&1 >> /home/ec2-user/app.log
kubectl version 2>&1 >> /home/ec2-user/app.log

echo "kubectl get ns | grep -v NAME | grep homeeee | wc -l" 2>&1 >> /home/ec2-user/app.log
CNT=`kubectl get ns | grep -v NAME | grep homeeee | wc -l`
if [ $CNT -eq 0 ]
then
  cat homeeee-ns.yaml 2>&1 >> /home/ec2-user/app.log
  echo "kubectl apply -f homeeee-ns.yaml" 2>&1 >> /home/ec2-user/app.log
  kubectl apply -f homeeee-ns.yaml 2>&1 >> /home/ec2-user/app.log
fi
kubectl get ns 2>&1 >> /home/ec2-user/app.log

echo "kubectl -n homeeee get pvc | grep -v NAME | grep springmysql-pvc | wc -l" 2>&1 >> /home/ec2-user/app.log
CNT=`kubectl -n homeeee get pvc | grep -v NAME | grep springmysql-pvc | wc -l`
if [ $CNT -eq 0 ]
then
  cat springmysql-pvc.yaml 2>&1 >> /home/ec2-user/app.log
  echo "kubectl apply -f springmysql-pvc.yaml" 2>&1 >> /home/ec2-user/app.log
  kubectl apply -f springmysql-pvc.yaml 2>&1 >> /home/ec2-user/app.log
fi
kubectl -n homeeee get pvc 2>&1 >> /home/ec2-user/app.log