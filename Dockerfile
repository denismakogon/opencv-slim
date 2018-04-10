FROM python:3.6.5-slim-stretch

ENV OPENCV_VERSION="3.4.1"

ENV LIB="libswscale-dev \
         libtbb2 \
         libtbb-dev \
         libjpeg-dev \
         libpng-dev \
         libtiff-dev \
         libavformat-dev \
         libpq-dev"

ENV PKG="build-essential \
         cmake \
         git \
         wget \
         unzip \
         yasm \
         pkg-config"

RUN apt-get update && \
    apt-get install --no-install-recommends -qy $PKG && \
    apt-get install --no-install-recommends -qy $LIB && \
    apt-get install --no-install-recommends -qy gcc && \
    wget -O /tmp/libjpeg-turbo8_1.4.2-0ubuntu3_amd64.deb "http://cz.archive.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8_1.4.2-0ubuntu3_amd64.deb" && \
    wget -O /tmp/libjpeg8_8c-2ubuntu8_amd64.deb "http://cz.archive.ubuntu.com/ubuntu/pool/main/libj/libjpeg8-empty/libjpeg8_8c-2ubuntu8_amd64.deb" && \
    wget -O /tmp/libjasper1_1.900.1-debian1-2.4ubuntu1.1_amd64.deb "http://security.ubuntu.com/ubuntu/pool/main/j/jasper/libjasper1_1.900.1-debian1-2.4ubuntu1.1_amd64.deb" && \
    wget -O /tmp/libjasper-dev_1.900.1-debian1-2.4ubuntu1.1_amd64.deb "http://security.ubuntu.com/ubuntu/pool/main/j/jasper/libjasper-dev_1.900.1-debian1-2.4ubuntu1.1_amd64.deb" && \
    dpkg -i /tmp/libjpeg-turbo8_1.4.2-0ubuntu3_amd64.deb && \
    dpkg -i /tmp/libjpeg8_8c-2ubuntu8_amd64.deb && \
    dpkg -i /tmp/libjasper1_1.900.1-debian1-2.4ubuntu1.1_amd64.deb && \
    dpkg -i /tmp/libjasper-dev_1.900.1-debian1-2.4ubuntu1.1_amd64.deb && \
    rm -fr /tmp/lib* && \
    pip install numpy && \
    wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
    && unzip ${OPENCV_VERSION}.zip \
    && mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
    && cd /opencv-${OPENCV_VERSION}/cmake_binary \
    && cmake -DBUILD_TIFF=ON \
      -DBUILD_opencv_java=OFF \
      -DWITH_CUDA=OFF \
      -DENABLE_AVX=ON \
      -DWITH_OPENGL=ON \
      -DWITH_OPENCL=ON \
      -DWITH_IPP=ON \
      -DWITH_TBB=ON \
      -DWITH_EIGEN=ON \
      -DWITH_V4L=ON \
      -DBUILD_TESTS=OFF \
      -DBUILD_PERF_TESTS=OFF \
      -DCMAKE_BUILD_TYPE=RELEASE \
      -DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
      -DPYTHON_EXECUTABLE=$(which python3.6) \
      -DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
      -DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \
    && make install \
    && rm /${OPENCV_VERSION}.zip \
    && rm -r /opencv-${OPENCV_VERSION} \
    && ldconfig \
    && apt-get remove --purge --auto-remove -y ${PKG} \
    && apt-get remove --purge --auto-remove -y ${LIB} && \
    apt-get clean; \
    apt-get autoclean; \
    apt-get autoremove; \
    rm -rf /tmp/* /var/tmp/*; \
    rm -rf /var/lib/apt/lists/*; \
    rm -f /var/cache/apt/archives/*.deb \
        /var/cache/apt/archives/partial/*.deb \
        /var/cache/apt/*.bin; \
    rm -rf /root/.[acpw]*
