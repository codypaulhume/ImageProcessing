function [GBNF, twoDmagSpec, magSpecFilter, magSpecImg]  = ip_GBNF(A, D0, u0, v0)
% This notch reject gaussian filter takes in an input of A as the image,D0 
% value as the center value of the magnitude, and u0 and v0 as the location
% of where to get rid of the frequency from the center
% It performs the zeropadding and filtering in the frequency domain. 
% Call the function with the correct parameters to run.

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

twoDDFT = fft2(paddedImage);

twoDmagSpec = log10(abs(twoDDFT));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create gaussian kernel matrix and fill it using the gaussian equation on
% the lecture slides

gKernel = zeros(U);

for i=1:U
    for j=1:V
        numer = ((i-(U/2)-u0)^(2)) + ((j-(V/2)-v0)^(2));
        numer2 = ((i-(U/2)+u0)^(2)) + ((j-(V/2)+v0)^(2));
        DUV1 = numer^(0.5);
        DUV2 = numer2^(0.5);
        gKernel(i,j) = 1-(exp(-0.5*(((DUV1*DUV2)/(D0^(2)))^(2))));
    end
end

magSpecFilter = gKernel;

% Point by point multiply filter by the 2-D FFT

multiplication = zeros(U);

for i=1:U
    for j=1:V
        multiplication(i,j) = gKernel(i,j).*twoDDFT(i,j);
    end
end

magSpecImg = abs(multiplication);

% Take the inverse of the 2-D DFT.

inverseResult = ifft2(multiplication);

% Get the real part

realResult = real(inverseResult);

% Crop to orignal dimensions

croppedImage = realResult(1:h, 1:w);

% Multiply each location by (-1)^(x+y) again

GBNF = zeros(h);

for i=1:h
    for j=1:w
        GBNF(i,j) = croppedImage(i,j)*((-1)^(i+j));
    end
end

end
