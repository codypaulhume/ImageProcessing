function twoCirclesBilin()
% Create two circles, one larger gray circle and one smaller white circle
% Uses the concpet of multiplying the values to achieve desired grayscale
% value. Then runs the ip_bilin_int() function to shrink the image.
% Call the function above with to parameters to run the code

% First create the image using the meshgrid with given image sizes
imageSizeX = 256;
imageSizeY = 256;
[columnsInImage, rowsInImage] = meshgrid(1:imageSizeX, 1:imageSizeY);
[columnsInImage2, rowsInImage2] = meshgrid(1:imageSizeX, 1:imageSizeY);

% Next create the 2 circles in the image.
centerX = imageSizeX / 2;
centerY = imageSizeY / 2;
radius = 64;
radius2 = 32;

% Ensure that the value is under the radius squared and store within
% circlePixels and circlePixels2
circlePixels = (rowsInImage - centerY).^2 ...
    + (columnsInImage - centerX).^2 <= radius.^2;

circlePixels2 = ((rowsInImage2 - centerY).^2 ...
    + (columnsInImage2 - centerX).^2 <= radius2.^2);

% Create a thrird pixel value that adds the two values 
% together and multiplies it by by 127.5 and 256
circlePixels3 = ((256 *circlePixels2)+(127.5 * circlePixels));

% Image the combined values
image(circlePixels3);
colormap(gray(256)) % a 256 level (8-bit) grayscale
title('Two Concentric Disks');
axis square;
axis equal;
axis tight;

figure(2)
ip_bilin_int(circlePixels3, 100, 100);
colormap(gray(256)) % a 256 level (8-bit) grayscale
title('Two Concentric Disks - Bilinear Interpolation');
axis square;
axis equal;
axis tight;