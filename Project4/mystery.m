function mystery(A)

L = 256;

% Mystery image code below
% First, the image is not centered so it needs to be shifted

shifted = fftshift(A);

% Next we need to perform the inverse 2-D DFT to get it back to the spatial
% domaina

inversed = ifft2(shifted);

% Last we need to crop the image to its original size which is given in the
% project 04 assignment file and take the magnitude of the result

cropped = inversed(1:2196, 1:2041);

figure(7);
image(abs(cropped));
axis ij
axis equal
axis tight
colormap(gray(L))
end