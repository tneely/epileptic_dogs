[sensitivity_1pt0, fpr_1pt0] = cross_val_hidden_nodes(feats1_1w_0o, Y1, 10, 200, 1);

[sensitivity_0pt75, fpr_0pt75] = cross_val_hidden_nodes(feats1_1w_0o, Y1, 10, 200, .75);

[sensitivity_0pt5, fpr_0pt5] = cross_val_hidden_nodes(feats1_1w_0o, Y1, 10, 200, .5);

[sensitivity_0pt3, fpr_0pt3] = cross_val_hidden_nodes(feats1_1w_0o, Y1, 10, 200, .3);

[sensitivity_0pt25, fpr_0pt25] = cross_val_hidden_nodes(feats1_1w_0o, Y1, 10, 200, .25);
