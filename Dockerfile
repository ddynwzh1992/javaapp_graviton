FROM maven:3.9.5-amazoncorretto-11 AS builder
COPY src/ /home/app/src
COPY pom.xml /home/app/pom.xml
RUN ls -l /home/app
RUN mvn -f /home/app/pom.xml clean install

# Use an official OpenJDK runtime as a parent image
FROM amazoncorretto:11.0.21

# set shell to bash
# source: https://stackoverflow.com/a/40944512/3128926
#RUN apk update && apk add bash

# Set the working directory to /app
WORKDIR /app

# Copy the fat jar into the container at /app
COPY --from=builder /home/app/target/docker-java-app-example.jar /app

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Run jar file when the container launches
CMD ["java", "-jar", "docker-java-app-example.jar"]
