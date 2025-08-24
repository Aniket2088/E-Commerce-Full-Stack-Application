# Stage 1: Build with Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run with Tomcat
FROM tomcat:9.0-jdk17
WORKDIR /usr/local/tomcat/webapps
# Remove default ROOT app
RUN rm -rf ROOT
# Copy your WAR into Tomcat and rename it ROOT.war so it runs at "/"
COPY --from=build /app/target/*.war ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
