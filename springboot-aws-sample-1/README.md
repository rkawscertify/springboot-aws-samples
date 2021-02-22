# springboot-aws-sample-1 - Springboot + Docker + ECS
 
- Pre-requisites
1. AWS account is setup
2. AWS CLI is installed
3. 'aws configure' is run

- Verify if 1,2 & 3 are all run using below command in cmd prompt of your choice
1. 'aws ec2 describe-regions' - This command will list all AWS regions where EC2 service is supported

2. I'll be using https://github.com/rkawscertify/springboot-samples/tree/main/springboot-sample-1 for this sample. I have simly copied the project artifacts and replaced springboot-sample-1 with springboot-aws-sample-1

3. We will create a docker image 
	- Build the app first  (Run As -> Maven Build)
	- Create a Dockerfile
	
		FROM openjdk:11.0.9.1-jre
		ARG JAR_FILE=target/*.jar
		COPY ${JAR_FILE} springboot-aws-sample-1.jar
		ENTRYPOINT ["java", "-jar", "/springboot-aws-sample-1.jar"]
		
		- create an image based on a basic openjdk image, which bundles OpenJDK 11 with a Linux distribution
		- create the argument JAR_FILE
		- tell Docker to copy the file specified by that argument into the file app.jar within the container
		- Docker will start the app by calling java -jar /app.jar
	- Build the docker image by running comand 'docker build -t rkawscertify/springboot-aws-sample-1:latest .' (rkawscertify-Docker Hub username as the namespace, use yours if following the sample)
	- You can list the docker iamges using comand 'docker image ls'

4. For running in local, i have Docker Desktop installed and running
	- 'docker run -d -p 8080:80 rkawscertify/springboot-aws-sample-1' (rkawscertify-Docker Hub username as the namespace, use yours if following the sample)

5. Push it to docker hub. Ensure you have your account created on docker hub
	- 'docker login'
	- 'docker push rkawscertify/springboot-aws-sample-1:latest' (rkawscertify-Docker Hub username as the namespace, use yours if following the sample)
	- verify by pull
		- 'docker pull rkawscertify/springboot-aws-sample-1:latest' (rkawscertify-Docker Hub username as the namespace, use yours if following the sample)

6. Running on AWS
	- We will be deploying to AWS using cloudformation template
	- springboot-aws-sample-1 in a docker container
	- container will be deployed to an ECS cluster
	- ECS cluster will be in an public subnet
	- public subnet within a VPC
	- and an internet gateway
	- architecture digram built using AWS toolkit/icons is inside the project
	
	- run create.sh to create the required stacks and run the tasks
	- run delete.sh to do the resouce cleanup once done
	
	- i am running the script using my dev profile, so you can setup your profile or adjust the scripts accordingly
