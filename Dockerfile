# Use the official Python image as the base image
FROM python:3.10.7-slim

# Set the working directory inside the container
WORKDIR /app

# Create a virtual environment and activate it
RUN python -m venv myenv
ENV PATH="/app/myenv/bin:$PATH"

# Upgrade pip to the latest version
RUN pip install --no-cache-dir --upgrade pip

# Copy the requirements file to the container
COPY requirements.txt .
COPY . /app

# Install the required packages within the virtual environment
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Flask app and model file to the container
#COPY app.py .
#run ls -la model
#COPY model/model_binary.tar.gz .

# Extract the model file
#RUN tar -xzvf model_binary.tar.gz -C model && mv model/model_binary.dat model/model.dat

# Copy the code_model_training folder to the container
#COPY code_model_training /app/code_model_training

# Expose the port that the Flask app will run on
EXPOSE 5000

# Set environment variables for Flask
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Run the Flask app within the virtual environment
CMD ["python", "app.py"]

