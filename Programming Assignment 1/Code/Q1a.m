%To run this function Q1a should be called with a parameter as angle TH and
%the ouput show the results after Rotation

function Anew = Q1a(TH)

%Read the image into an array and surround the image by black pixels for
%better output.
A = imread('flat1.JPG');
AS = zeros(600,600,3);
AS(151:450,151:450,:) = A

T = [cos(TH),sin(TH);-sin(TH),cos(TH)];
Anew = zeros(size(AS,1),size(AS,2),3);

%For rotation around centre first derive the centre points.
Xcentre = ceil(size(AS,1)/2);
Ycentre = ceil(size(AS,2)/2);

%Applying Transformation matrix T to the Image
for h = 1:3
for i = 1:size(AS,1)
    for j= 1:size(AS,2)
        x = (i-Xcentre)*cos(TH) + (j-Ycentre)*sin(TH);
        y = -(i-Xcentre)*sin(TH) + (j-Ycentre)*cos(TH);
        
        x = round(x) + Xcentre;
        y = round(y) + Ycentre;
        
        if(x>1 && x<size(AS,1) && y>1 && y<size(AS,2))
            Anew(i,j,h) = AS(x,y,h) ;
        end
    end
end
end

figure,
imshow(uint8(AS))
figure,
imshow(uint8(Anew));
end