function jointTorque=boxrobotjointPD(qTarget,qTarVel,qs,qVel)
Kp=[1,  1,1,1,   1,   1,1,1, 1]*100;
Kd=[1,  1,1,1,   1,   1,1,1, 1]*100;

jointTorque=Kp.*(qTarget-qs)+Kd.*(qTarVel-qVel);

maxlimit=500;

jointTorque(find(jointTorque>maxlimit))=maxlimit;
jointTorque(find(jointTorque<-maxlimit))=-maxlimit;

end

