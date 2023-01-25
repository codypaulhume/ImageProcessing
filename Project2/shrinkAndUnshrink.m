function shrinkAndUnshrink()
% Shrinks the image to 300x225 pixels or 100dpi and then resizes that image
% to the original 1250dpi.
% Call the funtion above with no parameters to run.

A = imread("Proj_002_image1.tif");

% Given the original dimensions of the image are 2.25 inch wide and 3 inch
% high, the formula to get a 100dpi image would be as follows
% 2.25(100) and 3(100) = 300 x 225 pixel image

figure(1)
image(A);
axis ij
axis equal
axis tight
colormap(gray(256))
title('Original Image');

figure(2)
B = ip_bilin_int(A, 300, 225);
axis ij
axis equal
axis tight
title('Shrunk to 100dpi');

figure(3)
ip_bilin_int(B, 3692, 2812);
axis ij
axis equal
axis tight
title('Resized to Original Size After Bilinear Interpolation');