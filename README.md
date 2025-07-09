# Sensitivity-and-Specificity-Calculation
Calculation of Sensitivity and Specificity for Enhancer-based images

## Setup
- Requires MATLAB 2022b+
- Clone the repository
- Create two folders: OPR_img, OPR4
- Download the [JAR](https://drive.google.com/file/d/1QsUZE0iuNcTvmb4uFuyjx8QumM7EAAY4/view?usp=sharing) package and place it in the folder
- Add to the path the folder [bfmatlab](https://github.com/MitraLab-Organization/Sensitivity-and-Specificity-Calculation/tree/main/bfmatlab/bfmatlab)
- Download the folder for pre-processed channel-wise images [Download image](https://drive.google.com/drive/folders/1jow6-PwMH-pGd_4WXsnIezbj2LBiIAbP?usp=drive_link)

## Running the Codes

### [getImages_UG3_Samik.m](https://github.com/MitraLab-Organization/Sensitivity-and-Specificity-Calculation/blob/main/getImages_UG3_Samik.m)
    - Conversion of Bio-format images to separate channels


### [ug3_enhcSpecTest_Samik_New.m](https://github.com/MitraLab-Organization/Sensitivity-and-Specificity-Calculation/blob/main/ug3_enhcSpecTest_Samik_New.m)
    - Detection of Cells marked across each Channel by Mophological techniques
    


### [calc_spec_sens_Samik.m](https://github.com/MitraLab-Organization/Sensitivity-and-Specificity-Calculation/blob/main/calc_spec_sens_Samik.m)
    - Calculation Specificity and Sensititvity according to detetced cells
