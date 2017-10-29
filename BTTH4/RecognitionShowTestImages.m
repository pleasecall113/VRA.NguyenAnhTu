function RecognitionShowTestImages(n)
%Q6 - Nhap n, hien thi anh va ket qua nhan dang
    imgTestAll = importdata('imgTestImagesAll.mat');
    lblTestAll = importdata('lblTestLabelsAll.mat');
    imgTrainImagesAll = importdata('imgTrainImagesAll.mat');
    lblTrainLabelsAll = importdata('lblTrainLabelsAll.mat');
    Mdl = fitcknn(imgTrainImagesAll',lblTrainLabelsAll);
    imgTest = imgTestAll(:,n);
    lblPredictTest = predict(Mdl,imgTest');
    lblImageTest = lblTestAll(n);
    figure;
    img2D = reshape(imgTest,112,92);
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