%{
    Defines N features to be used in neural network from 
    given ChannelxTimexSegment matrix. Output is segsXfeatues.

    X : channelxtimexsegment data matrix
    freq : recording frequency in Hz
    spec_edge : bool indicating desire for feature
    sig_pow : bool indicating desire for feature
%}

function feats = features(X,freq,spec_edge,sig_pow,avg_pow) 

    %number of segments, datapoints, channels
    segs = size(X,3);
    dpts = size(X,2);
    chnls = size(X,1);
    
    %features init
    feats = [];
    
    %fft from time to frequency domain
    fprintf('Generating power spectrum... ')
    nfft = 2^nextpow2(size(X,2)); %optimal fft size
    freq_dom = fft(X,nfft,2); %perform fft on times
    freq_dom = freq_dom./dpts; %normalize by number of datapoints
    freq_dom = freq_dom(:,1:nfft/2,:); %reduce size to half (removes repeats)
    freq_pow = abs(freq_dom).^2; %create power spectrum
    f = (1:nfft/2)*freq/nfft; %match index to corresponding frequency
    fprintf('done! \n')
    
    %wave bands in Hz
    theta = [0 4];
    delta = [4 8];
    alpha = [8 16];
    beta = [16 32];
    gamma = [32 101];
    
    %spectral edge percentage
    p = 0.9;
    
    for i = 1:segs
        
        fprintf('Generating features for segment %d... \n',i)
        
        seg_feats = [];
        x = X(:,:,i);
        freq_x = freq_pow(:,:,i);
        
        if spec_edge
            fprintf('Starting spectral edge... ')
            seg_feats = [seg_feats, spectral_edge(freq_x, f, p)];
            fprintf('done! \n')
        end
        
        if sig_pow
            fprintf('Starting signal power... ')
            seg_feats = [seg_feats, signal_power(freq_x, theta, f)];
            
            seg_feats = [seg_feats, signal_power(freq_x, delta, f)];
           
            seg_feats = [seg_feats, signal_power(freq_x, alpha, f)];
            
            seg_feats = [seg_feats, signal_power(freq_x, beta, f)];
            
            seg_feats = [seg_feats, signal_power(freq_x, gamma, f)];
            fprintf('done! \n')
        end
        
        if avg_pow
            fprintf('Starting average power... ')
            seg_feats = [seg_feats, average_power(freq_x, theta, f)];
            
            seg_feats = [seg_feats, average_power(freq_x, delta, f)];
           
            seg_feats = [seg_feats, average_power(freq_x, alpha, f)];
            
            seg_feats = [seg_feats, average_power(freq_x, beta, f)];
            
            seg_feats = [seg_feats, average_power(freq_x, gamma, f)];
            fprintf('done! \n')
        end
        
        %feats(i,7*chnls+1) = gmsc(x);
        
        feats = [feats ; seg_feats];
        
    end
    fprintf('\n')
end
