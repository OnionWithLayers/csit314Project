#!/bin/bash

set -e

echo "======================================"
echo "🚀 Starting Minikube Cluster"
echo "======================================"

minikube start

echo ""
echo "======================================"
echo "📦 Applying Kubernetes Resources"
echo "======================================"

# ConfigMap
kubectl apply -f configmap.yaml

# Storage
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml

# MySQL
kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml

# Nexus
kubectl apply -f nexus-deployment.yaml
kubectl apply -f nexus-service.yaml

# Jenkins
kubectl apply -f jenkins-deployment.yaml
kubectl apply -f jenkins-service.yaml

# Web Application
kubectl apply -f webapp-deployment.yaml
kubectl apply -f webapp-service.yaml

echo ""
echo "======================================"
echo "⏳ Waiting for deployments to be ready"
echo "======================================"

kubectl rollout status deployment/mysql
kubectl rollout status deployment/nexus
kubectl rollout status deployment/jenkins
kubectl rollout status deployment/webapp

echo ""
echo "======================================"
echo "📊 Cluster Status"
echo "======================================"

kubectl get pods
kubectl get services
kubectl get deployments

echo ""
echo "======================================"
echo "✅ DEPLOYMENT COMPLETE"
echo "======================================"

echo ""
echo "🌍 Access Services (Minikube)"
echo "--------------------------------------"
echo "Jenkins:  minikube service jenkins"
echo "Nexus:    minikube service nexus"
echo "WebApp:   minikube service webapp"

echo ""
echo "Or use port-forward if needed:"
echo "kubectl port-forward svc/jenkins 8080:8080"
echo "kubectl port-forward svc/nexus 8081:8081"
echo "kubectl port-forward svc/webapp 8082:8080"
