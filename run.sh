#!/usr/bin/env bash

# exit when any command fails
set -e

usage()
{
cat << EOF
usage: $0 [-i INPUT_DIR] [-t INPUT_NAME] [-o OUTPUT_DIR] [-h]
This script
OPTIONS:
   -i     Input data directory
   -t     Name of input target from input directory
   -o     Output directory
   -h     Show this message
EOF
}

INPUT_DIR=
INPUT_TARGET=
OUTPUT_DIR=
while getopts ":i:t:o:h" OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    i)
      INPUT_DIR=$OPTARG
      ;;
    t)
      INPUT_TARGET=$OPTARG
      ;;
    o)
      OUTPUT_DIR=$OPTARG
      ;;
    ?)
      usage
      exit
      ;;
  esac
done

if [[ ! -d $INPUT_DIR ]]; then
  echo "$INPUT_DIR is not a valid directory"
  usage
  exit 1
fi

if [[ ! -d "$INPUT_DIR/$INPUT_TARGET" ]]; then
  echo "$INPUT_DIR/$INPUT_TARGET is not a valid directory"
  usage
  exit 1
fi

mkdir -p $OUTPUT_DIR

if [[ "$(docker images -q dockerfold:latest 2>/dev/null)" == "" ]]; then
    docker build -t dockerfold -f Dockerfile $OUTPUT_DIR
    echo "Docker container built!"
fi

ABS_INPUT_DIR=$(cd "$INPUT_DIR/$INPUT_TARGET" && pwd -P)
ABS_OUTPUT_DIR=$(cd "$OUTPUT_DIR" && pwd -P)

docker run --rm -v $ABS_INPUT_DIR:/input -v $ABS_OUTPUT_DIR:/output -e NAME=$INPUT_TARGET dockerfold 