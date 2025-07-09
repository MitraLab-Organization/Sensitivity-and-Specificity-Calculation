clear all;
close all;

%% Path declaration
corepth = 'OPR4_img';
% perfov = 'PCBP3/E5_ISH-GAD';
% perfov = 'PCBP3/E5_antiPCBP3';
% perfov = 'D2/ISH_Adora2a';
% perfov = 'D2/ISH_Drd2';
% perfov = 'DA/DA_E4-GFP_E8-RFP/antiTH';
% perfov = 'FOXP2_RORB/antiRORB_E4_E9';
% perfov = 'FOXP2_RORB/antiFOXP2_E4_E9';
% perfov = 'SST/ISH_SST_E2';
% perfov = 'SST\SST_E2_secondary_marker_Calbindin';
% perfov = 'TAC3/tandem';
% perfov = 'BCL11b\BCL11b_primary_marker_CTIP2';
% perfov = 'BCL11b\BCL11b_secondary_marker_FOXP2';
% perfov  = 'CHAT\CHAT-RicE1-secondary_marker';
perfov  = 'CHAT\CHAT-RicE1-aCHAT_primary_marker';
fpath = [corepth filesep perfov];
outpth = ['OPR4' filesep perfov];
outpth_img = ['OPR4' filesep perfov filesep 'outImgDet'];
mkdir(outpth);
mkdir(outpth_img);
direc = dir(fpath);

for fN = 1 : size(direc)

    fileName = direc(fN).name;
    outfilePth = [outpth filesep fileName];
    mkdir(outfilePth);
    %% Read images
    enh1 = imread(fullfile(direc(fN).folder, ...
        fullfile(direc(fN).name,[direc(fN).name '_enhc.tif']))); % For PCBP3/SST
    % enh1 = imread(fullfile(direc(fN).folder, ...
    %     fullfile(direc(fN).name,[direc(fN).name '_enhc1.tif'])));
    % enh2 = imread(fullfile(direc(fN).folder, ...
    %     fullfile(direc(fN).name,[direc(fN).name '_enhc2.tif'])));
    mrkr = imread(fullfile(direc(fN).folder, ...
        fullfile(direc(fN).name,[direc(fN).name '_marker.tif'])));
    dapi = imread(fullfile(direc(fN).folder, ...
        fullfile(direc(fN).name,[direc(fN).name '_dapi.tif'])));
    
    %% 
    
    %% For IM1, enh1
    % im1 = imread([fpath filesep fname4 '.tif']);
    %% PCBP3/E5_ISH-GAD
    % im1 = im2double(enh1).^3; % Img 5,6
    % im1 = im2double(enh1).^1.5; % Img 1-4
    % im1 = uint8(im1*255); % Img 1-6
    % im1(im1<200) = 0; % Img 5,6
    % im1(im1<100) = 0; % Img 4    
    %% PCBP3/E5_antiPCBP3
    % im1 = im2double(enh1).^2;
    % im1 = uint8(im1*255);
    %% D2/ISH_Adora2a
    % im1 = uint8(enh1);
    % im1(im1<200) = 0;
    %% D2/ISH_Drd2
    % im1 = uint8(enh1);
    % im1(im1<200) = 0;
    %% DA/ISH_DAT
    % im1 = uint8(enh1);
    % im1(im1<200) = 0;
    %% DA/antiTH
    % im1 = uint8(enh1);
    % im1(im1<100) = 0;
    %% FOXP2_RORB/antiRORB
    % im1 = uint8(enh1);
    % im1(im1<150) = 0;
    %% FOXP2_RORB/antiFOXP2
    % im1 = uint8(enh1);
    % im1(im1<100) = 0;
    %% ISH_SST_E2/SST
    % im1 = im2double(enh1).^4;
    % im1 = uint8(im1*255);
    % im1(im1<100) = 0;
    %% SST\SST_E2_secondary_marker_Calbindin
    % im1 = uint8(enh1);
    % % im1(im1<50) = 0; % Img 1
    % im1(im1<100) = 0; % Img 2,3
    %% TAC3/tandem
    % im1 = uint8(enh1);
    % im1(im1<100) = 0; % img 2
    %% BCL11b\BCL11b_primary_marker_CTIP2
    % im1 = uint8(enh1);
    % % im1(im1<150) = 0; % Img 2
    % im1(im1<100) = 0; % Img 3
    %% BCL11b\BCL11b_secondary_marker_FOXP2
    % im1 = uint8(enh1);
    % im1(im1<150) = 0; % img 2
    % im1(im1<100) = 0; % img 1
    %% CHAT\CHAT-RicE1-secondary_marker
    % im1 = uint8(enh1);
    % im1(im1<100) = 0; % Img 1-7
    %% CHAT\CHAT-RicE1-primary_marker
    im1 = uint8(enh1);
    % im1(im1<100) = 0; % Img 1-2,9-12
    im1(im1<150) = 0; % Img 10
    %%
    imbin1 = imbinarize(im1);
    % figure; imshow(imbin1);
    imfilt1 = bwareaopen(imbin1,50);
    % imfilt1 = bwareaopen(imbin1,500); % only TAC3/tandem, 
    % imfilt1 = bwareaopen(imbin1,500); % only BCL11b\BCL11b_primary_marker_CTIP2 Img 1
    % imfilt1 = bwareaopen(imbin1,150); % only BCL11b\BCL11b_primary_marker_CTIP2 Img 2
    % imfilt1 = bwareaopen(imbin1,20); % only SST Img 6,7,8
    cc1 = bwconncomp(imfilt1);
    cents = regionprops(cc1,'Centroid');
    for i = 1:length(cents)
        curcents = cents(i).Centroid;
        meanx(i) = curcents(1);
        meany(i) = curcents(2);
    end
    coords1 = meanx; coords2 = meany;
    f1tab = table(coords1,coords2);
    writetable(f1tab,[outfilePth filesep fileName '_enhcVirus1.csv']);
    f1 = figure; imshow(enh1); hold on;
    scatter(meanx,meany,20,'ro','filled'); hold on;
    clear meanx meany
    saveas(f1, [outpth_img filesep [direc(fN).name '_enhc1.tif']]);
    % saveas(f1, [outpth_img filesep [direc(fN).name '_enhc.tif']]); % For PCBP3/SST
    
    %% For IM1, enh2
    % im1 = imread([fpath filesep fname1 '.tif']);
    % im4(im4<200) = 0;
    %% D2/ISH_Adora2a
    % im4 = uint8(enh2);
    % im4(im4<250) = 0; % Img 2
    % im4(im4<200) = 0; % Img 1
    %% D2/ISH_Drd2
    % im4 = uint8(enh2);
    % im4(im4<100) = 0;
    %% DA/ISH_DAT
    % im4 = uint8(enh2);
    % im4(im4<100) = 0;
    %% DA/antiTH
    % im4 = uint8(enh2);
    % im4(im4<100) = 0;
    %% FOXP2_RORB/antiRORB
    % im4 = uint8(enh2); % Img 1,3
    % im4(im4<100) = 0; % Img 1,3
    % im4 = im2double(enh2).^2.5; % Img 2
    % im4 = uint8(im4*255); % Img 2
    %% FOXP2_RORB/antiFOXP2
    % im4 = im2double(enh2).^1.5; 
    % im4 = uint8(im4*255);  
    % im4(im4<100) = 0;
    % %%
    % imbin4 = imbinarize(im4);
    % % figure; imshow(imbin4);
    % imfilt4 = bwareaopen(imbin4,50);
    % cc4 = bwconncomp(imfilt4);
    % cents = regionprops(cc4,'Centroid');
    % for i = 1:length(cents)
    %     curcents = cents(i).Centroid;
    %     meanx(i) = curcents(1);
    %     meany(i) = curcents(2);
    % end
    % coords1 = meanx; coords2 = meany;
    % f1tab = table(coords1,coords2);
    % writetable(f1tab,[outfilePth filesep fileName '_enhcVirus2.csv']);
    % f4 = figure; imshow(enh2); hold on;
    % scatter(meanx,meany,20,'ro','filled'); hold on;
    % clear meanx meany
    % saveas(f4, [outpth_img filesep [direc(fN).name '_enhc2.tif']]);


    %% For IM2, CHAT, marker, antibody
    % im2 = imread([fpath filesep fname2 '.tif']);
    %% PCBP3/E5_ISH-GAD
    % im2 = im2double(mrkr).^3; % Img 5,6
    % im2 = uint8(im2*255); % Img 5,6
    % im2(im2<200) = 0; % Img 5,6
    % im2 = uint8(mrkr); % Img 1-4
    %% PCBP3/E5_antiPCBP3
    % im2 = uint8(mrkr);
    %% D2/ISH_Adora2a
    % im2 = uint8(mrkr);
    % im2(im2<200) = 0; % Img 2
    %% D2/ISH_Drd2
    % im2 = uint8(mrkr);
    %% DA/ISH_DAT
    % im2 = uint8(mrkr);
    %% DA/antiTH
    % im2 = im2double(mrkr).^4;
    % im2 = uint8(im2*255);
    % im2(im2<100) = 0;
    %% FOXP2_RORB/antiRORB
    % im2 = im2double(mrkr).^2.5;
    % im2 = uint8(im2*255);
    % im2(im2<100) = 0;
    %% FOXP2_RORB/antiFOXP2
    % im2 = im2double(mrkr).^2.5;
    % im2 = uint8(im2*255);
    % im2(im2<100) = 0;
    %% ISH_SST_E2/SST
    % im2 = im2double(mrkr).^2.5;
    % im2 = uint8(im2*255);
    %% SST\SST_E2_secondary_marker_Calbindin
    % im2 = uint8(mrkr);
    % im2(im2<100) = 0;
    %% TAC3/tandem
    % im2 = uint8(mrkr);
    % im2(im2<150) = 0; % Img 2,3
    % im2(im2<50) = 0; % Img 1
    %% BCL11b\BCL11b_primary_marker_CTIP2/FOXP2
    % im2 = im2double(mrkr).^1.5;
    % im2 = uint8(im2*255);
    %% CHAT\CHAT-RicE1-secondary_marker
    % im2 = uint8(mrkr);
    % % im2(im2<100) = 0; % Img 1,2
    % im2(im2<50) = 0; % Img 3-8
    %% CHAT\CHAT-RicE1-primary_marker
    im2 = uint8(mrkr);
    im2(im2<100) = 0; % Img 10
    % im2(im2<50) = 0; % Img 1,2,9-12
    %%
    imbin2 = imbinarize(im2);
    % figure; imshow(imbin2);
    imfilt2 = bwareaopen(imbin2,50);
    % imfilt2 = bwareaopen(imbin2,20); % for CHAT\CHAT-RicE1-secondary_marker
    % imfilt2 = bwareaopen(imbin2,10); % only BCL11b\BCL11b_primary_marker_CTIP2
    % imfilt2 = bwareaopen(imbin2,500); % only TAC3/tandem : Img 1
    % imfilt2 = bwareaopen(imbin2,100); % only TAC3/tandem : Img 2,3
    % imfilt2 = bwareaopen(imbin2,20); % only SST Img 5 
    % imfilt2 = bwareaopen(imbin2,10); % only SST Img 6,7,8 
    cc2 = bwconncomp(imfilt2);
    cents = regionprops(cc2,'Centroid');
    for i = 1:length(cents)
        curcents = cents(i).Centroid;
        meanx(i) = curcents(1);
        meany(i) = curcents(2);
    end
    coords1 = meanx; coords2 = meany;
    f2tab = table(coords1,coords2);
    writetable(f2tab,[outfilePth filesep fileName  '_antibody.csv']);
    f2 = figure; imshow(mrkr); hold on;
    scatter(meanx,meany,20,'ro','filled'); hold on;
    clear meanx meany
    saveas(f2, [outpth_img filesep [direc(fN).name '_antibody.tif']]);
    
    %% For IM3, NeuN/DAPI
    % im3 = imread([fpath filesep fname3 '.tif']);
    %% PCBP3/E5_ISH-GAD
    % im3 = im2double(dapi).^3; % Img 5
    % im3 = im2double(dapi).^1.5; % Img 1-3,6
    % im3 = uint8(im3*255); % Img 1-3,5,6
    % im3(im3<100) = 0; % Img 1-3,5,6
    % im3 = uint8(dapi); % Img 4
    %% PCBP3/E5_antiPCBP3
    % im3 = uint8(dapi);
    %% D2/ISH_Adora2a
    % im3 = uint8(dapi);
    % im3(im3<200) = 0; % Img 1
    %% D2/ISH_Drd2
    % im3 = uint8(dapi);
    %% DA/ISH_DAT
    % im3 = uint8(dapi);
    %% DA/antiTH
    % im3 = uint8(dapi);
    %% FOXP2_RORB/antiRORB
    % im3 = uint8(dapi);
    %% FOXP2_RORB/antiFOXP2
    % im3 = uint8(dapi); 
    %% ISH_SST_E2/SST
    % im3 = uint8(dapi);
    %% SST\SST_E2_secondary_marker_Calbindin
    % im3 = uint8(dapi);
    %% TAC3/tandem
    % im3 = uint8(dapi);
    %% BCL11b\BCL11b_primary_marker_CTIP2/FOXP2
    % im3 = im2double(dapi).^1.25; 
    % im3 = uint8(im3*255);
    % im3(im3<10) = 0;
    %% CHAT\CHAT-RicE1-secondary_marker
    im3 = uint8(dapi);
    %%
    imbin3 = imbinarize(im3);
    % figure; imshow(imbin3);
    imfilt3 = bwareaopen(imbin3,10); % for BCL11b
    % imfilt3 = bwareaopen(imbin3,150); % only TAC3/tandem : Img 3
    % imfilt3 = bwareaopen(imbin3,500); % only TAC3/tandem : Img 1,2
    cc3 = bwconncomp(imfilt3);
    cents = regionprops(cc3,'Centroid');
    for i = 1:length(cents)
        curcents = cents(i).Centroid;
        meanx(i) = curcents(1);
        meany(i) = curcents(2);
    end
    coords1 = meanx; coords2 = meany;
    f3tab = table(coords1,coords2);
    writetable(f3tab,[outfilePth filesep fileName '_DAPI.csv']);
    f3 = figure; imshow(dapi); hold on;
    scatter(meanx,meany,20,'ro','filled'); hold on;
    clear meanx meany
    saveas(f3, [outpth_img filesep [direc(fN).name '_DAPI.tif']]);
end


