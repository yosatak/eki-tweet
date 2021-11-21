#!/bin/sh

cat $(dirname $0)/../data/station20210312free.csv | awk -F',' '{ if ( $7 == 13 ) print $3,$10,$11}' >> $(dirname $0)/../data/station-coord
