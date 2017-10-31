function CountWrongImagesConfussionMatrix()
%Q7*Dem so luong anh co label n bi nhan dang sai va lap Confusion matrix
    imgTrainImagesAll = importdata('imgTrainImagesAll.mat');
	lblTrainLabelsAll = importdata('lblTrainLabelsAll.mat');
    Mdl = fitcknn(imgTrainImagesAll', lblTrainLabelsAll);
    imgTestImagesAll = importdata('imgTestImagesAll.mat');
	lblTestLabelsAll = importdata('lblTestLabelsAll.mat');
    CMatrix = zeros(40,40);
    nNumTestImgs = size(imgTestImagesAll,2);
    for nNumber = 1 : nNumTestImgs
        imgTest = imgTestImagesAll(:,nNumber);
        lblImageTest = lblTestLabelsAll(nNumber);
        lblPredictTest = predict(Mdl, imgTest');
        CMatrix(lblImageTest,lblPredictTest) =CMatrix(lblImageTest,lblPredictTest)+1;
    end
    csvwrite('CMatrix.csv',CMatrix);
end