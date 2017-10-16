function showNImageTest(n)
%Q2- Hien thi anh co thu tu n và label tuong ung tap Test
imgTestAll = loadMNISTImages('./t10k-images.idx3-ubyte');
lblTestAll = loadMNISTLabels('./t10k-labels.idx1-ubyte');
imgTest = imgTestAll(:,n);
figure;
img2D = reshape(imgTest,28,28);
imshow(img2D);
strLabelTest = num2str(lblTestAll(n));
title(strLabelTest);
end