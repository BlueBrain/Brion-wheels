FROM quay.io/pypa/manylinux2010_x86_64

ADD install_deps.sh /root/

RUN chmod +x /root/install_deps.sh
RUN /root/install_deps.sh

ADD install_python.sh /root
RUN chmod +x /root/install_python.sh && /root/install_python.sh

ADD Brion /Brion
ADD build_wheel.sh /root/
RUN chmod +x /root/build_wheel.sh && /root/build_wheel.sh

CMD cp -r /opt/dist/ /tmp
