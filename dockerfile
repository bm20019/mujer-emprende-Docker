FROM openjdk:17-jdk-bullseye
#WORKDIR /app
ARG JAR_FILE=build/*.jar
COPY ${JAR_FILE} mujer_emprende.jar
EXPOSE 8080
CMD ["java", "-jar", "mujer_emprende.jar"]
