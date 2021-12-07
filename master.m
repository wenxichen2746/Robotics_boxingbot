clear
clc
close all
boxrobot=createrobot();
show(boxrobot)
q0 = homeConfiguration(boxrobot);
qAccel = forwardDynamics(boxrobot);

load('qsdata.mat')
qs=qsTrack(20,:);%random
% qs=[0, 0,0,0, -pi/4, 0,0,0, 0]
show(boxrobot,qs)
%%
dt=1/24;
framegap=dt*5;
damping=0.999;
% simulationtime=5;
simulationtime=dt*400;

plotqs=zeros(9,round(simulationtime/framegap));
plotTorq=zeros(9,round(simulationtime/framegap));
tic
qVel=zeros(1,length(q0));
qs=q0;
i=1;
frame=1;
for t=0:dt:simulationtime
%     qTarget=pi/2*sin(t)*[0,1,1,1,1,1,1,1,1];
%     qTarVel=pi/2*cos(t)*[0,1,1,1,1,1,1,1,1];  
    qTarget=qsTrack(frame,:);
    qTarVel=qsTrackVel(frame,:);
    frame=frame+1;
%     jointTorq=zeros(1,9);
%     jointTorq(1)=10*sin(t);
    jointTorq=boxrobotjointPD(qTarget,qTarVel,qs,qVel);
    qAccel = forwardDynamics(boxrobot,qs,qVel,jointTorq,[]);
    qVel=qVel*damping+qAccel*dt;
    qs=qs+qVel*dt;
    if rem(t,framegap)==0||t==0
        plotqs(:,i)=qs;
        plotTorq(:,i)=jointTorq;
        i=i+1;
    end
end
toc
disp({'Simulation finished'})
%%
tic
figure(position=[50,50,1500,800])
t=0:framegap:simulationtime;
qTarget=[0,1,1,1,1,1,1,1,1]'*pi/2*sin(t);
for i=1:length(plotqs)/2
   subplot(2,2,1)
   
   show(boxrobot,plotqs(:,i)')
   
   subplot(222)
   plot(t(1:i),plotqs(:,1:i)','b-')
   hold on 
   plot(t(1:i),qTarget(:,1:i)','b--')
   hold on
   subplot(223)
   plot(t(1:i),plotTorq(:,1:i),'r-')
   hold on 
   xlim([t(i)-2,t(i)-0.2])
   drawnow
   waitfor(framegap)
end
toc

