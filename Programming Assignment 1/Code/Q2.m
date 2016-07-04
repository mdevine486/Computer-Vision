%For running this code Call Q2.m on console and a image shows up. Now
%select points on 4 lines, 3 on each line. Lines selected should be two 
%distinct pairs of parallel lines. Then select base and top points of 
%vertical object of which the ration of height is to be found. The output
%gives the ratio.



%Read the Image and store in a File
File = 'Height.jpg';
A = imread(File);
imshow(A)

%Get the 3 points on each line and find the homogeneous line Equations
P1 = Get2DPoints(File, 3);
a1 = polyfit(P1(1,:),P1(2,:),1);

P2 = Get2DPoints(File, 3);
a2 = polyfit(P2(1,:),P2(2,:),1);

%X-coordinate of the intersection point
X1_point = (a1(2)-a2(2))/(a2(1)-a1(1));

P3 = Get2DPoints(File, 3);
a3 = polyfit(P3(1,:),P3(2,:),1);

P4 = Get2DPoints(File, 3);
a4 = polyfit(P4(1,:),P4(2,:),1);

%X-coordinate of the intersection point
X2_point  = (a3(2)-a4(2))/(a4(1)-a3(1));

%Finding homogenous line Equation of the Vanishing Line
Linel = polyfit([X1_point,X2_point],[polyval(a1,X1_point),polyval(a3,X2_point)],1);
L = [Linel(1),-1,Linel(2)];

%Get the Base and Top Points
B1 = [Get2DPoints(File, 1);1];
T1 = [Get2DPoints(File, 1);1];
B2 = [Get2DPoints(File, 1);1];
T2 = [Get2DPoints(File, 1);1];

%Finding Lines L1,L2 and points U,V
L1 = cross(B1,T1);
L2 = cross(B2,T2);

U = cross(cross(B1,B2),L);
V = cross(L1,L2);

%Finding the Shited line L1_bar
T1_bar = cross(cross(T1,U),cross(V,B2));

%Convert everything into distances wrt to Base point 2
t1_bar = norm([(T1_bar(1)/T1_bar(3))-B2(1);(T1_bar(2)/T1_bar(3))-B2(2)]);
t2 = norm([T2(1)-B2(1);T2(2)-B2(2)]);
v = norm([(V(1)/V(3))-B2(1);(V(2)/V(3))-B2(2)]);

%Find ratio based on the Equation
Ratio = (t1_bar*(v-t2))/(t2*(v-t1_bar))