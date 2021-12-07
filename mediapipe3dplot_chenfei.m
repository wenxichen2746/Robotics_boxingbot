clc
clear
data=load('coords_1.csv');
data2=load('coords_2.csv');
close all
%%
w=0.01;
% poi=[12,13,15,17,24,25];
ti=[13,12,24,25,13];
ri=[13,15,17];
li=[12,14,16];
f1=figure();
up=[13,12];

% for frame=1
for frame=1:1:400
clf(f1)
% plot3(data(frame,(poi*3-2)),data(frame,(poi*3-0)),-data(frame,(poi*3-1)),'bo')
% hold on
plot3(data(frame,(ti*3-2)),data(frame,(ti*3-0)),-data(frame,(ti*3-1)),'b-')
hold on
plot3(data(frame,(ri*3-2)),data(frame,(ri*3-0)),-data(frame,(ri*3-1)),'b-')
hold on
plot3(data(frame,(li*3-2)),data(frame,(li*3-0)),-data(frame,(li*3-1)),'b-')
hold on
% plot3(data2(frame,(poi*3-2)),data2(frame,(poi*3-0)),-data2(frame,(poi*3-1)),'ro')
% hold on
plot3(data2(frame,(ti*3-2)),data2(frame,(ti*3-0)),-data2(frame,(ti*3-1)),'r-')
hold on
plot3(data2(frame,(ri*3-2)),data2(frame,(ri*3-0)),-data2(frame,(ri*3-1)),'r-')
hold on
plot3(data2(frame,(li*3-2)),data2(frame,(li*3-0)),-data2(frame,(li*3-1)),'r-')
hold on
% rotate and translate
xdiff = data(frame,(12*3-2)) + data2(frame+2,(12*3-2));
ydiff = data(frame,(12*3-0)) + data2(frame+2,(12*3-0));
zdiff = -data(frame,(12*3-1)) + data2(frame+2,(12*3-1));

lls = [-data2(frame+2,(12*3-2))+xdiff,-data2(frame+2,(12*3-0))+ydiff,-data2(frame+2,(12*3-1))+zdiff];
lrs = [-data2(frame+2,(13*3-2))+xdiff,-data2(frame+2,(13*3-0))+ydiff,-data2(frame+2,(13*3-1))+zdiff];
rls = [data(frame,(12*3-2)),data(frame,(12*3-0)),-data(frame,(12*3-1))];
rrs = [data(frame,(13*3-2)),data(frame,(13*3-0)),-data(frame,(13*3-1))];

% plot3(lrs(1),lrs(2),lrs(3),'ro')
% hold on

rb = rls-rrs;
lb = lls-lrs;

normal = cross(rb, lb);
% normal = normal + lls;
normal = normal / norm( normal );

plot3(normal(1),normal(2),normal(3),'g--')
hold on

le=[-data2(frame+2,(14*3-2))+xdiff,-data2(frame+2,(14*3-0))+ydiff,-data2(frame+2,(14*3-1))+zdiff];
la=[-data2(frame+2,(16*3-2))+xdiff,-data2(frame+2,(16*3-0))+ydiff,-data2(frame+2,(16*3-1))+zdiff];

e = le-lls;
a = la - lls;

alpha = acos(dot(rb,lb)/sqrt(norm(rb)*norm(lb)));

r = alpha * normal;
r = rotationVectorToMatrix(r);

le = r*e.'+lls;
la = r*a.'+lls;
% 
% plot3(-data2(frame+2,(li*3-2))+xdiff,-data2(frame+2,(li*3-0))+ydiff,-data2(frame+2,(li*3-1))+zdiff,'o')
% hold on
% plot3(-data2(frame+2,(li*3-2))+xdiff,-data2(frame+2,(li*3-0))+ydiff,-data2(frame+2,(li*3-1))+zdiff,'g-')
% hold on
% plot3(le(1),le(2),le(3),'go');plot3(la(1),la(2),la(3),'go');
% hold on

% % view([cos(45),sin(45),0])
xlim([-1,1])
ylim([-1,1])
zlim([-1,1])
drawnow
grid on
pause(0.1)
xlabel('x')
xlabel('y')
end



