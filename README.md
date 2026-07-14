# AWS DevOps CI/CD Automation Project

## Project Overview

This project demonstrates an automated CI/CD pipeline for deploying a containerized web application on AWS.

Terraform is used to provision the AWS infrastructure and automate the installation of Docker and Jenkins. GitHub Webhooks automatically trigger the Jenkins pipeline whenever code is pushed to the repository.

Jenkins builds the Docker image, pushes the image to Docker Hub, and deploys the latest application version as a Docker container.

## Architecture

Developer
↓
Git Push
↓
GitHub Repository
↓
GitHub Webhook
↓
Jenkins Pipeline
↓
Docker Image Build
↓
Docker Hub
↓
Docker Container Deployment
↓
Nginx Web Application

## Technologies Used

* AWS EC2
* Terraform
* Jenkins
* Docker
* Docker Hub
* Git
* GitHub
* GitHub Webhooks
* Nginx
* HTML
* CSS

## Project Workflow

1. Terraform provisions an AWS EC2 instance and security group.
2. Terraform user data installs Git, Docker, Java, and Jenkins.
3. Jenkins is configured to access the Docker engine.
4. The application source code and Jenkinsfile are stored in GitHub.
5. A GitHub Webhook triggers Jenkins whenever code is pushed to the main branch.
6. Jenkins builds a Docker image from the Dockerfile.
7. Jenkins authenticates with Docker Hub using Jenkins credentials.
8. The Docker image is pushed to Docker Hub.
9. Jenkins stops and removes the existing application container.
10. Jenkins runs a new container using the latest Docker image.
11. The updated Nginx web application is deployed automatically.

## CI/CD Pipeline Stages

* Build Docker Image
* Login to Docker Hub
* Push Docker Image
* Stop Old Container
* Remove Old Container
* Run New Container

## Docker Image

Docker Hub image:

`iron30/terradockerjen:v1`

## Infrastructure

The Terraform configuration creates:

* AWS EC2 instance
* Security group
* Elastic IP
* SSH access on port 22
* HTTP access on port 80
* Jenkins access on port 8080

## Automation

The EC2 user data script automatically installs and configures:

* Git
* Docker
* Java 21
* Jenkins

The Jenkins user is added to the Docker group and the Jenkins service is restarted to load Docker permissions.

## Issues Resolved During Implementation

* Fixed Jenkins repository GPG key configuration.
* Fixed Git branch mismatch between `master` and `main`.
* Resolved Jenkins Docker socket permission issues.
* Corrected Jenkins service and Docker group initialization order.
* Configured GitHub Webhook automated pipeline triggers.
* Managed EC2 public IP changes using an Elastic IP.
* Integrated Docker Hub authentication using Jenkins credentials.

## Result

The project successfully implements an automated CI/CD workflow.

Whenever application code is pushed to GitHub, the GitHub Webhook automatically triggers Jenkins. Jenkins builds the Docker image, pushes it to Docker Hub, and deploys the updated application as a Docker container on AWS EC2.


