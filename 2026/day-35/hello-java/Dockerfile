# Use Java 17 JDK image
FROM eclipse-temurin:17-jdk

# Set working directory
WORKDIR /app

# Copy Java file into container
COPY src/Main.java .

# Compile Java file
RUN javac Main.java

# Run the program
CMD ["java", "Main"]
