%Proof that the network words
%Create network
net = FeedForwardNetwork();
net.learning_rate = .3;
net.momentum = .85;
net.addInputLayer(2,2);
net.addHiddenLayer(2,2);
net.addOutputLayer(2,1,0,0);
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

trials = 5000;
W11 = zeros(trials);
W12 = zeros(trials);
e = zeros(trials);
%train

for trial = 1:trials
    error = 0;
    i = 4;
    error = error + backpropagation(net, X(i,:), T(i));
    i = 3;
    error = error + backpropagation(net, X(i,:), T(i));
    i = 2;
    error = error + backpropagation(net, X(i,:), T(i));
    i = 1;
    error = error + backpropagation(net, X(i,:), T(i));
    e(trial) = error / 4;
    
    W11(trial) = sum(sum(net.output_layer.Weights)) + sum(sum(net.output_layer.upstream.Weights));
    W12(trial) = sum(sum(net.output_layer.bias)) + sum(sum(net.output_layer.upstream.bias));
end

figure;
subplot(2,1,1);
plot(1:trials, e);
title('Gradient Descent');
ylabel('Least Squared Error');
xlabel('Trial');

% subplot(2,1,2);
% plot3(W11, W12, e);
% grid on
% title('Gradient Descent');
% ylabel('least squared error');
% xlabel('trial');

