% Accuracy(1,1): tham so NumNeighbors, k = 1
% Accuracy(1,3): tham so NumNeighbors, k = 3
% Accuracy(2,1): tham so Distance, do do minkowski
% Accuracy(3,1): tham so Distance, do do euclidean
function d = Accuracy(param,number)
    imgTrainImagesAll = loadMNISTImages('train-images.idx3-ubyte');
	lblTrainLabelsAll = loadMNISTLabels('train-labels.idx1-ubyte');
    imgTestImagesAll = loadMNISTImages('t10k-images.idx3-ubyte');
	lblTestLabelsAll = loadMNISTLabels('t10k-labels.idx1-ubyte');
    switch(param)
        case (1)
            Md1 = fitcknn(imgTrainImagesAll', lblTrainLabelsAll, 'NumNeighbors', number);
        case (2)
            Md1 = fitcknn(imgTrainImagesAll', lblTrainLabelsAll, 'Distance','minkowski');
        case (3)
            Md1 = fitcknn(imgTrainImagesAll', lblTrainLabelsAll, 'Distance','euclidean');
    end
    nNumTestImgs = size(imgTestImagesAll,2);
    count = 0;
    for nNumber = 1 : nNumTestImgs
        fprintf('\n%d ',nNumber);
        img = imgTestImagesAll(:,nNumber);
        lblPredictTest = predict(Md1, img');
        if(lblPredictTest == lblTestLabelsAll(nNumber))
           count = count + 1;
        end
    end
    d = (count / nNumTestImgs) * 100;
    fprintf('Do chinh xac: %8.3f',d);
end
