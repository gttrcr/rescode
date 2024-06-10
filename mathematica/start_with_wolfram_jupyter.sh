#!/bin/bash

if ! command -v wolframscript &> /dev/null
then #check this branch
    curl -O -J -L --progress-bar 'https://account.wolfram.com/dl/WolframEngine?version=13.3&platform=Linux&downloadManager=false&includesDocumentation=false'
    chmod +x WolframEngine_13.3.0_LINUX.sh 
    sudo ./WolframEngine_13.3.0_LINUX.sh
    ./WolframKernel
fi

# xdg-open https://www.wolframcloud.com/users/user-current/activationkeys #list of activations keys

sudo apt install jupyter -y
rm -rf WolframLanguageForJupyter
git clone https://github.com/WolframResearch/WolframLanguageForJupyter.git
cd WolframLanguageForJupyter
./configure-jupyter.wls add
rm -rf WolframLanguageForJupyter
jupyter kernelspec list
jupyter notebook
