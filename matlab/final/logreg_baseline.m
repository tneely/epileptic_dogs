load('dog1');
B = mnrfit(feats1_1w_0o, Y1.'+1);

examples = size(feats1_1w_0o,1);
predY = mnrval(B, feats1_1w_0o);
predY = predY(:,1);
Y = Y1 - round(predY.');

tester = [1:(examples-sum(Y1)), (examples-sum(Y1)+1):examples];

testPre = sum(Y(1,tester));
testInt = length(tester) - testPre;
diff = Y(1,tester) - predY.';
dist = histc(diff, -1:1); %-1 if false positive, 1 if miss
sensitivity = (testPre - dist(3))/testPre;
fpr = dist(1)/testInt;