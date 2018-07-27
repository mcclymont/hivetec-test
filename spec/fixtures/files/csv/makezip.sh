#!/bin/sh
cd "$(dirname "$0")"
zip -r "$1.zip" "$1"
