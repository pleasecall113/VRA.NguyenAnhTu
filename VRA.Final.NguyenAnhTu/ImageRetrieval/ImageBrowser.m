function varargout = ImageBrowser(varargin)
%IMAGEBROWSER MATLAB code file for ImageBrowser.fig
%      IMAGEBROWSER, by itself, creates a new IMAGEBROWSER or raises the existing
%      singleton*.
%
%      H = IMAGEBROWSER returns the handle to a new IMAGEBROWSER or the handle to
%      the existing singleton*.
%
%      IMAGEBROWSER('Property','Value',...) creates a new IMAGEBROWSER using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to ImageBrowser_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      IMAGEBROWSER('CALLBACK') and IMAGEBROWSER('CALLBACK',hObject,...) call the
%      local function named CALLBACK in IMAGEBROWSER.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImageBrowser

% Last Modified by GUIDE v2.5 29-Dec-2017 23:58:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImageBrowser_OpeningFcn, ...
                   'gui_OutputFcn',  @ImageBrowser_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
   gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ImageBrowser is made visible.
function ImageBrowser_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)
%An cac axes
set(handles.axes1,'visible','off');
set(handles.axes2,'visible','off');
set(handles.axes3,'visible','off');
set(handles.queryImg,'visible','off');
set(handles.axes7,'visible','off');
set(handles.axes8,'visible','off');

% Choose default command line output for ImageBrowser
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ImageBrowser wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImageBrowser_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

   
% Xu ly nut load anh
function btnImgBrowser_Callback(hObject, eventdata, handles)
% hObject    handle to btnImgBrowser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename;
[filename pathname] = uigetfile({'*.jpg';'*.bmp';'*.png'},'File Selector');
image = strcat(pathname, filename);
axes(handles.queryImg);
imshow(image);

% Xu ly nut tim kiem
function btnSearch_Callback(hObject, eventdata, handles)
% hObject    handle to btnSearch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
    %% Khai bao bien
   global files;
   global ids;
   global img;
    addpath('AKM');
    run('vlfeat\toolbox\vl_setup.m');
    datasetDir = 'oxford\images\';
    num_words = 1000000;
    num_iterations = 5;
    num_trees = 8;
    dim = 128;
    if_weight = 'tfidf';    if_norm = 'l1';
    if_dist = 'l1';
    global filename;
    %% Load dac trung SIFT
        if ~exist('oxford\feat\5k\feature.bin', 'file')
        features = zeros(128, 2000000);
        nfeat = 0;
        files = dir(fullfile(datasetDir, '*.jpg'));
        nfiles = length(files);
        features_per_image = zeros(1,nfiles);
        for i=1:nfiles
            imgPath = strcat(datasetDir, files(i).name);
            I = im2single(rgb2gray(imread(imgPath)));
            I = imresize(I, 0.6);
            [frame, sift] = vl_covdet(I, 'method', 'Hessian', 'estimateAffineShape', true);
            if nfeat+size(sift,2) > size(features,2)
                features = [features zeros(128,1000000)];
            end
            features(:,nfeat+1:nfeat+size(sift,2)) = sift;
            nfeat = nfeat+size(sift,2);
            features_per_image(i) = size(sift, 2);
        end
        features = features(:,1:nfeat);
        fid = fopen('oxford\feat\5k\feature.bin', 'w');
        fwrite(fid, features, 'float');
        fclose(fid);
        save('oxford\feat\5k\feat_info.mat', 'features_per_image', 'files');
        end
        fprintf('Loading SIFT features:\n');
        file = dir('oxford\feat\5k\feature.bin');
        fid = fopen('oxford\feat\5k\feature.bin', 'r');
        fclose(fid);
        load('oxford\feat\5k\feat_info.mat');
    %% Chay AKM de xay dung tu dien
    num_images = length(files);
    dict_params =  {num_iterations, 'kdt', num_trees};
    % build the dictionary
    if exist('oxford\feat\5k\dict.mat', 'file')
        load('oxford\feat\5k\dict.mat');
    else        
        randIndex = randperm(size(features,2));
        dict_words = ccvBowGetDict(features(:,randIndex(1:100000)), [], [], num_words, 'flat', 'akmeans', ...
            [], dict_params);
        save('oxford\feat\5k\dict.mat', 'dict_words');
    end
    %% Tinh toan sparse frequency vector
    dict = ccvBowGetWordsInit(dict_words, 'flat', 'akmeans', [], dict_params);
    if exist('oxford\feat\5k\words.mat', 'file')
        load('oxford\feat\5k\words.mat');
    else
        words = cell(1, num_images);
        for i=1:num_images
            if i==1
                bIndex = 1;
            else
                bIndex = sum(features_per_image(1:i-1))+1;
            end
            eIndex = bIndex + features_per_image(i)-1;
            words{i} = ccvBowGetWords(dict_words, features(:, bIndex:eIndex), [], dict);
        end;
        save('oxford\feat\5k\words.mat', 'words');
    end

    %% Tao inverted file for the images
    inv_file = ccvInvFileInsert([], words, num_words);
    ccvInvFileCompStats(inv_file, if_weight, if_norm);
    %% Query images 
    k = str2num(strtok(filename,'.jpg'));
    
    q_files = dir(fullfile('oxford\groundtruth', '*query.txt'));
    ntop = 0;
    % load anh query
    fid = fopen(strcat('oxford\groundtruth\', q_files(k).name), 'r');
    str = fgetl(fid);
    [image_name, remain] = strtok(str, ' ');
    fclose(fid);
    numbers = str2num(remain);
    x1 = numbers(1);
    y1 = numbers(2);
    x2 = numbers(3);
    y2 = numbers(4);
    file = strcat('oxford\images\', image_name(6:end), '.jpg');  
    I = im2single(rgb2gray(imread(file)));
    % Tinh dac trung SIFT cho anh query
    [frame, sift] = vl_covdet(I, 'method', 'Hessian', 'estimateAffineShape', true);
    sift = sift(:,(frame(1,:)<=x2) &  (frame(1,:) >= x1) & (frame(2,:) <= y2) & (frame(2,:) >= y1));
 
    % Tinh Word-ID
    q_words = cell(1,1);
    q_words{1} = ccvBowGetWords(dict_words, double(sift), [], dict);
    [ids dists] = ccvInvFileSearch(inv_file, q_words(1), if_weight, if_norm, if_dist, ntop);
    fid = fopen('oxford\groundtruth\rank_list.txt', 'w');
    img = 1;
              axes(handles.axes1);
              imshow(imread(fullfile('oxford\images\', files(ids{1}(img)).name)));
              set(handles.txtImg1,'String',num2str(files(ids{1}(img)).name));
              axes(handles.axes2);
              imshow(imread(fullfile('oxford\images\', files(ids{1}(img+1)).name)));
              set(handles.txtImg2,'String',files(ids{1}(img+1)).name);
              axes(handles.axes3);
              imshow(imread(fullfile('oxford\images\', files(ids{1}(img+2)).name)));
              set(handles.txtImg3,'String',files(ids{1}(img+2)).name);
              axes(handles.axes7);
              imshow(imread(fullfile('oxford\images\', files(ids{1}(img+3)).name)));
              set(handles.txtImg4,'String',files(ids{1}(img+3)).name);
              axes(handles.axes8);
              imshow(imread(fullfile('oxford\images\', files(ids{1}(img+4)).name)));
              set(handles.txtImg5,'String',files(ids{1}(img+4)).name);
              if(size(ids{1},2)<=5)
                 set(handles.btnNext,'Enable','off') ;
              end
                 set(handles.btnBack,'Enable','off') ;
    for i=1:size(ids{1},2)
        fprintf(fid, '%s\n', files(ids{1}(i)).name(1:end-4));
    end
    fclose(fid);
    script = ['oxford\groundtruth\Test.exe oxford\groundtruth\', ...
        q_files(k).name(1:end-10), ...
        ' oxford\groundtruth\rank_list.txt',...
        ' >oxford\result\', image_name(6:end), '_result.txt']; 
    system(script);
    r_files = dir(fullfile('oxford\result\', '*.txt'));
    acc = [];
    for i=1:length(r_files)
        file = ['oxford\result\' r_files(i).name];
        fid = fopen(file, 'r');
        acc = [acc fscanf(fid, '%f')];
        fclose(fid);
    end  
    set(handles.txtAcc,'String',num2str(mean(acc)*100,'%g%%'));%Hien thi do chinh xac
% clear inv file
ccvInvFileClean(inv_file);


% Xu ly nut lui
function btnBack_Callback(hObject, eventdata, handles)
% hObject    handle to btnBack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   global files;
   global ids;
   global img;

set(handles.btnNext,'Enable','on') ;
img=img-5;
axes(handles.axes1);
imshow(imread(fullfile('oxford\images\', files(ids{1}(img)).name)));
set(handles.txtImg1,'String',files(ids{1}(img)).name); 

axes(handles.axes2);
imshow(imread(fullfile('oxford\images\', files(ids{1}(img+1)).name)));
set(handles.txtImg2,'String',files(ids{1}(img+1)).name);

axes(handles.axes3);
imshow(imread(fullfile('oxford\images\', files(ids{1}(img+2)).name)));
set(handles.txtImg3,'String',files(ids{1}(img+2)).name);

axes(handles.axes7);
imshow(imread(fullfile('oxford\images\', files(ids{1}(img+3)).name)));
set(handles.txtImg4,'String',files(ids{1}(img+3)).name);

axes(handles.axes8);
imshow(imread(fullfile('oxford\images\', files(ids{1}(img+4)).name)));
set(handles.txtImg5,'String',files(ids{1}(img+4)).name);
     
if(img==1)
    set(handles.btnBack,'Enable','off') ;
end


% Xu ly nut toi
function btnNext_Callback(hObject, eventdata, handles)
% hObject    handle to btnNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   global files;
   global ids;
   global img;

set(handles.btnBack,'Enable','on') ;
  
img=img+5;
axes(handles.axes1);
imshow(imread(fullfile('oxford\images\', files(ids{1}(img)).name)));
set(handles.txtImg1,'String',files(ids{1}(img)).name);
        
if(img+1<size(ids{1},2))
    axes(handles.axes2);
    imshow(imread(fullfile('oxford\images\', files(ids{1}(img+1)).name)));
    set(handles.txtImg2,'String',files(ids{1}(img+1)).name);
else
    cla(handles.axes2);
    set(handles.btnNext,'Enable','off') ;
end
        
if(img+2<size(ids{1},2))
    axes(handles.axes3);
    imshow(imread(fullfile('oxford\images\', files(ids{1}(img+2)).name)));
    set(handles.txtImg3,'String',files(ids{1}(img+2)).name);
else
    cla(handles.axes3);
    set(handles.btnNext,'Enable','off') ;
end

if(img+3<size(ids{1},2))
    axes(handles.axes7);
    imshow(imread(fullfile('oxford\images\', files(ids{1}(img+3)).name)));
    set(handles.txtImg4,'String',files(ids{1}(img+3)).name);
else
    cla(handles.axes7);
    set(handles.btnNext,'Enable','off') ;
end

if(img+4<size(ids{1},2))
    axes(handles.axes8);
    imshow(imread(fullfile('oxford\images\', files(ids{1}(img+4)).name)));
    set(handles.txtImg5,'String',files(ids{1}(img+5)).name);
else
    cla(handles.axes8);
    set(handles.btnNext,'Enable','off') ;
end