# saponk8s

In this Dockerfile, we are using the sapmachine/jdk11:x86_64-11.0.7-jdk base image, which is a supported SAP image that includes the JDK 11 runtime.

We then copy the SAP application files to the /app directory in the container, and set the working directory to /app. We expose port 8080, which is the port that our SAP application listens on.

Next, we set environment variables for the SAP system ID, Java home, JRE home, and input parameters file.

Finally, we define the command to run our SAP application, which in this case is to execute the java -jar sapapp.jar command.

To build the Docker image, save the above Dockerfile as Dockerfile in the same directory as your SAP application jar file, and run the following command:

docker build -t sapapp:latest .
