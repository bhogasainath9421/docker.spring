# Stage 1: Build stage
FROM maven:3.9-eclipse-temurin-25 AS builder

WORKDIR /app

# Copy the pom.xml
COPY docker.spring/pom.xml .

# Download dependencies (this layer will be cached if pom.xml doesn't change)
RUN mvn dependency:go-offline -B

# Copy the entire application source
COPY docker.spring/ .

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Runtime stage
FROM eclipse-temurin:25-jre

WORKDIR /app

# Copy the WAR file from the builder stage
COPY --from=builder /app/target/*.war app.war

# Expose the default Spring Boot port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/health || exit 1

# Run the application
ENTRYPOINT ["java", "-jar", "app.war"]
