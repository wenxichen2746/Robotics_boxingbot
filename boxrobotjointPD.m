function jointTorque=boxrobotjointPD(qTarget,qTarVel,qs,qVel)
% Kp=[1,  1,1,1,   1,   1,1,1, 1]*40;
Kp=[120, 220,100,100,   100,   220,100,100,   100, ];
Kd=[60, 50,80,50,   30,   50,80,50,   30,];

jointTorque=Kp.*(qTarget-qs)+Kd.*(qTarVel-qVel);

maxlimit=[300,200,200,200,100,200,200,200,100];
for i =1:9
% jointTorque(find(jointTorque>maxlimit))=maxlimit;
% jointTorque(find(jointTorque<-maxlimit))=-maxlimit;
if jointTorque(i)>maxlimit(i)
    jointTorque(i)=maxlimit(i);
end
if jointTorque(i)<-maxlimit(i)
    jointTorque(i)=-maxlimit(i);
end
end

end

