set -x

function build_cmake {
    build_simple cmake 3.15.7 https://cmake.org/files/v3.15/
}

function build_boost {
    mkdir boost_install_tmp
    pushd boost_install_tmp
    curl -L https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.tar.gz > boost_1_70_0.tar.gz
    tar -xzf boost_1_70_0.tar.gz
    cd boost_1_70_0
    BOOST_PYTHON_VERSION=`python -c 'import sys; print(str(sys.version_info[0])+"."+str(sys.version_info[1]))'`
    BOOST_PYTHON_ROOT_DIR=`python -c 'import sys; from pathlib import Path; print(Path(sys.executable).parent.parent)'`
    BOOST_PYTHON_INCLUDE_PATH=`python -c "from sysconfig import get_paths as gp; print(gp()['include'])"`
    ./bootstrap.sh --with-python=python
    sed -i "/^    using python :/c\    using python : $BOOST_PYTHON_VERSION : $BOOST_PYTHON_ROOT_DIR : $BOOST_PYTHON_INCLUDE_PATH ;" project-config.jam
    ./b2 install
    popd 
}

function pre_build {
    if [ -z "$IS_OSX" ]; then
        build_cmake
        build_hdf5

        # Add workaround for auditwheel bug:
        # https://github.com/pypa/auditwheel/issues/29
        local bad_lib="/usr/local/lib/libhdf5.so"
        if [ -z "$(readelf --dynamic $bad_lib | grep RUNPATH)" ]; then
            echo "Patching $bad_lib"
            patchelf --set-rpath $(dirname $bad_lib) $bad_lib
        fi
    else
        brew list cmake || brew install cmake
        brew list hdf5 || brew install hdf5
    fi
    build_zlib
    build_boost
}

function run_tests {
    python --version
    python -c 'import sys; import brion; print(brion.__version__)'
}
