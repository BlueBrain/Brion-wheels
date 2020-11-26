FROM quay.io/pypa/manylinux2010_x86_64

ADD install_deps.sh build_wheel.sh /root/

RUN chmod +x /root/install_deps.sh /root/build_wheel.sh

RUN /root/install_deps.sh
RUN /root/build_wheel.sh

ADD repair_wheel.sh /root
RUN chmod +x /root/repair_wheel.sh
CMD /root/repair_wheel.sh

