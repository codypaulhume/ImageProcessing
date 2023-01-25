function [Y] = ip_bilin_int(A, xnew, ynew)
% Function that will resize an image using linear interpolation.
% Use the format "ip_bilin_int(image, newRows, newColums)
%
% Help recieved from MATLAB help section mathworks.com

L=256;
% Ensue values are double
A = double(A);
% Get the size of the image input
% Get the inputs of new dimensions
[h, w] = size(A);
height = (xnew);
width = (ynew);

% Creates a ratio of the new values by division
if ynew > xnew
    ratio = xnew/ynew;
elseif ynew == xnew
    ratio = 1;
else
    ratio = ynew/xnew;
end

% Create matrix Y with the new values
Y = zeros(height,width);
height2 = (h/height);
weight2 = (w/width);
    for i=1:height
        % This equation can be derived by using the MATLAB imresize()
        % function
      y = (height2 * i) + (0.5 * (1 - 1/ratio));
        for j=1:width
           x = (weight2 * j) + (0.5 * (1 - 1/ratio));
      %// Any values out of acceptable range
          x(x < 1) = 1;
          x(x > w - 0.01) = w - 0.01;
          % Floor command used to round to nearest integer
          % Set x1 to nearest integer and x2 to the next pixel
          x1 = floor(x);
          x2 = x1 + 1;
          y(y < 1) = 1;
          y(y > h - 0.01) = h - 0.01;
          % Set y1 to nearest integer and y2 to the next pixel
          y1 = floor(y);
          y2 = y1 + 1;
          % Neighboring Pixels
          pixelNeighbor1 = A(y1,x1);
          pixelNeighbor2 = A(y1,x2);
          pixelNeighbor3 = A(y2,x1); 
          pixelNeighbor4 = A(y2,x2);
          % Pixels Weights
          newWeight1 = (y2-y)*(x2-x);
          newWeight2 = (y2-y)*(x-x1);
          newWeight3 = (x2-x)*(y-y1);
          newWeight4 = (y-y1)*(x-x1);
          % Set the new matrix by multiplying the weight and getting the
          % sum
          Y(i,j) = newWeight1 * pixelNeighbor1 + newWeight2 * pixelNeighbor2 + newWeight3 * pixelNeighbor3 + newWeight4 * pixelNeighbor4;
        end
    end
    figure(1);
    image(Y);
    axis ij
    axis equal
    axis tight
    colormap(gray(L))
end


