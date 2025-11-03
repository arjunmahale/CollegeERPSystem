FROM eclipse-temurin:17-jdk

WORKDIR /app

# Copy everything and build inside Render
COPY . .

# Build the project (creates jar in target/)
RUN ./mvnw package -DskipTests

# Run the jar
CMD ["java", "-jar", "target/CollegeERPSystem-0.0.1-SNAPSHOT.jar"]
