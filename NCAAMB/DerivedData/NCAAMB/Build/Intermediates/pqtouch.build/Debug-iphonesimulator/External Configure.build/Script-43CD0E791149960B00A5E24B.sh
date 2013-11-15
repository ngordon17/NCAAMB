#!/bin/sh
cd postgresql/current
./configure --prefix=/opt/ios/postgresql 
cd src/interfaces/libpq
make

