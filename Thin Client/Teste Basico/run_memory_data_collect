#!/bin/bash

file='memory'

while (free -kt | grep Mem | awk '{print expr ($3 - ($6 + $7))/1024}')>>file; do 
    sleep .5
done
