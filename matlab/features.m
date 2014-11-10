%{
    Defines N features to be used in neural network from 
    given ChannelxTimexSegment matrix 
%}

function feats = features(X,freq) 

    %number of segments, datapoints, channels
    segs = size(X,3);
    dpts = size(X,2);
    chnls = size(X,1);
    
    %features, CHANGE WHEN ADDING NEW FEATURES
    feats = zeros(segs,6*chnls);    
    
    %fft from time to frequency domain
    nfft = 2^nextpow2(size(X,2)); %optimal fft size
    freq_dom = fft(X,nfft,2); %perform fft on times
    freq_dom = freq_dom./dpts; %normalize by number of datapoints
    freq_dom = freq_dom(:,1:nfft/2,:); %reduce size to half (removes repeats)
    freq_pow = abs(freq_dom).^2; %create power spectrum
    f = (1:nfft/2)*freq/nfft; %match index to corresponding frequency
    
    %wave bands in Hz
    theta = [0 4];
    delta = [4 8];
    alpha = [8 16];
    beta = [16 32];
    gamma = [32 101];
    
    %spectral edge percentage
    p = 0.9;
    
    for i = 1:segs
        
        x = X(:,:,i);
        freq_x = freq_pow(:,:,i);
        
        feats(i,0*chnls+1:1*chnls) = spectral_edge(freq_x, f, p);
        feats(i,1*chnls+1:2*chnls) = signal_power(freq_x, theta, f);
        feats(i,2*chnls+1:3*chnls) = signal_power(freq_x, delta, f);
        feats(i,3*chnls+1:4*chnls) = signal_power(freq_x, alpha, f);
        feats(i,4*chnls+1:5*chnls) = signal_power(freq_x, beta, f);
        feats(i,5*chnls+1:6*chnls) = signal_power(freq_x, gamma, f);
        %feats(i,7*chnls+1) = gmsc(x);
        
    end
    
end
