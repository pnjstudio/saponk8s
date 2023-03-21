# Set the base image to a supported SAP image
FROM sapmachine/jdk11:x86_64-11.0.7-jdk

# Copy the SAP application files to the container
COPY sapapp.jar /app/sapapp.jar

# Set the working directory to /app
WORKDIR /app

# Expose the port that the SAP application listens on
EXPOSE 8080

# Set environment variables for the SAP application
ENV SAP_SID=ABC
ENV SAP_JAVA_HOME=/usr/java
ENV SAP_JRE_HOME=/usr/java
ENV SAPINST_INPUT_PARAMETERS_URL=file:///mnt/sap/sapinst/ABC.params

# Define the command to run the SAP application
CMD ["java", "-jar", "sapapp.jar"]
