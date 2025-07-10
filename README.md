# Sensitivity-and-Specificity-Calculation
Calculation of Sensitivity and Specificity for Enhancer-based images

## Setup
- Requires MATLAB 2022b+
- Clone the repository
- Create two folders: OPR_img, OPR4
- Download the [JAR](https://drive.google.com/file/d/1QsUZE0iuNcTvmb4uFuyjx8QumM7EAAY4/view?usp=sharing) package and place it in the folder
- Add to the path the folder [bfmatlab](https://github.com/MitraLab-Organization/Sensitivity-and-Specificity-Calculation/tree/main/bfmatlab/bfmatlab), with its sub-folders
- Download the folder for pre-processed channel-wise images [Download image](https://drive.google.com/drive/folders/1jow6-PwMH-pGd_4WXsnIezbj2LBiIAbP?usp=drive_link)

## Running the Codes

### [getImages_UG3_Samik.m](https://github.com/MitraLab-Organization/Sensitivity-and-Specificity-Calculation/blob/main/getImages_UG3_Samik.m)
    - Conversion of Bio-format images to separate channels
    - Optional; if you have not downloaded the channel-wise images as stated above
    - Lines 6-14: perfov: Enhancer-Marker combination (only one should be uncommented)
    - Line 15: Individual Filename
    - Lines 49-52: Uncomment for Double Enhancer only
    - Lines 123-125, 137, 141, 146, 150: Uncommnet for single enhancer (Comment Lines 127-136, 139-140, 144-145, 148-149)
    - Lines 127-136, 139-140, 144-145, 148-149: Uncommnet for double enhancer (Comment Lines 123-125, 137, 141, 146, 150)
    - Certain special heuristic pre-processing parameters are mentioned in the comment for some images; uncomment accordingly

### [ug3_enhcSpecTest_Samik_New.m](https://github.com/MitraLab-Organization/Sensitivity-and-Specificity-Calculation/blob/main/ug3_enhcSpecTest_Samik_New.m)
    - Detection of Cells marked across each Channel by Morphological techniques
    - Input Folder: OPR4_img containing the channel-wise images downloaded above (or generated above)
    - Ouput Folder: OPR4 containing Cell-cemeters of detected cells and detection overlayed on the image channel
    - Lines 6-20: perfov: Enhancer-Marker combination (only one should be uncommented)
    - Lines 46-123: Detect cells marked by enhancer1 in case of double enhancer or single enhancer (Uncomment only one code block corresponding to the Enhancer-Marker combination) 
    - Lines 125-167: Detect cells marked by enhancer2 in case of double enhancer (Uncomment only one code block corresponding to the Enhancer-Marker combination)
    - Lines 170-242: Detect cells marked by marker (Uncomment only one code block corresponding to the Enhancer-Marker combination)
    - Lines 244-298: Detect cells marked by DAPI (Uncomment only one code block corresponding to the Enhancer-Marker combination)
    - Certain special heuristic morphological parameters are mentioned in the comment for some images; uncomment accordingly

### [calc_spec_sens_Samik.m](https://github.com/MitraLab-Organization/Sensitivity-and-Specificity-Calculation/blob/main/calc_spec_sens_Samik.m)
    - Prerequisite: Run ug3_enhcSpecTest_Samik_New.m to get Detection CSVs
    - Calculation Specificity and Sensitivity according to detected cells
    - Lines 6-20: perfov: Enhancer-Marker combination (only one should be uncommented)
    - Line 35: Uncomment for single/double enhancer (Comment Line 36)
    - Line 36: Uncomment for double enhancer
    - Output: Array sens[] for all samples for sensitivity, Array spec[] for all samples for specificity
