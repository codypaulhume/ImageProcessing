function [LPFG] = ip_LPFG(A, D0)
% This low pass gaussian filter takes in an input of A and a D0 value as
% its parameters to perform the zeropadding and filtering in the frequency
% domain. Call the function with the correct parameters to run.

A = double(A);
[h,w] = size(A);
U = h*2;
V = w*2;

% Create matrix of double the image size (h*2)

paddedImage = zeros(h*2);

% Create matrix for temp image

tempImg = [h,w];

% Multiply each location by (-1)^(x+y)

for i=1:h
    for j=1:w
        tempImg(i,j) = A(i,j)*((-1)^(i+j));
    end
end

% Inputs the original image in the new matrix of double the original image
% size

for i=1:h
    for j=1:w
        paddedImage(i,j) = tempImg(i,j);
    end
end

% Take the DFT of the padded image

twoDDFT = (fft2(paddedImage));

twoDmagSpec = log10(abs(twoDDFT));

threeDmagSpec = log10(abs(twoDDFT));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create gaussian kernel matrix and fill it using the gaussian equation on
% the lecture slides

gKernel = zeros(U);

for i=1:U
    for j=1:V
        DNumerator = sqrt(((i-(U/2))^(2))+((j-(V/2))^(2)));
        DivisionSquared = (DNumerator/D0)^(2);
        gKernel(i,j) = exp(-0.5*(DivisionSquared));
    end
end

magSpecFilter = log10(gKernel);

% Point by point multiply filter by the 2-D FFT

multiplication = zeros(U);

for i=1:U
    for j=1:V
        multiplication(i,j) = gKernel(i,j).*twoDDFT(i,j);
    end
end

magSpecImg = (multiplication);

% Take the inverse of the 2-D DFT.

inverseResult = ifft2(multiplication);

% Get the real part

realResult = real(inverseResult);

% Crop to orignal dimensions

croppedImage = realResult(1:h, 1:w);

% Multiply each location by (-1)^(x+y) again

LPFG = zeros(h);

for i=1:h
    for j=1:w
        LPFG(i,j) = croppedImage(i,j)*((-1)^(i+j));
    end
end

end
