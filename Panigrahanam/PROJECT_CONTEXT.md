# PROJECT_CONTEXT.md

# Panigrahanam Project Context & Engineering Knowledge Base

## Project Overview

### Project Name
Panigrahanam

### Project Type
Cloud-native Matrimony Web Application

### Hosting Environment
- AWS EC2
- K3S Kubernetes Cluster
- Docker
- Jenkins
- Terraform
- Prometheus/Grafana
- AWS S3

---

## Business Purpose

Panigrahanam is a matrimony platform supporting:
- User registration
- Login authentication
- Profile creation
- Profile matching
- Image uploads
- User preferences
- Share/export functionality

---

## Current Project Status

### Current State
- Frontend deployed on K3S
- Backend deployed on K3S
- MySQL StatefulSet running
- Jenkins CI/CD active
- Prometheus/Grafana monitoring active
- SMTP alerting configured
- S3 image uploads active
- HPA configured
- k6 load testing completed

---

## Application Architecture

```text
Users
  ↓
Frontend (React + Vite)
  ↓
Backend API (Node.js + Express)
  ↓
MySQL Database
  ↓
AWS S3 Storage
```

---

## Infrastructure Architecture

```text
AWS EC2
│
├── K3S Cluster
│    ├── Frontend Deployment
│    ├── Backend Deployment
│    ├── MySQL StatefulSet
│    ├── Prometheus
│    ├── Grafana
│    ├── Alertmanager
│    ├── Node Exporter
│    └── MySQL Exporter
│
├── Jenkins
├── Docker
├── Terraform
└── AWS S3
```

---

## Frontend Stack

- React
- Vite
- Axios
- React Router
- CSS

### Frontend Issues Fixed
- Vite build failures
- CSS import issues
- Share image issues
- Thumbnail rendering issues
- Export image issues

---

## Backend Stack

- Node.js
- Express.js
- JWT Authentication
- Multer
- MySQL
- AWS SDK

### Backend Responsibilities
- Authentication APIs
- Profile APIs
- Upload APIs
- Match APIs
- Search APIs

---

## Database Architecture

### Database
MySQL 8.x

### Database Name
avvak

### Important Tables
- users
- profiles
- attachments
- profilematch
- profileinteraction
- customer_preferences

---

## Authentication Flow

```text
Frontend Login
  ↓
Backend API
  ↓
JWT Token
  ↓
Protected APIs
```

---

## Image Upload System

### Initial Design
Local uploads folder storage.

### Current Design
AWS S3 uploads.

### Upload Flow

```text
Frontend
  ↓
Backend Multer
  ↓
AWS SDK Upload
  ↓
S3 Bucket
```

---

## Kubernetes Architecture

### Namespace
panigrahan

### Deployments
- frontend
- backend

### StatefulSets
- mysql

### Services
- frontend-service
- backend-service
- mysql-service
- mysql-headless

---

## Monitoring Stack

### Components
- Prometheus
- Grafana
- Alertmanager
- Node Exporter
- MySQL Exporter
- Blackbox Exporter

---

## Jenkins CI/CD

### Workflow

```text
GitHub Push
  ↓
Jenkins Pipeline
  ↓
Docker Build
  ↓
DockerHub Push
  ↓
Kubernetes Deployment
```

---

## Persistent Storage

### MySQL
Using gp3-storage EBS-backed PVC.

### Grafana
Migrated from local-path to gp3-storage after dashboard data loss issue.

---

## Grafana Alerts

### SMTP
Configured using Gmail SMTP.

### Alerts
- Disk usage alerts
- Email notifications

---

## Load Testing

### Tool
k6

### APIs Tested
- Login API
- Profile APIs

### Results
- Stable at 25 VUs
- Successful HPA observations
- p95 latency improved after fixes

---

## Common Kubernetes Commands

### Restart Deployment

```bash
kubectl rollout restart deployment backend -n panigrahan
```

### Get Pods

```bash
kubectl get pods -n panigrahan
```

### Get HPA

```bash
kubectl get hpa -n panigrahan
```

### Pod Resource Usage

```bash
kubectl top pods -n panigrahan
```

---

## Current Pending Tasks

- ArgoCD GitOps setup
- Kafka integration
- Private DockerHub images
- Redis caching
- Better staging workflow
- HTTPS/TLS improvements

---

## Lessons Learned

- Persistent volumes are mandatory for stateful applications
- S3 permissions directly affect frontend image rendering
- Grafana without PVC loses dashboards
- Monitoring business metrics is important
- CI/CD should not deploy directly from main branch

---

## Final Notes

This file acts as the long-term operational memory and engineering context for the Panigrahanam project.

Future conversations should assume continuity from this documentation.
