function countTrainImages()
%Q3- Thong ke so luong anh tuong ung voi cac label trong tap Train
    lblTrainAll = importdata('lblTrainLabelsAll.mat');
    rArray = [];
    imgNumber = 1;
    nNumLabel = size(lblTrainAll, 2);
    while(imgNumber<=40)
        countImgs = 0;
        for i = 1: nNumLabel
        if(lblTrainAll(i) == imgNumber)
            countImgs = countImgs + 1;
        end
        end
        rArray = [rArray,[imgNumber,countImgs]'];
        imgNumber = imgNumber+1;
    end
    csvwrite('Question3.csv',rArray);
end