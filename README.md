# freesurfer_label_operations
Some codes I wrote up to do between and within subject comparison of anatomical ROIs, in either unix, matlab or R

*Not for public use as of now due to server update for a month; unable to access data and work on scripts* 

Description of pipeline:
* **1) Creation of annotation in subject native space and comparison**
 * *gathering labels in subject surface*  for extracting labels from standard atlases, individually select and sample each label to subject surface using mri_surf2surf with sphere as an intermediate registration space  for extracting labels from binary overlay .nii files, take out the labels with mri_cor2label, then combine into an annotation.  for our own manually drawn ROIs, we just used merging to create comparable label files.  for ROIs in volume space, will add.  for ROIs in standardized volume space (MNI305 or MNI152), will add.
  * *comparison in subject space using mris_parc_compute_overlap which calculates %overlap and t value of overlap for each pair of annotation*
 * *Read the output file into Matlab*
* **2) Sample labels into fsaverage surface using mri_surf2surf**
*  **3)Do pairwise comparison on fsaverage surface and read output file into Matlab**
*  **4)Visualize trend in t scores**


    
