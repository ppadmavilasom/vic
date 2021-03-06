#!/usr/bin/env bash

# Generate a CA and server certificate bundle

set -euf -o pipefail

CA_DIR="/root/ca"
CA_NAME="STARK_ENTERPRISES_ROOT_CA"
OUT_DIR="/root/ca/bundle"
OUT_FILE="/root/ca/cert-bundle.tgz"
SERVER_CERT_CN="starkenterprises.io"

while getopts ":c:d:f:n:o:" opt; do
  case $opt in
    c) CA_NAME="$OPTARG"
    ;;
    d) CA_DIR="$OPTARG"
    ;;
    f) OUT_FILE="$OPTARG"
    ;;
    n) SERVER_CERT_CN="$OPTARG"
    ;;
    o) OUT_DIR="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

mkdir -p $OUT_DIR
cd $CA_DIR
cp certs/$CA_NAME.crt $OUT_DIR
cp private/${SERVER_CERT_CN}.key.pem $OUT_DIR
cp certs/${SERVER_CERT_CN}.cert.pem $OUT_DIR
dir=$(dirname $OUT_DIR)
bundle_dir=$(basename $OUT_DIR)
tar cvf $OUT_FILE -C $dir $bundle_dir
