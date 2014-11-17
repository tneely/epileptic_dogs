%Create network
net = FeedForwardNetwork();
net.learning_rate = 10;
net.addInputLayer(2,2);
net.addHiddenLayer(2,2);
net.addOutputLayer(2,1,0,0);
net.input_layer.downstream.Weights
%test input xor table
x1 = [1,1];
x2 = [1,0];
x3 = [0,1];
x4 = [0,0];
t1 = 1;
t2 = 0;
t3 = 0;
t4 = 0;

X = [x1;x2;x3;x4];
T = [t1;t2;t3;t4];

ll = net.predict(x1)
lo = net.predict(x2)
ol = net.predict(x3)
oo = net.predict(x4)

trials = 1000;
W11 = zeros(trials);
W12 = zeros(trials);
e = zeros(trials);
%train
for trial = 1:trials
    error = 0;
    i = randi(4);
    error = error + backpropagation(net, X(i,:), T(i));
    i = randi(4);
    error = error + backpropagation(net, X(i,:), T(i));
    i = randi(4);
    error = error + backpropagation(net, X(i,:), T(i));
    i = randi(4);
    error = error + backpropagation(net, X(i,:), T(i));
    e(trial) = error / 4;
end

ll = net.predict(x1)
lo = net.predict(x2)
ol = net.predict(x3)
oo = net.predict(x4)

figure;
subplot(1,1,1);
plot(1:trials, e);
title('Gradient Descent');
ylabel('Least Squared Error');
xlabel('Trial');