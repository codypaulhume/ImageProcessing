function [laplacianImage] = ip_laplacian(A)
% This function will take an input image and perform a laplacian using a
% 3x3 matrix kernel. 

L=256;

A = double(A);

[h, w] = size(A);

B = zeros(w);

for i=1:h
    for j=1:w
        B(i,j) = A(i,j);
    end
end


% This matrix will be where the computed values will be stored.

laplacianImage = ones(h);

% This matrix is the filter array. It is filled with the laplacian matrix
% given on the lecture slides for diagnal and horizontal lines.

filterArray = [1 1 1;
               1 -4 1;
               1 1 1];

% To create a padded image, I created an entirely new maxtrix with zeros
% padding the top row of the image. I then added the original image inside
% the matrix using a for loop below. This is a set number since we know the
% array size being used.

% This is used to calculate the number of pads for both sides of the image.
totalNumber = 2+w;

% Creates matrix of zeros based on the new padding values found above.
paddedImage = zeros(totalNumber);

% This double for loop adds the original image into the new matrix allowing
% space for the zero padding on the edge
for i=1:h
    for j=1:w
        paddedImage(i+1,j+1) = B(i,j);
    end
end

% This for loop does multiple steps. First, the filter array (3 x 3) of all
% ones is multipled with a 3 x 3 matrix of the newly padded image. Since the
% image is already padded, the matrix can start at 1,1. The matrix of
% paddedImage "shifts" across the row 1 pixel at a time. It is then
% averaged by taking the sum of all the values within and dividing it by
% the total (3^2). Finally, the averagedPixels is stored
% within the new matrix finalImage which is what is displayed at the end.

for i=1:h
    for j=1:w
        matrixMultiplied = (filterArray.*paddedImage(i:(3+(i-1)), j:(3 + (j-1))));
        sumOfMatrix = sum(matrixMultiplied, 'all');
        averagedPixels = sumOfMatrix/(3.^2);
        laplacianImage(i,j) = averagedPixels;
    end
end

% Cropped image to be original size
laplacianImage = laplacianImage(1:h, 1:w);

% Add the laplaican image to the original to get result
newFinal = laplacianImage + A;

laplacianImage = newFinal;

end