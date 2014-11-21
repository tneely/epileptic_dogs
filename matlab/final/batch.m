%batch runs
error1_normal = eeg_train(feats1_1w_0o, Y1, 5000, 0.3, 0.85, 0.05);
error1_no_m_d = eeg_train(feats1_1w_0o, Y1, 5000, 0.3, 0, 0);