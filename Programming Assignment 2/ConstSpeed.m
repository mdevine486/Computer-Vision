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

a = [min_Cint(:,1);min_Cint(1,1)];
b = [min_Cint(:,2);min_Cint(1,2)];
%plot of the initial curve
figure,
plot(b,a)
axis([-50 300 -50 300])

x = min_Cint(:,1);
y = min_Cint(:,2);

% In each iteration find the normal at each point and also disp as
% Const*Normal
itr = 3;
for i = 1:itr
dx = gradient(x);
dy = gradient(y);
ds = sqrt(dx.*dx + dy.*dy);

Const = 5;

Nor = [-dy./ds,dx./ds];
Disp = -Const*Nor;
Disp(isnan(Disp)) = 0 ;

x = smooth(x + Disp(:,1));
y = smooth(y + Disp(:,2));

%figure,
%quiver(y,x,Disp(:,1),Disp(:,2))

%Plot of evolving curve at each step
figure,
plot(b,a)
hold on
plot(y,x,'r')
axis([-50 300 -50 300])
end