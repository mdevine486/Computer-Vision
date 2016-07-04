clear all
clc

temp = imread('pacman.png');
temp = im2bw(temp,0.5);
I = zeros(456,456);
I(101:356,101:356) = temp;

h = fspecial('gaussian',[5,5],16);
I = imfilter(I,h,'same');

X1 = [];
Y1 = [];

nofP = 8;
P = Get2DPoints(I,nofP);
X = [P(1,:) P(1,1)];
Y = [P(2,:) P(2,1)];

for i =1:nofP
   i1 = i;
   i2 = i+1;

   x = spline([0,1],[X(i1),X(i2)],[0:0.025:1]);
   y = spline([0,1],[Y(i1),Y(i2)],[0:0.025:1]);

   X1 = [X1 x];
   Y1 = [Y1 y];
end

hold on,
plot(X1,Y1)

X_cor = X1(1:(size(X1,2)-1));
Y_cor = Y1(1:(size(Y1,2)-1));

[Ix,Iy] = gradient(I);
u = Ix;
v = Iy;
mu = 0.18;
b = Ix.*Ix + Iy.*Iy;
c1 = b.*Ix;
c2 = b.*Iy;

itr = 300;
for i = 1:itr
    u = (1-b).*u + 4*mu*del2(u) + c1;
    v = (1-b).*v + 4*mu*del2(v) + c2;
    div = divergence(u,v);
    
Div = interp2(div,X_cor,Y_cor);
    
dx = gradient(X_cor);
ddx = gradient(dx);
dy = gradient(Y_cor);
ddy = gradient(dy);

temp = dx .* ddy - ddx .* dy;
ds = sqrt(dx.*dx + dy.*dy);

K = temp./(ds.*ds.*ds);
K(isnan(K)) = 0 ;

Mul = Div + K;
Nor = [-dy./ds,dx./ds];

Disp = [Mul.*Nor(:,1),Mul.*Nor(:,2)];
Disp(isnan(Disp)) = 0 ;

X_cor = smooth(X_cor + Disp(:,1));
Y_cor = smooth(Y_cor + Disp(:,2));    

%Plot the curve at 3 time steps of 100 itr.
if(i == 100 || i == 200 || i == 300 || i == 400)
    figure,
    imshow(I)
    hold on
    plot(X_cor,Y_cor,'r')
end
end  