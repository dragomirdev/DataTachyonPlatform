#!/bin/bash
clear
#current_dir= ${PWD}
#cd '/Users/dilipts/OneDrive/Dev/Local/Covid/covid-chestxray-dataset'

cp -R '/Users/dilipts/OneDrive/Dev/Local/Covid/covid-19-analysis-demo/src/dataset' assets/
find assets/dataset/covid -type f > assets/covid_list.txt
find assets/dataset/normal -type f > assets/normal_list.txt
cp '/Users/dilipts/OneDrive/Dev/Local/Covid/covid-19-analysis-demo/src/plots/covid19-plot.png' assets/

