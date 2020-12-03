FROM ppx86/wheel_builder:latest
ADD Brion /Brion
RUN /root/build_wheel.sh

CMD cp -r /opt/dist/ /tmp
