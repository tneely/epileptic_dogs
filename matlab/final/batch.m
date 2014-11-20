%batch runs
[sens1,fpr1] = cross_val(feats2_1w_0o, Y2, 10, 1000);
[sens2,fpr2] = cross_val(feats2_1w_0o, Y2, 10, 1000);
[sens3,fpr3] = cross_val(feats3_1w_0o, Y3, 10, 1000);
[sens4,fpr4] = cross_val(feats4_1w_0o, Y4, 10, 1000);
[sens5,fpr5] = cross_val(feats5_1w_0o, Y5, 10, 1000);