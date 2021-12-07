% close all
load('coorddatasync.mat')
data=datasyn;

for j=1:size(data,2)
   signal=datasyn(:,j);
   data(:,j)=movmean(signal,10);
    
end
    
partnum=33;
xindex=(1:partnum)*3-2;% 1 horizontal in frame
yindex=(1:partnum)*3;% 3 depth info 
zindex=(1:partnum)*3-1;% 2 vetical in frame
body1=[12,13];

b1direction0=[mean(mean(data(:,xindex(12))))-mean(mean(data(:,xindex(13)))),...
    mean(mean(data(:,yindex(12))))-mean(mean(data(:,yindex(13)))),...
    mean(mean(data(:,zindex(12))))-mean(mean(data(:,zindex(13))))];
xyz_p=cell(1,size(data,1));
for i=1:size(data,1)
    xyz=zeros(7,2);
    xyz(1,1)=(data(i,xindex(12))+data(i,xindex(13)))/2;
    xyz(1,2)=(data(i,yindex(12))+data(i,yindex(13)))/2;
    xyz(1,3)=(data(i,zindex(12))+data(i,zindex(13)))/2;
    
    xyz(2,:)=xyz(1,:)+([data(i,xindex(13)),data(i,yindex(13)),data(i,zindex(13))]-xyz(1,:))...
        /norm([data(i,xindex(13)),data(i,yindex(13)),data(i,zindex(13))]-xyz(1,:))*0.3.*[1,1,0];
    xyz(5,:)=xyz(1,:)+([data(i,xindex(12)),data(i,yindex(12)),data(i,zindex(12))]-xyz(1,:))...
        /norm([data(i,xindex(12)),data(i,yindex(12)),data(i,zindex(12))]-xyz(1,:))*0.3.*[1,1,0];
    
    vec23=[data(i,xindex(15)),data(i,yindex(15)),data(i,zindex(15))]-[data(i,xindex(13)),data(i,yindex(13)),data(i,zindex(13))];
    vec56=[data(i,xindex(14)),data(i,yindex(14)),data(i,zindex(14))]-[data(i,xindex(12)),data(i,yindex(12)),data(i,zindex(12))];
    
    xyz(3,:)=xyz(2,:)+vec23/norm(vec23)*0.4;
    xyz(6,:)=xyz(5,:)+vec56/norm(vec56)*0.4;
    
    vec34=[data(i,xindex(17)),data(i,yindex(17)),data(i,zindex(17))]-[data(i,xindex(15)),data(i,yindex(15)),data(i,zindex(15))];
    vec67=[data(i,xindex(16)),data(i,yindex(16)),data(i,zindex(16))]-[data(i,xindex(14)),data(i,yindex(14)),data(i,zindex(14))];
    
    xyz(4,:)=xyz(3,:)+vec34/norm(vec34)*0.3;
    xyz(7,:)=xyz(6,:)+vec67/norm(vec67)*0.3;
    xyz(:,3)=-xyz(:,3);
    xyz_p{i}=xyz;
end

lineindex=[4,3,2,1,5,6,7];
fistindex=[4,7];
f1=figure();
for frame=1:1:400
% for frame=20
clf(f1)
xyz=xyz_p{frame};

plot3(xyz(lineindex,1),xyz(lineindex,2),xyz(lineindex,3),'g-')
hold on
plot3(xyz(fistindex,1),xyz(fistindex,2),xyz(fistindex,3),'ro')
hold on

% view([cos(0.01*frame),sin(0.01*frame),0])
view(3)
xlim([-1,1])
ylim([-1,1])
zlim([-1,1])

grid on
pause(0.01)
xlabel('x')
xlabel('y')
drawnow
end
save('coordsprocessed','xyz_p')