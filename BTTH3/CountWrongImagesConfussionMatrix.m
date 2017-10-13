function CountWrongImagesConfussionMatrix()
%Q7*Dem so luong anh co label n bi nhan dang sai va lap Confusion matrix
    imgTrainImagesAll = loadMNISTImages('train-images.idx3-ubyte');
	lblTrainLabelsAll = loadMNISTLabels('train-labels.idx1-ubyte');
    Mdl = fitcknn(imgTrainImagesAll', lblTrainLabelsAll);
    imgTestImagesAll = loadMNISTImages('t10k-images.idx3-ubyte');
	lblTestLabelsAll = loadMNISTLabels('t10k-labels.idx1-ubyte');  
    CMatrix = zeros(10,10);
    nNumTestImgs = size(imgTestImagesAll,2);
    for nNumber = 1 : nNumTestImgs
        imgTest = imgTestImagesAll(:,nNumber);
        lblImageTest = lblTestLabelsAll(nNumber);
        lblPredictTest = predict(Mdl, imgTest');
        CMatrix(lblImageTest+1,lblPredictTest+1) =CMatrix(lblImageTest+1,lblPredictTest+1)+1;
    end
    csvwrite('CMatrix.csv',CMatrix);
end