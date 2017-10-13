function RecognitionShowTestImages(n)
%Q6 - Nhap n, hien thi anh va ket qua nhan dang
    imgTrainImagesAll = loadMNISTImages('train-images.idx3-ubyte');
    lblTrainLabelsAll = loadMNISTLabels('train-labels.idx1-ubyte');
    imgTestAll = loadMNISTImages('./t10k-images.idx3-ubyte');
    lblTestAll = loadMNISTLabels('./t10k-labels.idx1-ubyte');
    Mdl = fitcknn(imgTrainImagesAll',lblTrainLabelsAll);
    imgTest = imgTestAll(:,n);
    lblPredictTest = predict(Mdl,imgTest');
    lblImageTest = lblTestAll(n);
    figure;
    img2D = reshape(imgTest,28,28);
    imshow(img2D);
    strLabelImage = 'Ban dau: ';
    strLabelImage = [strLabelImage,num2str(lblTestAll(n)),'.'];
    strLabelImage = [strLabelImage,'Du doan: '];
    strLabelImage = [strLabelImage,num2str(lblPredictTest),'.'];
    if(lblPredictTest == lblImageTest)
        strLabelImage = [strLabelImage,' Ket qua dung.'];
    else
        strLabelImage = [strLabelImage,' Ket qua sai.'];
    end
    title(strLabelImage);
end