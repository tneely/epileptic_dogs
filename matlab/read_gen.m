%{
    Reads in all segments from EEG set and generates a feature list of 
    all segments.

    INPUT
    windows: scalar, desired amount of windows over time series
    overlap: scalar, fraction of overlap between windows
    spec_edge: binary scalar, turns feature on or off
    sig_pow: binary scalar, turns feature on or off
    avg_pow: binary scalar, turns feature on or off

    OUTPUT
    featsX: contains segment feature information (featuresXsegments)
    segY: identifies preictal (1) and interictal (0) segments (1Xsegments)

%}

function [featsX, segY] = read_gen(windows,overlap,spec_edge,sig_pow,avg_pow) 

    [fileName,pathName] = uigetfile('*.mat','Select the MATLAB code file','multiselect','on');
    
    tic
    
    featsX = [];
    segY = zeros(size(fileName));
    N = length(fileName);
    
    for i = 1:N
        
        fprintf('Reading in segment %d of %d... ',i,N)
        
        fullName = fullfile(pathName,fileName{i});
        
        seg = load(fullName);
        segName = fieldnames(seg);
        seg = getfield(seg, segName{1});
        data = seg.data;
        
        if i == 1 %create first to get freq
            freq = seg.sampling_frequency;
        end
        
        featsX = [featsX; sing_feat_win(data,freq,windows,overlap,spec_edge,sig_pow,avg_pow)];
        
        if isempty(strfind(fileName{i}, 'interictal')) %then is preictal
            segY(i) = 1;
        end
             
        fprintf('done! \n')
        
    end
    
    fprintf('\n')
    toc
    
end
