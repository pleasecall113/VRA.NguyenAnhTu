function showNImageTest(n)
%Q2- Hien thi anh co thu tu n và label tuong ung tap Test
imgTestAll = importdata('imgTestImagesAll.mat');
lblTestAll = importdata('lblTestLabelsAll.mat');
imgTest = imgTestAll(:,n);
figure;
img2D = reshape(imgTest,112,92);
imshow(img2D);
strLabelTest = num2str(lblTestAll(n));
title(strLabelTest);
end