function shrinkByFactors()
% Shrinks the original image by different factors of 2, 8, and 25 and
% displays them.
% Call the function above with no parameters to run.

A = imread("Proj_002_image1.tif");

% Shrink by a factor of 2
figure(1)
ip_bilin_int(A, 1846, 1406);
axis ij
axis equal
axis tight
title('Shrunk by a factor of 2 to 1846x1406 pixels');

% Shrink by a factor of 8
figure(2)
ip_bilin_int(A, 923, 703);
axis ij
axis equal
axis tight
title('Shrunk by a factor of 8 to 452x362 pixels');

% Shrink by a factor of 25
figure(3)
ip_bilin_int(A, 148, 50);
axis ij
axis equal
axis tight
title('Shrunk by a factor of 25 in x and 56 in y to 148x50 pixels');
