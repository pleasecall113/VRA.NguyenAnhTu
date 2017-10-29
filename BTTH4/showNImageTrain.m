function showNImageTrain(n)
%Q1- Hien thi anh co thu tu n và label tuong ung tap Train
imgTrainAll = importdata('imgTrainImagesAll.mat');
lblTrainAll = importdata('lblTrainLabelsAll.mat');
imgTrain = imgTrainAll(:,n);
figure;
img2D = reshape(imgTrain,112,92);
imshow(img2D);
strLabelTrain = num2str(lblTrainAll(n));
title(strLabelTrain);
end