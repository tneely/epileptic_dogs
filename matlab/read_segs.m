%{
    Reads in all segments from EEG set and creates list of all segments
    with identification information.
%}

function [segX, segY, freq] = read_segs() 
    
    [fileName,pathName] = uigetfile('*.mat','Select the MATLAB code file','multiselect','on');
    
    segX = zeros(size(fileName));
    segY = zeros(size(fileName));
    
    for i = 1:length(fileName)
        
        fullName = fullfile(pathName,fileName{i});
        
        seg = load(fullName);
        segName = fieldnames(seg);
        seg = getfield(seg, segName{1});
        data = seg.data;
        
        if i == 1 %create first to specify matrix dimensions, get freq
            segX = zeros(size(data));
            freq = seg.sampling_frequency;
        end
        
        segX(:,:,i) = data;
        
        if isempty(strfind(fileName{i}, 'interictal')) %then is preictal
            segY(i) = 1;
        end
                
    end
    
end
