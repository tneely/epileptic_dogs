%[error_1w_pt3a_0m_0d, net_1w_pt3a_0m_0d] = eeg_train(feats5_1w_0o, Y5, 1000, .3, 0, 0);

%[error_1w_pt3a_pt1m_0d, net_1w_pt3a_pt1m_0d] = eeg_train(feats5_1w_0o, Y5, 1000, .3, .1, 0);
%[error_1w_pt3a_pt5m_0d, net_1w_pt3a_pt5m_0d] = eeg_train(feats5_1w_0o, Y5, 1000, .3, .5, 0);
%[error_1w_pt3a_pt8m_0d, net_1w_pt3a_pt8m_0d] = eeg_train(feats5_1w_0o, Y5, 1000, .3, .8, 0);
%[error_1w_pt3a_pt9m_0d, net_1w_pt3a_pt9m_0d] = eeg_train(feats5_1w_0o, Y5, 1000, .3, .9, 0);

[error_1w_pt3a_0m_pt03d, net_1w_pt3a_0m_pt03d] = eeg_train(feats5_1w_0o, Y5, 1000, .3, 0, .03);
[error_1w_pt3a_0m_pt05d, net_1w_pt3a_0m_pt05d] = eeg_train(feats5_1w_0o, Y5, 1000, .3, 0, .05);
[error_1w_pt3a_0m_pt1d, net_1w_pt3a_0m_pt1d] = eeg_train(feats5_1w_0o, Y5, 1000, .3, 0, .1);