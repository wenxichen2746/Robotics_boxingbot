clc
clear
data1=load('coords_1.csv');
data2=load('coords_2.csv');

%%
partnum=33;
xindex=(1:partnum)*3-2;% 1 horizontal in frame
yindex=(1:partnum)*3;% 3 depth info 
zindex=(1:partnum)*3-1;% 2 vetical in frame
datasyn=zeros(size(data2));
tlength=min([size(data1,1),size(data2,1)]);

ti=[13,12,24,25,13];%body trunk
ri=[13,15,17];%right arm
li=[12,14,16];%left arm
ai=[16,14,12,13,25,24,12,13,15,17];


ox1=mean(mean(data1(:,xindex(ti))));%center of trunk
oy1=mean(mean(data1(:,yindex(ti))));
oz1=mean(mean(data1(:,zindex(ti))));
ox2=mean(mean(data2(:,xindex(ti))));%center of trunk
oy2=mean(mean(data2(:,yindex(ti))));
oz2=mean(mean(data2(:,zindex(ti))));
dxyz=[ox1,oy1,oz1]-[ox2,oy2,oz2];
data2([xindex,yindex,zindex])=data2([xindex,yindex,zindex])+extendarray(dxyz,33);

for b=1:33
    i=xindex(b);
    j=yindex(b);
    k=zindex(b);
    [data2(:,i),data2(:,j),data2(:,k)]=rotation(data2(:,i),data2(:,j),data2(:,k),0,0,240/180*pi,ox1,oy1,oz1);
end


datasyn(1:tlength,[xindex([ri,25]),yindex([ri,25]),zindex([ri,25])])=data1(1:tlength,[xindex([ri,25]),yindex([ri,25]),zindex([ri,25])]);
datasyn(1:tlength,[xindex([li,24]),yindex([li,24]),zindex([li,24])])=data2(1:tlength,[xindex([li,24]),yindex([li,24]),zindex([li,24])]);
save('coorddatasync.mat','datasyn')

f1=figure(1);
% for frame=200
for frame=1:1:400
clf(f1)
% plot3(data1(frame,xindex(ai)),data1(frame,yindex(ai)),-data1(frame,zindex(ai)),'b-')
% hold on
% 
% plot3(data2(frame,xindex(ai)),data2(frame,yindex(ai)),-data2(frame,zindex(ai)),'r-')
% hold on

plot3(datasyn(frame,xindex(ai)),datasyn(frame,yindex(ai)),-datasyn(frame,zindex(ai)),'g-')
hold on

% plot3(ox1,oy1,-oz1,'bo')
% view([cos(0.01*frame),sin(0.01*frame),0])
view(3)
xlim([-1,1])
ylim([-1,1])
zlim([-1,1])
title('Data sync from 2 cam')
grid on
pause(0.01)
xlabel('x')
xlabel('y')
drawnow
end

function [outputa]=extendarray(inputa,n)
outputa=ones(length(inputa),n);
for i=1:length(inputa)
   outputa(i,:)= outputa(i,:)*inputa(i);
end
outputa=reshape(outputa',[1,length(inputa)*n]);
end

function [mx,my,mz]=rotation(mx,my,mz,a1,a2,a3,ox,oy,oz)
mox=mx-ox;
moy=my-oy;
moz=mz-oz;
Rx=[1 0 0;0 cos(a1) -sin(a1);0 sin(a1) cos(a1)];
Ry=[cos(a2) 0 sin(a2); 0 1 0; -sin(a2) 0 cos(a2)];
Rz=[cos(a3) -sin(a3) 0; sin(a3) cos(a3) 0;0 0 1];

for i=1:length(mx)
   newxyz=[ox,oy,oz]+[mox(i),moy(i),moz(i)]*Rx*Ry*Rz;
   mx(i)=newxyz(1);
   my(i)=newxyz(2);
   mz(i)=newxyz(3);
end

end