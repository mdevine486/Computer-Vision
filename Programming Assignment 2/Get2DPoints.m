function XY2D=Get2DPoints(in, NumberOfPoints)
XY2D=[];
%[Img, Col]=imread(ImageFileName); %%% assuming the imagefile is a jpg file.
imshow(in); drawnow; hold on;
for i=1:NumberOfPoints
[x, y]=ginput(1);
v=[x;y];
plot(x, y);
XY2D=[XY2D v];
end
return;