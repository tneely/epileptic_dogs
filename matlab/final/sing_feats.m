%{
    Defines N features to be used in neural network from 
    given ChannelxTime matrix. Output is 1Xfeatues.

    X : channelxtime data matrix
    freq : recording frequency in Hz
    norm : bool indicating desire for normalized features
    spec_edge : bool indicating desire for feature
    sig_pow : bool indicating desire for feature
    avg_pow : bool indicating desire for feature
%}

function feats = sing_feats(X,freq,norm,spec_edge,sig_pow,avg_pow) 

    %number of datapoints, channels
    [chnls, dpts] = size(X);
    
    %features init
    feats = [];
    
    %fft from time to frequency domain
    %fprintf('Generating power spectrum... ')
    nfft = 2^nextpow2(size(X,2)); %optimal fft size
    freq_dom = fft(X,nfft,2); %perform fft on times
    freq_dom = freq_dom./dpts; %normalize by number of datapoints
    freq_dom = freq_dom(:,1:nfft/2); %reduce size to half (removes repeats)
    freq_pow = abs(freq_dom).^2; %create power spectrum
    f = (1:nfft/2)*freq/nfft; %match index to corresponding frequency
    %fprintf('done! \n')
    
    %wave bands in Hz
    theta = [0 4];
    delta = [4 8];
    alpha = [8 16];
    beta = [16 32];
    gamma = [32 101];
    
    %spectral edge percentage
    p = 0.9;
        
    %fprintf('Generating features... \n')

    if spec_edge
    %    fprintf('Starting spectral edge... ')
        spe = spectral_edge(freq_pow, f, p);
        
        if norm
                spe = (spe-min(spe))/(max(spe)-min(spe));
        end
        
        feats = [feats, spe];
    %    fprintf('done! \n')
    end

    if sig_pow
    %    fprintf('Starting signal power... ')
        spw = [];
        
        spw = [spw, signal_power(freq_pow, theta, f)];

        spw = [spw, signal_power(freq_pow, delta, f)];

        spw = [spw, signal_power(freq_pow, alpha, f)];

        spw = [spw, signal_power(freq_pow, beta, f)];

        spw = [spw, signal_power(freq_pow, gamma, f)];
    
        if norm
                spw = (spw-min(spw))/(max(spw)-min(spw));
        end
        
        feats = [feats, spw];
    %    fprintf('done! \n')
    end

    if avg_pow
    %    fprintf('Starting average power... ')
        apw = [];
        
        apw = [apw, average_power(freq_pow, theta, f)];

        apw = [apw, average_power(freq_pow, delta, f)];

        apw = [apw, average_power(freq_pow, alpha, f)];

        apw = [apw, average_power(freq_pow, beta, f)];

        apw = [apw, average_power(freq_pow, gamma, f)];
    
        if norm
                apw = (apw-min(apw))/(max(apw)-min(apw));
        end
        
        feats = [feats, apw];
    %    fprintf('done! \n')
    end
        
    %fprintf('\n')
end
