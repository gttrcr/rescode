#!/bin/bash

cp $1 bk_$1
rm $1
cat bk_$1 | cut -c 3- | rev | cut -c3- | rev | grep -v '::Input::' | grep -v '::Package::' > $1

