%To run this code run Q4.m on console and the output gives four images,
%Phase of the phase only image 
%Mag only Image
%Mag Err Image
%Phase Err Image

%Read the image and take fft of it
x = imread('lena.bmp');
y = fft(x);

%Find Magnitude and phase of it
Mag = abs(y);
PH = angle(y);
PHi = cos(PH) + (1j*sin(PH));

%Take inverse fft on phase only and mag only
a = ifft(PHi);
b = ifft(Mag);

figure,
imshow(angle(a));
figure,
imshow(mat2gray(b,[0,255]));


%Add Err in magnitude
S = size(y);
N = S(1);
Er = randn(N);
Magnew = Mag + (100*rand(size(y)));

X = Magnew.*PHi;
xnew = ifft(X);
figure,
imshow(mat2gray(abs(xnew),[0,255]));

%Add Err to Phase
PHnew = PH + ((pi/2)*rand(size(y)));
PHnewi = cos(PHnew) + 1j*sin(PHnew);

X = Mag.*PHnewi;
xnew = ifft(X);
figure,
imshow(mat2gray(abs(xnew),[0,255]));