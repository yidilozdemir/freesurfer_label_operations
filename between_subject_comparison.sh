#!/bin/bash
# For each annotation type, compare t score of overlap for each subject pair possible. 
# Output is the across_comparison_annot file which will store/ append the comparison score for every subject pair. 
# Important to note that annotation names and subject names are hard-coded, I will work on these. 
cd $SUBJECTS_DIR
for annot in "benson" "ros" "manual"
do
subject=( "sub-06_AA" "sub-07_AB" "sub-08_AC" "sub-01_MW" )
subjectlength=${#subject[@]}
for (( i=0; i<${subjectlength}; i++)) 
do 
for (( x=$i+1; x<${subjectlength}; x++))
do
mris_compute_parc_overlap --s fsaverage --hemi lh --annot1  $annot"_"${subject[$i]} --annot2 $annot"_"${subject[$x]} >> across_comparison_"$annot".log 
mris_compute_parc_overlap --s fsaverage --hemi rh --annot1  $annot"_"${subject[$i]} --annot2 $annot"_"${subject[$x]} >> across_comparison_"$annot".log 
echo $annot"_"${subject[$i]}" comparison with "$annot"_"${subject[$x]}" is done"
done
done
done 
