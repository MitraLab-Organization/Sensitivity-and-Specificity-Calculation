clear all;
close all;

%% Path declaration
corepth = 'UG3_enhancer_validation_images_forCSHL';
% perfov = 'FOXP2_RORB/antiFOXP2_E4_E9';
% perfov = 'SST/ISH_SST_E2';
% perfov = 'DA/DA_E4-GFP_E8-RFP/antiTH';
% perfov = 'SST\SST_E2_secondary_marker_Calbindin';
% perfov = 'TAC3/tandem';
% perfov = 'BCL11b\BCL11b_primary_marker_CTIP2';
% perfov = 'BCL11b\BCL11b_secondary_marker_FOXP2';
% perfov  = 'CHAT\CHAT-RicE1-secondary_marker';
perfov  = 'CHAT\CHAT-RicE1-aCHAT_primary_marker';
fileName = 'MAX_cjSatsuma_ChATSysInj_Plate1B1S1_DAPI_-CHAT_E1_aChAT647_10xStack_A01_G001_0015.tif';


fpath = [corepth filesep perfov];
outpth = ['OPR4_img' filesep perfov];
mkdir(outpth);
fileNamePth = fileName(1:end-4);
outfilePth = [outpth filesep fileNamePth];
mkdir (outfilePth);

%% 
data = bfopen(fullfile(fpath, fileName));

% imgTif = imread(fullfile(filePath, fileName));

seriesCount = size(data, 1);
series1 = data{1, 1};
metadataList = data{1, 2};

n = 1;
series1_planeCount = size(series1, 1);
series1_plane1 = series1{n, 1};
series1_label1 = series1{n, 2};

n = 2;
series1_planeCount = size(series1, 1);
series1_plane2 = series1{n, 1};
series1_label2 = series1{n, 2};

n = 3;
series1_planeCount = size(series1, 1);
series1_plane3 = series1{n, 1};
series1_label3 = series1{n, 2};

% n = 4;
% series1_planeCount = size(series1, 1);
% series1_plane4 = series1{n, 1};
% series1_label4 = series1{n, 2};


% img_enhc = uint8(series1_plane2*0.5);
%% For FOXP2_RORB/antiFOXP2
% img_enhc1 = uint8(series1_plane2); % Img 1 : cjFlorian_FRC-WA5-S2_cjFOXP2-RORBE4-488_cjFOXP2-RORBE9-555_aFOXP2-647_10X
% img_enhc2 = uint8(series1_plane3); % Img 1 
% img_marker = uint8(series1_plane4*0.5); % Img 1
% img_dapi = uint8(series1_plane1*2); % Img 1

% img_enhc1 = uint8(series1_plane2*0.25); % Img 2 : cjFlorian_FRC-WB5-S2_cjFOXP2-RORBE4-488_cjFOXP2-RORBE9-555_aFOXP2-647_10X
% img_enhc2 = uint8(series1_plane1*0.25); % Img 2 
% img_marker = uint8(series1_plane4*0.25); % Img 2
% img_dapi = uint8(series1_plane3); % Img 2

% img_enhc1 = uint8(series1_plane2*0.5); % Img 3 : cjFlorian_FRC-WC5-S2_cjFOXP2-RORBE4-488_cjFOXP2-RORBE9-555_aFOXP2-647_10X
% img_enhc2 = uint8(series1_plane1*0.5); % Img 3 
% img_marker = uint8(series1_plane4*0.25); % Img 3
% img_dapi = uint8(series1_plane3); % Img 3

%% For DA/antiTH
% img_enhc1 = uint8(series1_plane2*0.25);
% img_enhc2 = uint8(series1_plane3*0.25);
% img_marker = uint8(series1_plane4*0.1);
% img_dapi = uint8(series1_plane1*0.5);

%% For SST/ISH_SST_E2
% img_enhc = uint8(series1_plane2*0.5);
% img_marker = uint8(series1_plane3*0.25);
% img_dapi = uint8(series1_plane1*0.1);

%% For SST/SST_E2_secondary_marker_Calbindin
% img_enhc = uint8(series1_plane2*0.5);
% img_marker = uint8(series1_plane3*0.25);
% img_dapi = uint8(series1_plane1*0.5);

%% For TAC3/tandem
% img_enhc = uint8(series1_plane2*0.05);% Img 1 & 2
% img_marker = uint8(series1_plane3*0.05);% Img 1 & 2
% img_dapi = uint8(series1_plane1*0.05); % Img 1 & 2
% img_enhc = uint8(series1_plane2);% Img 3
% img_marker = uint8(series1_plane3);% Img 3
% img_dapi = uint8(series1_plane1); % Img 3

%% For BC11b/CTIP2
% img_enhc = uint8(series1_plane2*0.15); % Img 1,2
% img_enhc = uint8(series1_plane2*0.5); % Img 3
% img_marker = uint8(series1_plane3*0.5); % Img 1,3
% % img_marker = uint8(series1_plane3*0.1); % Img 2
% % img_dapi = uint8(series1_plane1*0.1); % Img 1,2
% img_dapi = uint8(series1_plane1); % Img 3

%% For BC11b/FOXP2
% img_enhc = uint8(series1_plane2*0.5); 
% img_marker = uint8(series1_plane3*0.15); 
% img_dapi = uint8(series1_plane1*0.1); 

% %% For CHAT/RicE1 - secondary
% img_enhc = uint8(series1_plane2*0.5); 
% img_marker = uint8(series1_plane3*0.1); 
% img_dapi = uint8(series1_plane1*0.15); 

%% For CHAT/RicE1 - secondary
img_enhc = uint8(series1_plane2*0.25); % Img 1-4
img_enhc = uint8(series1_plane2*0.15); % Img 5-12
img_marker = uint8(series1_plane3*0.1); 
% img_dapi = uint8(series1_plane1*0.15); % Img 1-4
img_dapi = uint8(series1_plane1*0.25); % Img 5-12



img(:,:,3) = img_dapi;
img(:,:,2) = img_enhc;
img(:,:,1) = img_marker;

% img1(:,:,3) = img_dapi;
% img1(:,:,2) = img_enhc1;
% img1(:,:,1) = img_marker;
% 
% img2(:,:,3) = img_dapi;
% img2(:,:,2) = img_enhc2;
% img2(:,:,1) = img_marker;

% figure; imshow(img1); 
% figure; imshow(img2);
figure; imshow(img);
figure; imshow(img_marker);
% figure; imshow(img_enhc1);
% figure; imshow(img_enhc2);
figure; imshow(img_enhc);
figure; imshow(img_dapi);

% imwrite(img1, [outfilePth filesep fileNamePth '_rgb1.png']);
% imwrite(img2, [outfilePth filesep fileNamePth '_rgb2.tif']);
imwrite(img, [outfilePth filesep fileNamePth '_rgb.tif']);
imwrite(img_marker, [outfilePth filesep fileNamePth '_marker.tif']);
% imwrite(img_enhc1, [outfilePth filesep fileNamePth '_enhc1.tif']);
% imwrite(img_enhc2, [outfilePth filesep fileNamePth '_enhc2.tif']);
imwrite(img_enhc, [outfilePth filesep fileNamePth '_enhc.tif']);
imwrite(img_dapi, [outfilePth filesep fileNamePth '_dapi.tif']);
