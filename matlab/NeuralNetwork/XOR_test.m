%Create network
net = FeedForwardNetwork();
net.addInputLayer(2,2);
net.addHiddenLayer(2,2);
net.addOutputLayer(2,2,1,1);

%test input
t1 = [1,1];
t2 = [1,0];
t3 = [0,1];
t4 = [0,0];

net.predict(t1)