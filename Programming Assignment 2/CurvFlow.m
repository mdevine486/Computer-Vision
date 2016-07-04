clear all
clc

%Take input image and convert it to binary

%in = imread('Crv2.gif');
%in = imread('C.png');
in = imread('pacman.png');
in = im2bw(in,0.5);

% Take the gaussian of the image to smooth the sharp turns in the image 
h = fspecial('gaussian',[5,5],16);
in = imfilter(in,h,'same');

% Get the boundary points using bwtraceboundary

%Cint = bwtraceboundary(imcomplement(in),[139 28],'N',8,Inf,'clockwise');
%Cint = bwtraceboundary(imcomplement(in),[77 23],'N',8,Inf,'clockwise');
Cint = bwtraceboundary(in,[72 34],'NE',8,Inf,'clockwise');

% Min the no of points on boundary by taking every alternate points
N = size(Cint,1);
min_Cint = [];
div = 2;
for i = 1:(N/div)
    min_Cint = [min_Cint;[Cint(i*div,1) Cint(i*div,2)]];
end

x = [min_Cint(:,1);min_Cint(1,1)];
y = [min_Cint(:,2);min_Cint(1,2)];

%plot of the initial curve
figure,
plot(y,x)
axis([-50 300 -50 300])

% In each iteration find the normal and curvature at each point and also 
% disp as Curv*Normal
itr = 300;
for i = 1:itr
dx = gradient(x);
ddx = gradient(dx);
dy = gradient(y);
ddy = gradient(dy);

temp = dx .* ddy - ddx .* dy;
ds = sqrt(dx.*dx + dy.*dy);

K = temp./(ds.*ds.*ds);
K(isnan(K)) = 0;

Nor = [-dy./ds,dx./ds];
Disp = -[K.*Nor(:,1),K.*Nor(:,2)];
Disp(isnan(Disp)) = 0;

x = smooth(x + Disp(:,1));
y = smooth(y + Disp(:,2));

%Plot the curve at 3 time steps of 100 itr.
if(i == 100 || i == 200 || i == 300)
    figure,
    plot(y,x,'r')
    axis([-50 300 -50 300])
end
end

