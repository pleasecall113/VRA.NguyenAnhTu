% Accuracy(1,1): tham so NumNeighbors, k = 1 ->94.167
% Accuracy(1,3): tham so NumNeighbors, k = 3 -> 90.833
% Accuracy(2,1): tham so Distance, do do minkowski -> 94.167
% Accuracy(3,1): tham so Distance, do do euclidean -> 94.167
function d = Accuracy(param,number)
    imgTrainImagesAll = importdata('imgTrainImagesAll.mat');
	lblTrainLabelsAll = importdata('lblTrainLabelsAll.mat');
    imgTestImagesAll = importdata('imgTestImagesAll.mat');
	lblTestLabelsAll = importdata('lblTestLabelsAll.mat');
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
