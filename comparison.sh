#!/bin/bash
cd $SUBJECTS_DIR
for subject in  "sub-06_AA" "sub-07_AB" "sub-08_AC" "sub-01_MW"
do 
mris_seg2annot --seg surf/lh.template_areas.mgz --ctab $FREESURFER_HOME/labels.txt --s sub-01_MW --hemi lh --o benson --surf inflated
mris_seg2annot --seg surf/rh.template_areas.mgz --ctab $FREESURFER_HOME/labels.txt --s sub-01_MW --hemi rh --o benson --surf inflated
mris_label2annot --s $subject --h lh --l Ros_1_lh.label --l Ros_2_lh.label --l Ros_3_lh.label --a ros --ctab $FREESURFER_HOME/labels.txt 
mris_label2annot --s $subject --h rh --l Ros_1_rh.label --l Ros_2_rh.label --l Ros_3_rh.label --a ros --ctab $FREESURFER_HOME/labels.txt 
mri_mergelabels -i V2d_LH.label --i V2v_LH.label --o V2_LH.label
mri_mergelabels -i V3d_LH.label --i V3v_LH.label --o V3_LH.label
mri_mergelabels -i V2d_RH.label --i V2v_RH.label --o V2_RH.label
mri_mergelabels -i V3d_RH.label --i V3v_RH.label --o V3_RH.label
mris_label2annot --s $subject --h lh --l V1_LH.label --l V2_LH.label --l V3_LH.label --a manual --ctab $FREESURFER_HOME/labels.txt 
mris_label2annot --s $subject --h rh --l V1_RH.label --l V2_RH.label --l V3_RH.label --a manual --ctab $FREESURFER_HOME/labels.txt 
mris_compute_parc_overlap --s $subject --hemi lh --annot1 benson --annot2 manual --debug-overlap --log $FREESURFER_HOME/comparison.txt 
mris_compute_parc_overlap --s $subject --hemi rh --annot1 benson --annot2 manual --debug-overlap --log $FREESURFER_HOME/comparison.txt 
mris_compute_parc_overlap --s $subject --hemi lh --annot1 benson --annot2 ros --debug-overlap --log $FREESURFER_HOME/comparison.txt 
mris_compute_parc_overlap --s $subject --hemi rh --annot1 benson --annot2 ros --debug-overlap --log $FREESURFER_HOME/comparison.txt 
mris_compute_parc_overlap --s $subject --hemi lh --annot1 manual --annot2 ros --debug-overlap --log $FREESURFER_HOME/comparison.txt 
mris_compute_parc_overlap --s $subject --hemi rh --annot1 benson --annot2 manual --debug-overlap --log $FREESURFER_HOME/comparison.txt 
 done


          
