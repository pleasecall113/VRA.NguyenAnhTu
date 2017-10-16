function countTestImages()
%Q4- Thong ke so luong anh co thu tu n và label tuong ung tap Test
    lblTestAll = loadMNISTLabels('./t10k-labels.idx1-ubyte');
    rArray = [];
    imgNumber = 0;
    nNumLabel = size(lblTestAll, 1);
    while(imgNumber<=9)
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