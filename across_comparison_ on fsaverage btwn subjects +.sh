#!/bin/bash
export FREESURFER_HOME=/home/cemnl-cmap/Desktop/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh
cd $SUBJECTS_DIR
for annot in "benson" "ros" "manual"
do
subject=( "sub-06_AA" "sub-07_AB" "sub-08_AC" "sub-01_MW" )
subjectlength=${#subject[@]}
for (( i=0; i<${subjectlength}; i++)) 
do 
for (( x=$i+1; x<${subjectlength}; x++))
do
mris_compute_parc_overlap --s fsaverage --hemi lh --annot1 "$annot"_"${subject[$i]}" --annot2 "$annot"_"${subject[$x]}" >> across_comparison.txt 
echo "$annot"_"${subject[$i]}"
echo "$annot"_"${subject[$x]}"
done
done
done 
