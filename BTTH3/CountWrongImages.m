function CountWrongImages(n)
%Q7- Dem so luong anh co label n bi nhan dang sai
    imgTrainImagesAll = loadMNISTImages('train-images.idx3-ubyte');
	lblTrainLabelsAll = loadMNISTLabels('train-labels.idx1-ubyte');
    Mdl = fitcknn(imgTrainImagesAll', lblTrainLabelsAll);
    imgTestImagesAll = loadMNISTImages('t10k-images.idx3-ubyte');
	lblTestLabelsAll = loadMNISTLabels('t10k-labels.idx1-ubyte');  
    nNumTestImgs = size(imgTestImagesAll,2);
    count = 0;
    for nNumber = 1 : nNumTestImgs
        img = imgTestImagesAll(:,nNumber);
        lblPredictTest = predict(Mdl, img');
        if(lblPredictTest ~= lblTestLabelsAll(nNumber))
            if(lblTestLabelsAll(nNumber) == n)
                count = count + 1;
            end
        end
    end
    fprintf('\n%d',count);
end