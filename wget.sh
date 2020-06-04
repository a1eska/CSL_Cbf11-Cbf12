#!/bin/bash

while read  LINE; do
    wget $LINE
done < $1
