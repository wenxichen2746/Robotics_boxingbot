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