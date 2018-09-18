#!/bin/bash
cd $SUBJECTS_DIR
for subject in  "sub-06_AA" "sub-07_AB" "sub-08_AC" "sub-06_AA_2" "sub-08_AC_1" "sub-01_MW"
do 
mri_cor2label --i $subject/surf/lh.template_areas.mgz --id 1 --l lh.template_areas.V1.label --surf $subject lh 
mri_cor2label --i $subject/surf/rh.template_areas.mgz --id 1 --l rh.template_areas.V1.label --surf $subject rh
mri_cor2label --i $subject/surf/lh.template_areas.mgz --id 2 --l lh.template_areas.V2.label --surf $subject lh
mri_cor2label --i $subject/surf/rh.template_areas.mgz --id 2 --l rh.template_areas.V2.label --surf $subject rh
mri_cor2label --i $subject/surf/lh.template_areas.mgz --id 3 --l lh.template_areas.V3.label --surf $subject lh
mri_cor2label --i $subject/surf/rh.template_areas.mgz --id 3 --l rh.template_areas.3.label --surf $subject rh
mris_label2annot --s $subject --h lh --l lh.template_areas.V1.label --l lh.template_areas.V2.label --l lh.template_areas.V3.label --a benson_lh
mris_label2annot --s $subject --h rh --l rh.template_areas.V1.label --l rh.template_areas.V2.label --l rh.template_areas.V3.label --a benson_rh
mris_label2annot --s $subject --h lh --l Ros_1_lh.label --l Ros_2_lh.label --l Ros_3_lh.label --a ros_lh
mris_label2annot --s $subject --h rh --l Ros_1_rh.label --l Ros_2_rh.label --l Ros_3_rh.label --a ros_rh
mri_mergelabels -i V2d_LH.label --i V2v_LH.label --o V2_LH.label
mri_mergelabels -i V3d_LH.label --i V3v_LH.label --o V3_LH.label
mri_mergelabels -i V2d_RH.label --i V2v_RH.label --o V2_RH.label
mri_mergelabels -i V3d_RH.label --i V3v_RH.label --o V3_RH.label
mris_label2annot --s $subject --h lh --l V1_LH.label --l V2_LH.label --l V3_LH.label --a manual_lh
mris_label2annot --s $subject --h rh --l V1_RH.label --l V2_RH.label --l V3_RH.label --a manual_rh
mris_compute_parc_overlap --s $subject --hemi lh --annot1 benson_lh --annot2 manual_lh 

#need to move colortable for mris_label2annot command; need to check if this will only do it if the label names are the same
#need to rewrite color lut table for labels? :maybe just not do annot at all? do loop for numbers and hemispheres

 done


          
