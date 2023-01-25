function Part7Homework01()
% Create two circles, one larger gray circle and one smaller white circle
% Adjustments to the frequency are made to show the image variations
% Call the function above to run the code

% First create the image using meshgrid with the image sizes chosen
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
% Create a third pixel value that adds the two values 
% together and multiplies it by by 127.5 and 256
circlePixels3 = ((256 *circlePixels2)+(127.5 * circlePixels));
% Image the combined values
figure(1)
image(circlePixels3);
colormap(gray(256)) % a 256 level (8-bit) grayscale
title('Two Concentric Disks');
axis square;
axis equal;
axis tight;
%%%%%%%%%%%%%%%%%%%%%
%Repeats process above
figure(2)
circlePixels = (rowsInImage - centerY).^4 ...
    + (columnsInImage - centerX).^4 <= radius.^4;

circlePixels2 = ((rowsInImage2 - centerY).^4 ...
    + (columnsInImage2 - centerX).^4 <= radius2.^4);

circlePixels3 = ((256 *circlePixels2)+(127.5 * circlePixels));
image(circlePixels3);
colormap(gray(256)) % a 256 level (8-bit) grayscale
title('Two Concentric Disks - 2^2');
axis square;
axis equal;
axis tight;
%%%%%%%%%%%%%%%%%%%%%
%Repeats process above
figure(3)
circlePixels = (rowsInImage - centerY).^8 ...
    + (columnsInImage - centerX).^8 <= radius.^8;

circlePixels2 = ((rowsInImage2 - centerY).^8 ...
    + (columnsInImage2 - centerX).^8 <= radius2.^8);
circlePixels3 = ((256 *circlePixels2)+(127.5 * circlePixels));
image(circlePixels3);
colormap(gray(256)) % a 256 level (8-bit) grayscale
title('Two Concentric Disks - 2^4');
axis square;
axis equal;
axis tight;
