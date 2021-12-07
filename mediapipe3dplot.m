data=load('coords.csv');
%%

w=0.01;
poi=[11:20];
ti=[13,12,24,25,13];
ri=[12,14,16]+1;

li=[11,13,15]+1;
f1=figure(1);

%for frame=1;
for frame=1:2:300
clf(f1)
% plot3(data(frame,(poi*3-2)),data(frame,(poi*3-0)),-data(frame,(poi*3-1)),'o')
% hold on
plot3(data(frame,(ti*3-2)),data(frame,(ti*3-0)),-data(frame,(ti*3-1)),'bo-')
hold on
plot3(data(frame,(ri*3-2)),data(frame,(ri*3-0)),-data(frame,(ri*3-1)),'ro-')
hold on
plot3(data(frame,(li*3-2)),data(frame,(li*3-0)),-data(frame,(li*3-1)),'go-')
hold on
% view([sin(frame*w),cos(frame*w),1])
view([-0.1,-1,1])
xlim([-1,1])
ylim([-1,1])
zlim([-1,1])
drawnow
grid on
pause(1/30)
end