FROM quay.io/pypa/manylinux2010_x86_64

ADD install_deps.sh install_python.sh build_wheel.sh /root/

RUN chmod +x /root/install_deps.sh /root/install_python.sh /root/build_wheel.sh
RUN /root/install_deps.sh
RUN /root/install_python.sh

ADD Brion /Brion
RUN /root/build_wheel.sh

CMD cp -r /opt/dist/ /tmp
