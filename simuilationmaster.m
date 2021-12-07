clear
clc
boxrobot=createrobot();
show(boxrobot)
q0 = homeConfiguration(boxrobot);
qAccel = forwardDynamics(boxrobot);
qs=ones(1,length(q0))*pi/2;%random
qVel=zeros(1,length(q0));
show(boxrobot,qs)


%%
dt=0.01;
framegap=0.1;
simulationtime=20;
qs=qs;
plotqs=cell(1,round(simulationtime/framegap));
tic
i=1;

qTarget=pi/2*sin(t);
qTarVel
for t=0:dt:simulationtime
    jointTorq=ones(1,9);
    qAccel = forwardDynamics(boxrobot,qs,qVel,jointTorq,[]);
    qVel=qVel+qAccel*dt;
    qs=qs+qVel*dt;
    if rem(t,framegap)==0||t==0
        plotqs{i}=qs;
        i=i+1;
    end
end
toc
disp({'Simulation finished'})
%%
tic
figure()
for i=1:length(plotqs)
   show(boxrobot,plotqs{i})
   drawnow
   waitfor(framegap)
end
toc
