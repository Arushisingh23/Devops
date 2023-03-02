# Pull the latest version of the Jenkins image from the Docker Hub
FROM jenkins/jenkins:lts

# Use Ubuntu as the base image
FROM ubuntu:latest

# Update the package list and install Git
RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y git
RUN apt-get install -y putty
# install java and sonarcube
RUN apt-get install -y curl \
    && apt-get install -y unzip \
    && apt-get install -y openjdk-11-jre-headless \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the environment variables
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

# Download and extract SonarQube
RUN curl -o sonarqube.zip -LJO https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.4.2.36762.zip \
    && unzip sonarqube.zip \
    && mv sonarqube-8.4.2.36762 /opt/sonarqube \
    && rm sonarqube.zip

# Set the environment variables
ENV SONARQUBE_HOME /opt/sonarqube

# Set the working directory
WORKDIR $SONARQUBE_HOME/data

# Expose port 9000 for the SonarQube web interface
EXPOSE 9000

# Set the working directory
WORKDIR /app

# Specify the command to run when the container starts
CMD ["bash"]
