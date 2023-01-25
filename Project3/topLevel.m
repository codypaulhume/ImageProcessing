function topLevel(A)
% This function contains all of the code that will form the steps needed to
% image the skeleton according to the textbook. Each step is detailed in
% the comments above the code.
% To run the code call the above function with an image as it's parameter.

L = 256;

A = double(A);

[h,w] = size(A);

% This is simply the original image.

figure(1);
image(A);
title("Original Image");
axis ij
axis equal
axis tight
colormap(gray(L))

% Laplacian data below. The new matrix for the laplacian is below with the
% diganol values. The laplacian is first shown scaled just for reference
% and because the project description requires it. To find the scaled
% laplacian, the equation takes the minimum of the laplacian and divides it
% by the max value of the new minimum found. Finally it all gets multiplied
% by the scale of 0-255 The actual laplacian is used by subracting it from
% the original image which is actually being used.

laplacianMatrix = [1 1 1;
                   1 -8 1
                   1 1 1];

scaledImageLaplacian = ip_mask(A, laplacianMatrix);

laplacianMin = scaledImageLaplacian - min(min(scaledImageLaplacian));

normalizedLaplacian = 255*(laplacianMin ./max((max(laplacianMin))));

figure(2);
image(normalizedLaplacian);
title("Normalized Laplacian");
axis ij
axis equal
axis tight
colormap(gray(L))

finalImageLaplacian = ip_mask(A, laplacianMatrix);
finalImageLaplacian = A - finalImageLaplacian;

figure(3);
image(finalImageLaplacian);
title("Sharpened image using Laplacian");
axis ij
axis equal
axis tight
colormap(gray(L))

% Sobel data below. This is a multi-step process which involes running the
% vertical sobel mask and taking the magnitude and then taking the
% horizontal sobel mask and taking the magnitude, and take the diagonal
% sobel masks as well doing the same process. Finally, all of those
% results are added together and finally imaged.

sobelMatrixH = [-1 -2 -1;
               0 0 0;
               1 2 1];

sobelMatrixV = [-1 -0 1;
               -2 0 2;
               -1 0 1];

sobelImageH = abs(ip_mask(A, sobelMatrixH));

sobelImageV = abs(ip_mask(A, sobelMatrixV));

finalSobelImage = sobelImageH + sobelImageV;

figure(4);
image(finalSobelImage);
title("Sobel of Original Image");
axis ij
axis equal
axis tight
colormap(gray(L))

% Smoothing data below. The matrix is a 5x5 of ones which will smooth the
% image once applied to the ip_mask function. Then to get around the
% averaging problem, the result was divided by 5^2. Finally the result is
% imaged.

smoothingMatrix = ones(5);

finalImageSmoothing = ip_mask(finalSobelImage, smoothingMatrix);

finalImageSmoothing = finalImageSmoothing*(1/25);

figure(5);
image(finalImageSmoothing);
title("Smoothed Image of Sobel");
axis ij
axis equal
axis tight
colormap(gray(L))

% The next step is to take the product of laplacian and the newly smoothed
% sobel image. But this needs to be scaled so the same process was used for
% this as it was for the laplacian. Find the min and max values of the
% product and scale them from 0 to 1. Then multiply that by 255 to get it
% back in the correct range. Finally, image the matrix.

product = (finalImageSmoothing.*finalImageLaplacian);

minProduct = min(min(product));

maxProduct = max(max(product));

finalProduct = (255*((product - minProduct)./(maxProduct)));

figure(6);
image(finalProduct);
title("Product of Smoothed Sobel and Laplacian");
axis ij
axis equal
axis tight
colormap(gray(L))

% The next step is to take the original image and add it to the result of
% the laplacian and newly smoothed sobel image. 

sharpenedOriginalProduct = A + finalProduct;

figure(7);
image(sharpenedOriginalProduct);
title("Add Original Image and Product of Sobel with Laplacian");
axis ij
axis equal
axis tight
colormap(gray(L))

% The final step is to apply the power law transform. The equationm to use
% a power law transform or gamma correction is s = cr^(gamma) which is used
% below. The constant c =1 and gamma = 1.185. I found that this value closely
% represents what the figures in the textbook show (skin and bones).
% Finally the final result is imaged.

sharpenedOriginalProduct = double(sharpenedOriginalProduct);

for i=1:h
    for j=1:w
        finalPowerLaw(i,j) = 1*(sharpenedOriginalProduct(i,j)^1.185);
    end
end

finalPowerLaw = abs(finalPowerLaw);

figure(8);
image(finalPowerLaw);
title("Power Law Transform");
axis ij
axis equal
axis tight
colormap(gray(L))

end