clear all;
close all;

%% Path declaration
corepth = 'UG3_enhancer_validation_images_forCSHL';
% perfov = 'PCBP3/E5_ISH-GAD';
% perfov = 'PCBP3/E5_antiPCBP3';
% perfov = 'D2/ISH_Adora2a';
% perfov = 'D2/ISH_Drd2';
% perfov = 'DA/DA_E4-GFP_E8-RFP/ISH_DAT';
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
direc = dir(fullfile(fpath, '*.tif'));

numDapi = []; numMarker =[]; numEnhc=[]; numTP=[];
for fN = 1 : length(direc)
    fileName = direc(fN).name;   
    
    outpth = ['OPR4' filesep perfov];
    fileNamePth = fileName(1:end-4);
    outfilePth = [outpth filesep fileNamePth];
    
    markerFileName = [outfilePth filesep fileNamePth '_antibody.csv'];
    dapiFileName = [outfilePth filesep fileNamePth '_DAPI.csv'];
    % enhcFileName = [outfilePth filesep fileNamePth '_enhcVirus.csv'];
    enhcFileName = [outfilePth filesep fileNamePth '_enhcVirus1.csv'];
    % enhcFileName = [outfilePth filesep fileNamePth '_enhcVirus2.csv'];
    
    dapiCoords = []; markerCoords =[]; enhcCoords=[];
    %% Read Files
    dapiTab = table2array(readtable(dapiFileName));
    dapiCoords(1:size(dapiTab,2)/2,1) = round(dapiTab(1:size(dapiTab,2)/2));
    dapiCoords(1:size(dapiTab,2)/2,2) = round(dapiTab(size(dapiTab,2)/2+1:end));
    
    markerTab = table2array(readtable(markerFileName));
    markerCoords(1:size(markerTab,2)/2,1) = round(markerTab(1:size(markerTab,2)/2));
    markerCoords(1:size(markerTab,2)/2,2) = round(markerTab(size(markerTab,2)/2+1:end));
    
    enhcTab = table2array(readtable(enhcFileName));
    enhcCoords(1:size(enhcTab,2)/2,1) = round(enhcTab(1:size(enhcTab,2)/2));
    enhcCoords(1:size(enhcTab,2)/2,2) = round(enhcTab(size(enhcTab,2)/2+1:end));
    
    %% Counting cells 
    numDapi(fN) = size(dapiCoords,1);
    numMarker(fN) = size(markerCoords,1);
    numEnhc(fN) = size(enhcCoords,1);
    
    

    %% Getting TP
    TP = [];
    B = markerCoords;
    for i = 1 : numEnhc(fN)
        A = enhcCoords(i,:);
        distances = sqrt(sum(bsxfun(@minus, B, A).^2,2));
        closest = B(distances==min(distances),:);
        closest_distance = sqrt(sum(bsxfun(@minus, closest, A).^2,2));
        if closest_distance < 10
            TP = [TP; A];
        end
    end
    
    numTP(fN) = size(TP,1);

    %%
    sns(fN) = numTP(fN) / numMarker(fN);
    spec(fN) = (numDapi(fN) - numMarker(fN) - numEnhc(fN) + numTP(fN)) ...
        / (numDapi(fN) - numMarker(fN));
    % prec(fN) = numTP(fN) / numEnhc(fN);
end

%% Sensitivity & Specificity



% sensitivity = sum(numTP) / sum(numMarker);
% specificity = (sum(numDapi) - sum(numMarker) - sum(numEnhc) + sum(numTP)) ...
%     / (sum(numDapi) - sum(numMarker));
% precision = sum(numTP) / sum(numEnhc);

%% CROP Extra
% data = bfopen(fullfile(fpath, fileName));
% 
% % imgTif = imread(fullfile(filePath, fileName));
% 
% seriesCount = size(data, 1);
% series1 = data{1, 1};
% metadataList = data{1, 2};
% 
% n = 1;
% series1_planeCount = size(series1, 1);
% series1_plane1 = series1{n, 1};
% series1_label1 = series1{n, 2};
% 
% n = 2;
% series1_planeCount = size(series1, 1);
% series1_plane2 = series1{n, 1};
% series1_label1 = series1{n, 2};
% 
% n = 3;
% series1_planeCount = size(series1, 1);
% series1_plane3 = series1{n, 1};
% series1_label1 = series1{n, 2};
% 
% % n = 4;
% % series1_planeCount = size(series1, 1);
% % series1_plane4 = series1{n, 1};
% % series1_label1 = series1{n, 2};
% 
% img(:,:,3) = uint8(series1_plane1*0.5);
% img(:,:,2) = uint8(series1_plane2*0.5);
% img(:,:,1) = uint8(series1_plane3*0.5);
% 
% figure; imshow(img); hold on;
% scatter(markerCoords(:,1), markerCoords(:,2), 20,'ro','filled');
% scatter(enhcCoords(:,1), enhcCoords(:,2), 20,'go','filled');
% 
% scatter(TP(:,1), TP(:,2), 20,'yo','filled')
% 
% figure; imshow(series1_plane1); hold on;
% 
% 
% pgon = polyshape([400 400 1050 1050], [1500 2300 2300 1500]);
% plot(pgon)
% 
% [inM, onM] = inpolygon(markerCoords(:,1), markerCoords(:,2), ...
%     [400 400 1050 1050], [1500 2300 2300 1500]);
% 
% [inE, onE] = inpolygon(enhcCoords(:,1), enhcCoords(:,2), ...
%     [400 400 1050 1050], [1500 2300 2300 1500]);
% 
% [inD, onD] = inpolygon(dapiCoords(:,1), dapiCoords(:,2), ...
%     [400 400 1050 1050], [1500 2300 2300 1500]);
% 
% [inT, onT] = inpolygon(TP(:,1), TP(:,2), ...
%     [400 400 1050 1050], [1500 2300 2300 1500]);
% 
% markerCoordsBB = markerCoords(inM, :);
% enhcCoordsBB = enhcCoords(inE, :);
% dapiCoordsBB = dapiCoords(inD, :);
% TPBB = TP(inT, :);
% 
% figure; imshow(uint8(series1_plane1*0.5)); hold on;
% scatter(dapiCoords(:,1), dapiCoords(:,2), 20,'bo','filled');
% 
% figure; imshow(uint8(series1_plane3*0.5)); hold on;
% scatter(enhcCoords(:,1), enhcCoords(:,2), 20,'ro','filled');
% 
% % figure; imshow(uint8(series1_plane4*0.1)); hold on;
% % scatter(markerCoords(:,1), markerCoords(:,2), 20,'ro','filled');
% 
% spc = (sum(inD) - sum(inM) - sum(inE) + sum(inT)) / (sum(inD) - sum(inM));
% sns = sum(inT) / sum(inM);
% prc = sum(inT) / sum(inE);
% 
% hold on;
% scatter(markerCoordsBB(:,1), markerCoordsBB(:,2), 20,'ro','filled');
% scatter(enhcCoordsBB(:,1), enhcCoordsBB(:,2), 20,'go','filled');
% scatter(dapiCoordsBB(:,1), dapiCoordsBB(:,2), 20,'bo','filled');
% 
% scatter(TPBB(:,1), TPBB(:,2), 20,'yo','filled')
