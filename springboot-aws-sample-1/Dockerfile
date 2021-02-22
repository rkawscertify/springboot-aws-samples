FROM openjdk:11.0.9.1-jre
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} springboot-aws-sample-1.jar
ENTRYPOINT ["java", "-jar", "/springboot-aws-sample-1.jar"]