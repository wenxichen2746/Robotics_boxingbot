% clc
% clear
function robot=createrobot()
visual=false;
Ltrun=0.500;
Lshwid=0.300;
Luplen=0.400;
Llolen=0.300;

robot = rigidBodyTree;
robot.DataFormat = 'row';
robot.Gravity = [0 0 -9.81];

%trunk
body1 = rigidBody('body1');
body1.Mass=8;
jnt1 = rigidBodyJoint('jnt1','revolute');
tform = trvec2tform([0, 0,Ltrun]); %H transfrom matrix
setFixedTransform(jnt1,tform);
jnt1.JointAxis=[0,0,1];
body1.Joint = jnt1;

%right shoulder 3dof
body2=rigidBody('body2');
body2.Mass=1;
jnt2 = rigidBodyJoint('jnt2','revolute');
tform = trvec2tform([Lshwid, 0, 0]);
setFixedTransform(jnt2,tform);
jnt2.JointAxis=[1,0,0];
body2.Joint = jnt2;

body3=rigidBody('body3');
body3.Mass=1;
jnt3 = rigidBodyJoint('jnt3','revolute');
tform = trvec2tform([0, 0, 0]);
setFixedTransform(jnt3,tform);
jnt3.JointAxis=[0,-1,0];
body3.Joint = jnt3;


%righ upper arm
body4=rigidBody('body4');
body4.Mass=7;
jnt4 = rigidBodyJoint('jnt4','revolute');
tform = trvec2tform([0, 0, 0]);
setFixedTransform(jnt4,tform);
jnt4.JointAxis=[0,0,1];
body4.Joint = jnt4;



%righ lower arm
body5=rigidBody('body5');
body5.Mass=7;
jnt5 = rigidBodyJoint('jnt5','revolute');
tform = trvec2tform([0, 0, -Luplen]);
setFixedTransform(jnt5,tform);
jnt5.JointAxis=[1,0,0];
body5.Joint = jnt5;


%right fist
body11=rigidBody('body11');
body11.Mass=1;
jnt11 = rigidBodyJoint('jnt11','fixed');
tform = trvec2tform([0, 0, -Llolen]);
setFixedTransform(jnt11,tform);
body11.Joint = jnt11;

% left shoulder
body6=rigidBody('body6');
body6.Mass=1;
jnt6 = rigidBodyJoint('jnt6','revolute');
tform = trvec2tform([-Lshwid, 0, 0]);
setFixedTransform(jnt6,tform);
jnt6.JointAxis=[1,0,0];
body6.Joint = jnt6;


body7=rigidBody('body7');
body7.Mass=1;
jnt7 = rigidBodyJoint('jnt7','revolute');
tform = trvec2tform([0, 0, 0]);
setFixedTransform(jnt7,tform);
jnt7.JointAxis=[0,1,0];
body7.Joint = jnt7;


%left upper arm
body8=rigidBody('body8');
body8.Mass=7;
jnt8 = rigidBodyJoint('jnt8','revolute');
tform = trvec2tform([0, 0, 0]);
setFixedTransform(jnt8,tform);
jnt8.JointAxis=[0,0,1];
body8.Joint = jnt8;


%left lower arm
body9=rigidBody('body9');
body9.Mass=7;
jnt9 = rigidBodyJoint('jnt9','revolute');
tform = trvec2tform([0, 0, -Luplen]);
setFixedTransform(jnt9,tform);
jnt9.JointAxis=[1,0,0];
body9.Joint = jnt9;


%lefy fist
body12=rigidBody('body12');
body12.Mass=1;
jnt12 = rigidBodyJoint('jnt12','fixed');
tform = trvec2tform([0, 0 , -Llolen]);
setFixedTransform(jnt12,tform);
body12.Joint = jnt12;

% if visual
    addVisual(body1,"mesh",'010104.STL',rotm2tform(roty(90))*trvec2tform([-0.05,-0.05,-0.20]))
%     addVisual(body2,"mesh",'100mm3cube.STL',trvec2tform([-50,-50,-50]))
%     addVisual(body3,"mesh",'100mm3cube.STL',trvec2tform([-50,-50,-50]))
    addVisual(body4,"mesh",'00500502.stl',trvec2tform([-0.02,-0.02,-0.300]))
     addVisual(body8,"mesh",'00500502.stl',trvec2tform([-0.02,-0.02,-0.300]))
     
         addVisual(body5,"mesh",'00500502.stl',trvec2tform([-0.02,-0.02,-0.300]))
     addVisual(body9,"mesh",'00500502.stl',trvec2tform([-0.02,-0.02,-0.300]))
%     addVisual(body5,"mesh",'400x110x110.STL',rotm2tform(rotx(90))*trvec2tform([-55,-55,-400]))
%     addVisual(body6,"mesh",'100mm3cube.STL',trvec2tform([-50,-50,-50]))
%     addVisual(body7,"mesh",'100mm3cube.STL',trvec2tform([-50,-50,-50]))
%     addVisual(body8,"mesh",'400x110x110.STL',trvec2tform([-55,-55,-400]))
%     addVisual(body9,"mesh",'400x110x110.STL',rotm2tform(rotx(90))*trvec2tform([-55,-55,-400]))
% end
addBody(robot,body1,'base')
addBody(robot,body2,'body1')
addBody(robot,body3,'body2')
addBody(robot,body4,'body3')
addBody(robot,body5,'body4')
addBody(robot,body6,'body1')
addBody(robot,body7,'body6')
addBody(robot,body8,'body7')
addBody(robot,body9,'body8')
addBody(robot,body11,'body5')
addBody(robot,body12,'body9')


figure(2)
show(robot)
showdetails(robot)
config = homeConfiguration(robot);
end
% %%
% atlas = loadrobot("atlas");
% figure
% show(atlas)
% showdetails(atlas)