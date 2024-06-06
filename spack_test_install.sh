#!/bin/bash

# Echo commands and exit on errors
set -xe

EXEC_DATE=$(date +%Y_%m_%d_%H_%M_%S)

# Self documenting usage function
function usage() {
    echo "A bash script to install and test a spack \"spec\" of octopus package"
    echo "Usage: $0 --spec SPEC_TO_TEST [--spack-root SPACK_ROOT] [--test-name TEST_NAME]"
    echo "Where:"
    echo "  --spec: The spack spec to test (eg octopus@14+mpi)"
    echo "  --spack-root:(Optional) The spack root directory (eg /tmp/spack); if not specified, spack@develop will be cloned at /tmp/spack"
    echo "  --test-name: (Optional) A name for the test and environment; defaults to \"Octopus_DATE\""
    echo "Example: $0 --spec octopus@14+mpi --spack-root /tmp/spackv0.22.0"
    echo "Example: $0 --spec octopus@14+mpi --test-name Octopus_mytest"
    echo "Example: $0 --help"
}

# Capture the command line arguments
# Test that at least one argument is provided
if [[ $# -eq 0 || "$1" == "--help" ]]; then
    usage
    exit 1
fi

# Parse the command line arguments
SPEC_TO_TEST=""
SPACK_ROOT=""
TEST_NAME="Octopus_${EXEC_DATE}"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --spec)
            SPEC_TO_TEST="$2"
            shift 2
            ;;
        --spack-root)
            SPACK_ROOT="$2"
            shift 2
            ;;
        --test-name)
            TEST_NAME="$2"
            shift 2
            ;;
        *)
            echo "Unknown argument: $1"
            usage
            exit 1
            ;;
    esac
done

# cd into the spack root
# If SPACK_ROOT is not specified, use spack@develop
if [ -z "$SPACK_ROOT" ]; then
    SPACK_ROOT="/tmp/spack"
    pushd $SPACK_ROOT
    git clone https://github.com/spack/spack.git .
    git checkout develop
else
    pushd $SPACK_ROOT
fi

source share/spack/setup-env.sh

# create a new environment and activate it
spack env create $TEST_NAME
spack env activate $TEST_NAME


# display the specs of the upcoming spack installation
spack spec $SPEC_TO_TEST
# run the spack installation (adding it to the environment):
spack add $SPEC_TO_TEST
spack install

# run spack smoke tests for octopus. We get an error if any of the fails:
spack test run --alias $SPEC_TO_TEST octopus

# display output from smoke tests (just for information):
spack test results -l $SPEC_TO_TEST

# show which octopus version we use (for convenience):
spack load $SPEC_TO_TEST
octopus --version

# TODO: add more tests here ( eg. H atom)

# deactivate the environment
spack env deactivate