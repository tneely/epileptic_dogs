function [] = plotEEG( sig, frequancy, seconds )
% generate random data - 32 channels
t = linspace(0,600,size(sig,2));

% calculate shift
mi = min(sig,[],2);
ma = max(sig,[],2);
shift = cumsum([0; abs(ma(1:end-1))+abs(mi(2:end))]);
shift = repmat(shift,1,size(sig,2));
size(shift)
%plot 'eeg' data
plot(t,sig+shift)

% edit axes
set(gca,'ytick',mean(sig+shift,2),'yticklabel',1:32)
grid on
ylim([mi(1) max(max(shift+sig))])


end

