#!/bin/sh

tar Jxvf packagesite.txz
sed -i ".bak" "s/m-m-/m-/g" packagesite.yaml 
tar Jcvf packagesite.txz packagesite.yaml
