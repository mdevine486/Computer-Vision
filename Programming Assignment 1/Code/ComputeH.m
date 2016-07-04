% This funtion is used in computing the Projection Matrix given Input Image
% Points and the matching points

function H =ComputeH(ImageFilePoints, MatchingPoints)

A = [];
F = [];

for i = 1:4
    Y = ImageFilePoints(:,i);
    X = MatchingPoints(:,i);
    
    %Using the Matrix for DLT    
    Temp = [X.' 1 0 0 0 -Y(1)*X.';
            0 0 0 X.' 1 -Y(2)*X.'];
            
    A = [A; Temp];
    F = [F; Y];
end

%Applying ||H||=1
K = inv(A)*F;
K = [K;1];
K = K/norm(K);
H = [K(1) K(2) K(3);  K(4) K(5) K(6); K(7) K(8) K(9)];

end