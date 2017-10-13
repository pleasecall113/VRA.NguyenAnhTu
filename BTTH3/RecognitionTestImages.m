function RecognitionTestImages(n)
%Q5 - Function tra ve ket qua nhan dang cua anh trong tap Test co thu
%tu n ([1,10000]).
    imgTestAll = loadMNISTImages('./t10k-images.idx3-ubyte');
    lblTestAll = loadMNISTLabels('./t10k-labels.idx1-ubyte');
    imgTrainImagesAll = loadMNISTImages('train-images.idx3-ubyte');
    lblTrainLabelsAll = loadMNISTLabels('train-labels.idx1-ubyte');
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