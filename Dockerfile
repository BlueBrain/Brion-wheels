FROM ppx86/wheel_builder:latest
ADD Brion /Brion
ADD build_wheel.sh /root/build_wheel.sh
RUN chmod +x /root/build_wheel.sh &&  /root/build_wheel.sh

CMD cp -r /opt/dist/ /tmp
