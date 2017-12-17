Y=xlsread('apr5speed.xlsx');
t=Y';
Y1=xlsread('apr5direction.xlsx');
t1=Y1';
X=con2seq(t1);
T=con2seq(t);
N = 144; 
inputseries  = X(1:end-N);
targetseries = T(1:end-N);
inputseriesvalidation  = X(end-N+1:end);
targetseriesvalidation = T(end-N+1:end); 
delay =200;
hiddenlayer =20;
net = narxnet(1:delay,1:delay,hiddenlayer);
[Xs,Xi,Ai,Ts] = preparets(net,inputseries,{},targetseries); 
net = train(net,Xs,Ts,Xi,Ai);
Y = net(Xs,Xi,Ai); 
perf = perform(net,Ts,Y);
inputseriesprediction = [inputSeries(end-delay+1:end),inputseriesvalidation];
targetseriesprediction = [targetseries(end-delay+1:end), con2seq(nan(1,N))];
netc = closeloop(net);
[Xs,Xi,Ai,Ts] = preparets(netc,inputseriesprediction,{},targetseriesprediction);
prediction = netc(Xs,Xi,Ai);
perf = perform(net,prediction,targetseriesvalidation);
figure;
plot([cell2mat(prediction);    cell2mat(targetseriesvalidation)]')
legend('Network Predictions','Expected Outputs')
