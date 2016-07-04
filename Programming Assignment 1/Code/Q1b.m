%To run this code Q1b should be called and the ouput show the results after
%every shear. First X and then followed by Y and X again.


%Read the image into an array and surround the image by black pixels for
%better output and input the angle Theta(TH)
A = imread('flat1.JPG');
AS = zeros(1200,1200,3);
AS(451:750,451:750,:) = A
TH = pi/6;

%Define the matrixes of X and Y shears
A = [1,-tan(TH/2);0,1];
B = [1,0;sin(TH),1];


% Applying X-shear initially with Lamda = -tan(TH/2)
AX = zeros(size(AS,1),size(AS,2),3);
for h = 1:3
for i = 1:size(AS,1)
    for j= 1:size(AS,2)
        x = i - (tan(TH/2)*j);
        y = j;
        
        x = round(x);
        y = round(y);
        
        if(x>1 && x<size(AS,1) && y>1 && y<size(AS,2))
            AX(x,y,h) = AS(i,j,h) ;
        end
    end
end
end
figure,
imshow(uint8(AX));


% Applying Y-shear after an X-shear with Lamda = Sin(TH)
AXY = zeros(size(AX,1),size(AX,2),3);
for h = 1:3
for i = 1:size(AX,1)
    for j= 1:size(AX,2)
        x = i;
        y = (i*sin(TH)) + j;
        
        x = round(x);
        y = round(y);
        
        if(x>1 && x<size(AS,1) && y>1 && y<size(AS,2))
            AXY(x,y,h) = AX(i,j,h) ;
        end
    end
end
end
figure,
imshow(uint8(AXY));


% Applying X-shear again with Lamda = -tan(TH/2)
AXYX = zeros(size(AXY,1),size(AXY,2),3);
for h = 1:3
for i = 1:size(AX,1)
    for j= 1:size(AX,2)
        x = i - (tan(TH/2)*j);
        y = j;
        
        x = round(x);
        y = round(y);
        
        if(x>1 && x<size(AS,1) && y>1 && y<size(AS,2))
            AXYZ(x,y,h) = AXY(i,j,h) ;
        end
    end
end
end
figure,
imshow(uint8(AXYZ));