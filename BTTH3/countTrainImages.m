function countTrainImages()
    lblTrainAll = loadMNISTLabels('./train-labels.idx1-ubyte');
    rArray = [];
    imgNumber = 0;
    nNumLabel = size(lblTrainAll, 1);
    while(imgNumber<=9)
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