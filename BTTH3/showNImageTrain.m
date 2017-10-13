function showNImageTrain(n)
%Q1- Hien thi anh co thu tu n và label tuong ung tap Train
imgTrainAll = loadMNISTImages('./train-images.idx3-ubyte');
lblTrainAll = loadMNISTLabels('./train-labels.idx1-ubyte');
imgTrain = imgTrainAll(:,n);
figure;
img2D = reshape(imgTrain,28,28);
imshow(img2D);
strLabelTrain = num2str(lblTrainAll(n));
title(strLabelTrain);
end