%Create network
net = FeedForwardNetwork();
net.learning_rate = .2;
net.addInputLayer(2,2);
net.addHiddenLayer(2,2);
net.addOutputLayer(2,1,0,1);

%test input xor table
x1 = [1,1];
x2 = [1,0];
x3 = [0,1];
x4 = [0,0];
t1 = 0;
t2 = 0;
t3 = 0;
t4 = 0;

X = [x1;x2;x3;x4];
T = [t1;t2;t3;t4];

ll = net.predict(x1)
lo = net.predict(x2)
ol = net.predict(x3)
oo = net.predict(x4)

trials = 150;
W11 = zeros(trials);
W12 = zeros(trials);
e = zeros(trials);
%train
for trial = 1:trials
    i = randi([1,4]);
    e(trial) = backpropagation(net, X(i,:), T(i));
    W11(trial) = net.output_layer.Weights(1);
    W12(trial) = net.output_layer.Weights(2);
end

plot(e);
axis([1, trials, 0, 1]);

%figure;
%subplot(2,1,1);
%plot(1:trials, e);
%title('Gradient Descent');
%ylabel('least squared error');
%xlabel('trial');

%subplot(2,1,2);
%plot3(W11, W12, e);
%grid on
%title('Error per weight');