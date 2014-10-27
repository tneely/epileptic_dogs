%Create network
net = FeedForwardNetwork();
net.learning_rate = .2;
net.addInputLayer(2,2);
net.addHiddenLayer(2,2);
net.addOutputLayer(2,1,1,1);

%test input
t1 = [1,1];
t2 = [1,0];
t3 = [0,1];
t4 = [0,0];

net.predict(t1)
net.predict(t2)
net.predict(t3)
net.predict(t4)

%train
backpropagation(net, t1, 0)