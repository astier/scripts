#!/usr/bin/env bash

# Compiles and installs tensorflow with custom flags for improved CPU-performance.

VERSION=$1

# Get source-code for the desired tensorflow-version
cd ~/Downloads
git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
git checkout v$VERSION

# Configure and build package and wheel
./configure
bazel build --config=opt //tensorflow/tools/pip_package:build_pip_package
./bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg

# Create environment, install dependencies and tensorflow
conda create -n tf_src_cpu python=3.6 cython keras-applications
keras-preprocessing mock numpy
source activate tf_src_cpu
pip install /tmp/tensorflow_pkg/tensorflow-1.11.0-cp36-cp36m-linux_x86_64.whl

