FROM debian:bullseye
CMD ["python3"]
RUN apt-get update && apt-get install -y neofetch && apt-get install -y python3
COPY meinfile.txt /project/
CMD ["bash"]