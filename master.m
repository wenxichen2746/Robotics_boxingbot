clear
clc
close all
boxrobot=createrobot();
show(boxrobot)
q0 = homeConfiguration(boxrobot);
qAccel = forwardDynamics(boxrobot);

load('qsdata.mat')
% qs=qsTrack(20,:);%random
% qs=[0, 0,0,0, -pi/4, 0,0,0, 0]
% show(boxrobot,qs)
% for i=130:200
%    qs=qsTrack(i,:);
%    show(boxrobot,qsTrack(i,:))
%    view([0,1,0.5])
%    view()
%    drawnow
%    waitfor(0.01)
% end
% toc

%%
dt=1/24/4;
framegap=dt*5;
damping=0.999;
% simulationtime=5;
simulationtime=dt*400*4;

plotqs=zeros(9,round(simulationtime/framegap));
plotqs_Target=zeros(9,round(simulationtime/framegap));
plotTorq=zeros(9,round(simulationtime/framegap));
tic
qVel=zeros(1,length(q0));
qs=q0;
i=1;
frame=1;
for t=0:dt:simulationtime
%     qTarget=pi/2*sin(t)*[0,1,1,1,1,1,1,1,1];
%     qTarVel=pi/2*cos(t)*[0,1,1,1,1,1,1,1,1];  
    qTarget=qsTrack_extend(frame,:);
    qTarVel=qsTrackVel_extend(frame,:);
    frame=frame+1;
%     jointTorq=zeros(1,9);
%     jointTorq(1)=10*sin(t);
    jointTorq=boxrobotjointPD(qTarget,qTarVel,qs,qVel);
    qAccel = forwardDynamics(boxrobot,qs,qVel,jointTorq,[]);
    qVel=qVel*damping+qAccel*dt;
    qs=qs+qVel*dt;
    if rem(t,framegap)==0||t==0
        plotqs(:,i)=qs;
        plotqs_Target(:,i)=qTarget;
        plotTorq(:,i)=jointTorq;
        i=i+1;
    end
end
toc
disp({'Simulation finished'})
%%
tic
fig=figure(position=[50,50,1500,800]);
t=0:framegap:simulationtime;

movieframe=1;
for i=1:length(plotqs)
% for i=20
   subplot(2,2,1)
   show(boxrobot,plotqs(:,i)')
   view([0.8,0.8,0.5])
   title('Controller output configuration')
   subplot(2,2,3)
   show(boxrobot,plotqs_Target(:,i)')
   view([0.8,0.8,0.5])
   title('Traget configuration')
   
   subplot(222)
   colorstring1 = ["k-","b-","g-","m-","r-","b-","g-","m-","r-"];
   colorstring2 = ["k--","b--","g--","m--","r--","b--","g--","m--","r--"];
   for qindex=1:9
       p1=plot(t(1:i),plotqs(qindex,1:i)',colorstring1(qindex));
       hold on 
       p2=plot(t(1:i),plotqs_Target(qindex,1:i)',colorstring2(qindex));
       hold on
   end

   legend({'Controller output','Target angel'},'Location','northwest')


%    legend(lins2,'Target angel')
   xlim([t(i)-2,t(i)-0.2])
   title('Joint Angle')
   
   subplot(224)
   plot(t(1:i),plotTorq(:,1:i),'--')
   hold on 
   xlim([t(i)-2,t(i)-0.2])
   title('Torque on each joint')
   
   drawnow
   waitfor(framegap)
    movierecord(movieframe)= getframe(fig);
    movieframe=movieframe+1;
end
toc


figure(position=[50,50,1500,800])
axis off
movie(movierecord,1,30)
% mplay(movierecord)

v = VideoWriter('BoxRobotPlot.avi','Motion JPEG AVI');
v.FrameRate = 30/2;
open(v)
writeVideo(v,movierecord)
close(v)
