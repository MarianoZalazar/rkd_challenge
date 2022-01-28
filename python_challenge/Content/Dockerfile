FROM python:latest
WORKDIR /code
COPY . .
RUN pip3 install -r requirements.txt
CMD ["python", "-u", "load_data.py"]
