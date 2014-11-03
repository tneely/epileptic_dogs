%Create network
net = FeedForwardNetwork();
net.learning_rate = 1;
net.addInputLayer(3,3);
net.addHiddenLayer(3,3);
net.addHiddenLayer(3,3);
net.addHiddenLayer(3,3);
net.addOutputLayer(3,1,0,0);

%test input xor table
x1 = [1,1,1];
x2 = [1,1,0];
x3 = [1,0,1];
x4 = [0,1,1];
x5 = [1,0,0];
x6 = [0,1,0];
x7 = [0,0,1];
x8 = [0,0,0];
t1 = 0;
t2 = 1;
t3 = 1;
t4 = 1;
t5 = 1;
t6 = 1;
t7 = 1;
t8 = 0;

X = [x1;x2;x3;x4;x5;x6;x7;x8];
T = [t1;t2;t3;t4;t5;t6;t7;t8];

lll = net.predict(x1)
llo = net.predict(x2)
lol = net.predict(x3)
oll = net.predict(x4)
loo = net.predict(x5)
olo = net.predict(x6)
ool = net.predict(x7)
ooo = net.predict(x8)

trials = 25;
W11 = zeros(trials);
W12 = zeros(trials);
e = zeros(trials);
%train
for trial = 1:trials
    error = 0;
    error = error + backpropagation(net, X(1,:), T(1));
    error = error + backpropagation(net, X(2,:), T(2));
    error = error + backpropagation(net, X(3,:), T(3));
    error = error + backpropagation(net, X(4,:), T(4));
    error = error + backpropagation(net, X(5,:), T(5));
    error = error + backpropagation(net, X(6,:), T(6));
    error = error + backpropagation(net, X(7,:), T(7));
    error = error + backpropagation(net, X(8,:), T(8));
    
    W11(trial) = net.output_layer.Weights(1);
    W12(trial) = net.output_layer.Weights(2);
    e(trial) = error / 8;
end

lll = net.predict(x1)
llo = net.predict(x2)
lol = net.predict(x3)
oll = net.predict(x4)
loo = net.predict(x5)
olo = net.predict(x6)
ool = net.predict(x7)
ooo = net.predict(x8)

figure;
subplot(2,1,1);
plot(1:trials, e);
title('Gradient Descent');
ylabel('least squared error');
xlabel('trial');

subplot(2,1,2);
plot3(W11, W12, e);
grid on
title('Error per weight');