# Use official Java 17 base image
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy only Maven wrapper and pom.xml first (to leverage caching)
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Give execution permission to the Maven wrapper
RUN chmod +x mvnw

# Pre-download dependencies (caches Maven libs)
RUN ./mvnw dependency:go-offline -B

# Now copy the actual source code
COPY src ./src

# Build the project (creates JAR inside /target)
RUN ./mvnw clean package -DskipTests

# Expose Render-assigned port
ENV PORT=8080
EXPOSE 8080

# Run the Spring Boot application
CMD ["java", "-jar", "target/CollegeERPSystem-0.0.1-SNAPSHOT.jar"]
