function RecognitionTestImages(n)
%Q5 - Function tra ve ket qua nhan dang cua anh trong tap Test co thu
%tu n ([1,10000]).
    imgTestAll = importdata('imgTestImagesAll.mat');
    lblTestAll = importdata('lblTestLabelsAll.mat');
    imgTrainImagesAll = importdata('imgTrainImagesAll.mat');
    lblTrainLabelsAll = importdata('lblTrainLabelsAll.mat');
    Mdl = fitcknn(imgTrainImagesAll',lblTrainLabelsAll);
    imgTest = imgTestAll(:,n);
    lblPredictTest = predict(Mdl,imgTest');
    lblImageTest = lblTestAll(n);
    fprintf('\nBan dau: %s',num2str(lblTestAll(n)));
    fprintf('\nDu doan: %s',num2str(lblPredictTest));
    if(lblPredictTest==lblImageTest)
        fprintf('\n Ket qua dung');
    else
        fprintf('\n Ket qua sai');
    end
end