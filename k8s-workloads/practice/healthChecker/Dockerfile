FROM python:3.11-slim
WORKDIR /app
RUN pip install requests
COPY healthChecker.py .
ENTRYPOINT ["python", "healthChecker.py"]