# saponk8s

In this Dockerfile, we are using the `sapmachine/jdk11:x86_64-11.0.7-jdk` base image, which is a supported SAP image that includes the JDK 11 runtime.

We then copy the SAP application files to the /app directory in the container, and set the working directory to /app. We expose port 8080, which is the port that our SAP application listens on.

Next, we set environment variables for the SAP system ID, Java home, JRE home, and input parameters file.

Finally, we define the command to run our SAP application, which in this case is to execute the java -jar sapapp.jar command.

To build the Docker image, save the above Dockerfile as Dockerfile in the same directory as your SAP application jar file, and run the following command:

```docker build -t sapapp:latest```




Create the ABC.params file and provide the necessary input parameters for the SAP application installation.
The input parameters file typically contains values for installation options such as SAP system ID, hostname, database type, and other settings specific to your SAP application. You can obtain a sample input parameters file from SAP or from your SAP application vendor.

To create the ABC.params file, follow these steps:
	1. Create a new text file named ABC.params.
	2. Add the necessary input parameters for your SAP application installation to the file, using the format specified by SAP.
	3. Save the file in a location accessible from the container, such as /mnt/sap/sapinst/ABC.params.
	
Here's an example input parameters file for an SAP application installation:


# SAP system ID
sapinst.systemId=ABC

# Database type and parameters
sdb.dbtype=HDB
sdb.hostname=db-server.example.com
sdb.sid=DB1
sdb.systemPassword=secret
sdb.port=30015
sdb.username=dbadmin
sdb.password=dbadmin_password

# SAP application parameters
inst.sapInstHost=localhost
inst.sapInstDispatchTimeout=1200


Once you have created the ABC.params file and added the necessary input parameters, you can reference the file in the Dockerfile using the SAPINST_INPUT_PARAMETERS_URL environment variable.

Does it get copied inside ? 

Yes, you can copy the ABC.params file to the container image during the build process by adding the following line to your Dockerfile:



COPY ABC.params /mnt/sap/sapinst/


This will copy the ABC.params file from your local directory to the /mnt/sap/sapinst/ directory in the container image.
You can then reference this file in your Dockerfile using the SAPINST_INPUT_PARAMETERS_URL environment variable, like this:



ENV SAPINST_INPUT_PARAMETERS_URL=file:///mnt/sap/sapinst/ABC.params

This will set the SAPINST_INPUT_PARAMETERS_URL environment variable to the file path of the ABC.params file in the container image. The file:// prefix is used to indicate that the file path is a local file system path.

If I need to maintain the local file post image creation?

If you want to maintain the ABC.params file on your local system after creating the container image, you can mount the file as a volume when running the container.
Here's an example command to run the container and mount the ABC.params file as a volume:

docker run -p 8080:8080 -v /path/to/ABC.params:/mnt/sap/sapinst/ABC.params sapapp:latest
 
Replace /path/to/ABC.params with the path to the ABC.params file on your local system.
The -v option specifies a volume mount, which maps a local directory or file to a directory or file inside the container. In this case, we are mapping the ABC.params file on the local system to the /mnt/sap/sapinst/ABC.params file inside the container.
When you run the container with this command, the ABC.params file will be mounted as a volume and accessible from inside the container. Any changes made to the file from within the container will be reflected on the local system, and vice versa.

If you don't want to maintain the local file 

If you don't want to maintain the ABC.params file on your local system after creating the container image, you can include the file inside the container image and reference it directly from there.
To do this, you can add the following line to your Dockerfile to copy the ABC.params file into the container image:



COPY ABC.params /mnt/sap/sapinst/

This will copy the ABC.params file from your local directory to the /mnt/sap/sapinst/ directory in the container image.
Then, you can reference the ABC.params file directly from the container image by setting the SAPINST_INPUT_PARAMETERS_URL environment variable to the file path inside the container, like this:


ENV SAPINST_INPUT_PARAMETERS_URL=file:///mnt/sap/sapinst/ABC.params

When you build the container image with this Dockerfile, the ABC.params file will be included inside the image and accessible from within the container. You can then reference the file directly using the SAPINST_INPUT_PARAMETERS_URL environment variable.![image](https://user-images.githubusercontent.com/101955369/227542344-db2e955a-680e-48a6-9f81-1b90274d3a11.png)
