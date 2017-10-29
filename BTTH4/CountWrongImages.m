function CountWrongImages(n)
%Q7- Dem so luong anh co label n bi nhan dang sai
    imgTrainImagesAll = importdata('imgTrainImagesAll.mat');
	lblTrainLabelsAll = importdata('lblTrainLabelsAll.mat');
    Mdl = fitcknn(imgTrainImagesAll', lblTrainLabelsAll);
    imgTestImagesAll = importdata('imgTestImagesAll.mat');
	lblTestLabelsAll = importdata('lblTestLabelsAll.mat');
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