function BaiTap24()
    imgI = imread('cameraman.jpg');
    arrPointI = detectHarrisFeatures(imgI);
    imgJ = imread('cameraman30.jpg');
    arrPointJ = detectHarrisFeatures(imgJ);
    [arrfeatureI, arrValidPointI] = extractFeatures(imgI,arrPointI);
    [arrfeatureJ, arrValidPointJ] = extractFeatures(imgJ,arrPointJ);
    arrIndexPair = matchFeatures(arrfeatureI,arrfeatureJ);
    arrMatchedPointI = arrValidPointI(arrIndexPair(:,1),:);
    arrMatchedPointJ = arrValidPointJ(arrIndexPair(:,2),:);
    figure;
    ax = axes;
    showMatchedFeatures(imgI,imgJ,arrMatchedPointI,arrMatchedPointJ,'montage','Parent',ax);
    title(ax,'Candidate point matches');
    legend(ax,'Matched point I', 'Matched point J');
    figure;
    ax = axes;
    [tform,inliermatchedPointJ,inliermatchedPointsI] = estimateGeometricTransform(arrMatchedPointJ,arrMatchedPointI,'similarity');
    showMatchedFeatures(imgI,imgJ,inliermatchedPointsI,inliermatchedPointJ,'montage','Parent',ax);
    title('Matched inlier points');
  end

