function countTestImages()
%Q4- Thong ke so luong anh tuong ung voi cac label trong tap Test
    lblTestAll = importdata('lblTestLabelsAll.mat');
    rArray = [];
    imgNumber = 1;
    nNumLabel = size(lblTestAll, 2);
    while(imgNumber<=40)
        countImgs = 0;
        for i = 1: nNumLabel
        if(lblTestAll(i) == imgNumber)
            countImgs = countImgs + 1;
        end
        end
        rArray = [rArray,[imgNumber,countImgs]'];
        imgNumber = imgNumber+1;
    end
    csvwrite('Question4.csv',rArray);
end