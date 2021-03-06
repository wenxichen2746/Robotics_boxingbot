% function qs=datacoor2qIK()
% clear
% close all
load('coordsprocessed.mat')

xyz=xyz_p{1};
vec25_f0=xyz(5,:)-xyz(2,:);

qsTrack=zeros(length(xyz_p),9);
for i=1:length(xyz_p)
    xyz=xyz_p{i};
    vec25=xyz(5,:)-xyz(2,:);
    
    pm1=sign(norm(dot(cross(vec25_f0,vec25),[0,0,1])));
    qsTrack(i,1)=pm1*vecAng(vec25,vec25_f0);%trunk lean angel
        
    frontvec=cross([0,0,-1],vec25);
    vec23=xyz(3,:)-xyz(2,:);
    vec23_p=projec2plain(vec23,vec25);
    pm2=sign(norm(dot(cross([0,0,-1],vec23_p),-vec25)));
    qsTrack(i,2)= pm2*vecAng(vec23,[0,0,-1]);
    vec56=xyz(6,:)-xyz(5,:);
    vec56_p=projec2plain(vec56,vec25);
    invq3=cross(vec25,-vec23_p);
    q7=cross(-vec25,vec56_p);
    
    pm6=sign(norm(dot(cross([0,0,-1],vec56_p),-vec25)));
    qsTrack(i,6)=pm6*vecAng(vec56,[0,0,-1]);%raise arm forward angel
    
    pm3=sign(norm(dot(cross(vec23,vec23_p),invq3)));
    qsTrack(i,3)=pm3*vecAng(vec23,vec23_p);
    pm7=sign(norm(dot(cross(vec56_p,vec56),q7)));
    qsTrack(i,7)=pm7*vecAng(vec56_p,vec56);%raise arm sideway angel
    
    vec34=xyz(4,:)-xyz(3,:);
    vec67=xyz(7,:)-xyz(6,:);%elbow angel
    
    pm5=sign(norm(dot(cross(vec23,vec34),-vec25)));
    qsTrack(i,5)=pm5*vecAng(vec34,vec23);
    pm9=sign(norm(dot(cross(vec56,vec67),-vec25)));
    qsTrack(i,9)=pm9*vecAng(vec67,vec56);
    
    vec34_p=projec2plain(vec34,vec23);
    vec67_p=projec2plain(vec67,vec56);
    
    pm4=sign(norm(dot(cross(vec34_p,invq3),-vec23)));
    qsTrack(i,4)=pm4*vecAng(vec34_p,invq3);
    pm8=-sign(norm(dot(cross(q7,vec67_p),-vec56)));
    qsTrack(i,8)=pm8*vecAng(vec67_p,q7);
end

N=size(qsTrack,1);
qsTrackVel=qsTrack;
for j=1:9
    f=qsTrack(:,j);
    dt=1/24;
    f_prime=zeros(1,N);
    f_prime(1)=dot(f(1:3),[-3,4,-1])/2/dt;
    f_prime(2:end-1)=(f(3:N)-f(1:N-2))/2/dt;
    f_prime(end)=dot(f(end-2:end),[1,-4,3])/2/dt;
    qsTrackVel(:,j)=f_prime;
end

for j=1:9
    qsTrack_extend(:,j)=extendarray(qsTrack(:,j),4);  
    qsTrackVel_extend(:,j)=extendarray(qsTrackVel(:,j),4);  
end

save('qsdata.mat','qsTrack','qsTrack_extend','qsTrackVel','qsTrackVel_extend')

function angle=vecAng(a,b)
angle=atan2(norm(cross(a,b)), dot(a,b));
end
function veconplain=projec2plain(vec,plainvec)
veconplain=vec-dot(vec,plainvec)/norm(plainvec)/norm(plainvec)*plainvec;
end

% end