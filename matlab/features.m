%{
    Defines N features to be used in neural network from 
    given ChannelxTimexSegment matrix 
%}

function feats = features(X,freq) 

    %number of segments
    segs = size(X,3);
    
    %features, CHANGE WHEN ADDING NEW FEATURES
    feats = zeros(segs,6);    
    
    %fft from time to frequency domain
    nfft = 2^nextpow2(size(X,2)); %optimal fft size
    freq_dom = fft(X,nfft,2); %perform fft on times
    freq_dom = freq_dom(:,1:nfft/2,:); %reduce size to half
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
        
        feats(i,1) = spectral_edge(freq_x, f, p);
        feats(i,2) = signal_power(freq_x, theta, f);
        feats(i,3) = signal_power(freq_x, delta, f);
        feats(i,4) = signal_power(freq_x, alpha, f);
        feats(i,5) = signal_power(freq_x, beta, f);
        feats(i,6) = signal_power(freq_x, gamma, f);
        %feats(i,7) = efd(x);
        
    end
    
end