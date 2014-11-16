%Create network
net = FeedForwardNetwork();
net.learning_rate = .5;
net.addInputLayer(2,2);
net.addHiddenLayer(2,2);
net.addOutputLayer(2,1,1,0);

%test input xor table
x1 = [1,1];
x2 = [1,0];
x3 = [0,1];
x4 = [0,0];
t1 = 0;
t2 = 1;
t3 = 1;
t4 = 0;

X = [x1;x2;x3;x4];
T = [t1;t2;t3;t4];

ll = net.predict(x1)
lo = net.predict(x2)
ol = net.predict(x3)
oo = net.predict(x4)

trials = 100;
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
    
    W11(trial) = net.output_layer.Weights(1);
    W12(trial) = net.output_layer.Weights(2);
    e(trial) = error / 8;
end

ll = net.predict(x1)
lo = net.predict(x2)
ol = net.predict(x3)
oo = net.predict(x4)

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