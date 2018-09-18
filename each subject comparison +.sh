#!/bin/bash
export FREESURFER_HOME=/home/cemnl-cmap/Desktop/freesurfer
source $FREESURFER_HOME/SetUpFreeSurfer.sh
cd $SUBJECTS_DIR
for subject in  "sub-06_AA" 
do 
mris_seg2annot --seg $subject/surf/lh.template_areas.mgz --ctab $FREESURFER_HOME/labels.txt --s $subject --hemi lh --o benson --surf inflated
mris_seg2annot --seg $subject/surf/rh.template_areas.mgz --ctab $FREESURFER_HOME/labels.txt --s $subject --hemi rh --o benson --surf inflated
mris_label2annot --s $subject --h lh --l $subject/label/Ros_1_lh.label --l $subject/label/Ros_2_lh.label --l $subject/label/Ros_3_lh.label --a ros --ctab $FREESURFER_HOME/labels.txt 
mris_label2annot --s $subject --h rh --l $subject/label/Ros_1_rh.label --l $subject/label/Ros_2_rh.label --l $subject/label/Ros_3_rh.label --a ros --ctab $FREESURFER_HOME/labels.txt 
mri_mergelabels -i $subject/label/V2d_LH.label -i $subject/label/V2v_LH.label -o $subject/label/V2_LH.label
mri_mergelabels -i $subject/label/V3d_LH.label -i $subject/label/V3v_LH.label -o $subject/label/V3_LH.label
mri_mergelabels -i $subject/label/V2d_RH.label -i $subject/label/V2v_RH.label -o $subject/label/V2_RH.label
mri_mergelabels -i $subject/label/V3d_RH.label -i $subject/label/V3v_RH.label -o $subject/label/V3_RH.label
mris_label2annot --s $subject --h lh --l $subject/label/V1_LH.label --l $subject/label/V2_LH.label --l $subject/label/V3v_LH.label --a manual_ros --ctab $FREESURFER_HOME/labels.txt 
mris_label2annot --s $subject --h rh --l $subject/label/V1_RH.label --l $subject/label/V2_RH.label --l $subject/label/V3v_RH.label --a manual_ros --ctab $FREESURFER_HOME/labels.txt
mris_label2annot --s $subject --h lh --l $subject/label/V1_LH.label --l $subject/label/V2_LH.label --l $subject/label/V3_LH.label --a manual --ctab $FREESURFER_HOME/labels.txt 
mris_label2annot --s $subject --h rh --l $subject/label/V1_RH.label --l $subject/label/V2_RH.label --l $subject/label/V3_RH.label --a manual --ctab $FREESURFER_HOME/labels.txt  
mris_compute_parc_overlap --s $subject --hemi lh --annot1 benson --annot2 manual --debug-overlap >> linux-comparison_final.txt 
mv $subject/label/lh.overlap.annot $subject/label/lh.overlap_btom.annot
#btom means benson to manual, also did only v in manual annot bc ros doesnt have v3d
mris_compute_parc_overlap --s $subject --hemi rh --annot1 benson --annot2 manual --debug-overlap >> linux-comparison_final.txt 
mv $subject/label/rh.overlap.annot $subject/label/rh.overlap_btom.annot
mris_compute_parc_overlap --s $subject --hemi lh --annot1 benson --annot2 ros --debug-overlap >> linux-comparison_final.txt 
mv $subject/label/lh.overlap.annot $subject/label/lh.overlap_btor.annot
mris_compute_parc_overlap --s $subject --hemi rh --annot1 benson --annot2 ros --debug-overlap >> linux-comparison_final.txt 
mv $subject/label/rh.overlap.annot $subject/label/rh.overlap_btor.annot
mris_compute_parc_overlap --s $subject --hemi lh --annot1 manual_ros --annot2 ros --debug-overlap >> linux-comparison_final.txt 
mv $subject/label/lh.overlap.annot $subject/label/lh.overlap_mtor.annot
mris_compute_parc_overlap --s $subject --hemi rh --annot1 manual_ros --annot2 ros --debug-overlap >> linux-comparison_final.txt 
mv $subject/label/rh.overlap.annot $subject/label/rh.overlap_mtor.annot
done

          
