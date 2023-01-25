function finalImage = ip_mask(A, maskArray)
% This function will take any image and a given array as its parameters and
% create a mask that will alter the image. It will run through every pixel
% determined by the size of the mask and averaging them and place that
% value in a new array.
% This function can be called above using the parameters

A = double(A);

[h, w] = size(A);

% This matrix will be where the computed values will be stored.

finalImage = ones(h);

% Grabbing the size of the given array. Only the height is being used so a
% tilda is being for the width

[maskH, ~] = size(maskArray);

% To create a padded image, I created an entirely new maxtrix with zeros
% and filled in the matrix with the original image.

% numPads takes the size of the desired array and subracts 1 then divides
% by two to find the rows and columns needed to pad the image.
numPads = (maskH-1)/2;

% This is used to calculate the number of pads for both sides of the image.
totalNumber = (2*numPads)+h;

% Creates matrix of zeros based on the new padding values found above.
paddedImage = zeros(totalNumber);

% This double for loop adds the original image into the new matrix allowing
% space for the zero padding on the edge
for i=1:h
    for j=1:w
        paddedImage(i+numPads,j+numPads) = A(i,j);
    end
end

% This for loop does multiple steps. First, the filter array (maskArray x maskArray) of all
% ones is multipled with a maskArray x maskArray matrix of the newly padded image. Since the
% image is already padded, the matrix can start at 1,1. The matrix of
% paddedImage "shifts" across the row 1 pixel at a time. It is then
% averaged by taking the sum of all the values within and dividing it by
% the total (mask array size^2). Finally, the averagedPixels is stored
% within the new matrix finalImage which is what is displayed at the end.

for i=1:h
    for j=1:w
        matrixMultiplied = (maskArray.*paddedImage(i:(maskH+(i-1)), j:(maskH + (j-1))));
        sumOfMatrix = sum(matrixMultiplied, 'all');
        finalImage(i,j) = sumOfMatrix;
    end
end

finalImage = finalImage(1:h, 1:w);

end