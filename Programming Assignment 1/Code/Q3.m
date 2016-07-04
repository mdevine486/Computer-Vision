%To run this code run Q3.m on console an image shows up. select four
%points starting from left top and go in clock wise driection around the
%corners of the board.Output gives an undistored image

%Get points on the distorted image 
ImageFileName = 'Distorted.jpg';
ImageFilePoints = Get2DPoints(ImageFileName, 4);

%X,Y,L,H are chossen manually according to real world apperance
X = 400;
Y = 1000;
L = 1400;
H = 1000;

%Matching Points have been ordered in the same way as the selected points
%on distorted image, then ComputeH function has been called
MatchingPoints = [X X+L X+L X; Y Y Y+H Y+H]
H =ComputeH(ImageFilePoints, MatchingPoints)

In = imread(ImageFileName);
Anew = zeros(size(In,1),size(In,2),3);
Hi = inv(H);

%Now inverse of H is applied to the distorted image to get the undistorted
%vesion
for h = 1:3
for i = 1:size(In,1)
    for j= 1:size(In,2)
        Out = Hi*[i;j;1];
        
        x = round(Out(1)/Out(3));
        y = round(Out(2)/Out(3));
        
        %Interpolation
        if(x>1 && x<size(In,1) && y>1 && y<size(In,2))
            Anew(i,j,h) = In(x,y,h) ;
        end
    end
end
end

imshow(uint8(Anew));