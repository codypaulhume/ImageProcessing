function [Y] = new_bilin_int(A, xnew, ynew)
% This function performs bilinear interpolation with three parameters. The
% first is the input image, and the following two is the new x and y
% values. The equations used are found from the lecture slides found on the
% course website.

% Ensure values are double
A = double(A);
% Get the size of the image input

[xOriginal, yOriginal] = size(A);

ratioX = ((xnew))/(xOriginal-1);

ratioY = ((ynew))/(yOriginal-1);

% Create intermediate size with old y value and new x value

intermediateMatrix = zeros(xnew, yOriginal);

finalMatrix = zeros(xnew, ynew);

for i=0:xnew-1
    for j=0:yOriginal-1

        % Divide ratio or zoom factor by the original locations value to
        % get v(x',y')
        temp = i/(ratioX);

        % num is the location of the pixel but floored to get the
        % integer value. dx is getting the decimal value of num

        num = floor(temp);
        dx = temp - num;

        % Implementing the equation from the lecture slides
        
        intermediateMatrix(i+1,j+1) = (1-dx)*A(num+1,j+1) + dx*A(num+2,j+1);
    end
end

for i=0:xnew-1
    for j=0:ynew-1

        % Divide ratio or zoom factor by the original locations value to
        % get v(x',y')

        temp2 = j/(ratioY);

        % num2 is the location of the pixel but floored to get the
        % integer value. dy is getting the decimal value of num2

        num2 = floor(temp2);
        dy = temp2 - num2;
        
        eq3 = ((1-dy)*intermediateMatrix(i+1, num2+1)) + (dy*intermediateMatrix(i+1,num2+2));

        % Store into new matrix as the final interpolation.
        finalMatrix(i+1,j+1) = eq3;
    end
end

Y = finalMatrix;

end