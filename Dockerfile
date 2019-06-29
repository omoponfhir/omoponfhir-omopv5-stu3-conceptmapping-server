#Build the Maven project
FROM maven:3.5.2-alpine as builder
COPY ../omoponfhir-omopv5-jpabase /usr/src/app/omoponfhir-omopv5-jpabase
COPY ../omoponfhir-omopv5-stu3-mapping /usr/src/app/omoponfhir-omopv5-stu3-mapping
COPY ../omoponfhir-main /usr/src/app/omoponfhir-main
COPY . /usr/src/app/omoponfhir-main

WORKDIR /usr/src/app/omoponfhir-main
RUN mvn clean install

WORKDIR /usr/src/app/omoponfhir-omopv5-stu3-conceptmapping-server
RUN mvn clean install

#Build the Tomcat container
FROM tomcat:alpine
#set environment variables below and uncomment the line. Or, you can manually set your environment on your server.
#ENV JDBC_URL=jdbc:postgresql://<host>:<port>/<database> JDBC_USERNAME=<username> JDBC_PASSWORD=<password>
RUN apk update
RUN apk add zip postgresql-client

# Copy GT-FHIR war file to webapps.
COPY --from=builder /usr/src/app/omoponfhir-omopv5-stu3-conceptmapping-server/target/omoponfhir-omopv5-stu3-conceptmapping-server.war $CATALINA_HOME/webapps/omoponfhir-conceptmapping.war

EXPOSE 8080
