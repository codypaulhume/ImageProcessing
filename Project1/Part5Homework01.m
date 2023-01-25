function Part5Homework01()
% Creates verticles bars alternating black and white with adjustments to
% the frequency
% Call the function above to run the code
matrixSize = 256;
F = zeros(matrixSize); %Matrix of 256x256 zeros
numberOfBars = 2.^4;
iterations = numberOfBars/2;

%For each iteration, the vertical distance is set,
for i= 1:iterations
    F(1:matrixSize, ((i*matrixSize/numberOfBars) + ...
        ((i-1)*matrixSize/numberOfBars)):(2*i*matrixSize/numberOfBars))...
        = 255;
end
i =0;
figure(1)
image([0 255], [0 255], F);
axis ij  % put 0,0 in UL corner
axis equal
axis tight
title('Vertical Black and White Bars - 2^4');
colormap(gray(256)) % a 256 level (8-bit) grayscale

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(2)
numberOfBars = 2.^2;
iterations = numberOfBars/2;

%For each iteration, the vertical distance is set,
for i= 1:iterations
    G(1:matrixSize, ((i*matrixSize/numberOfBars) + ...
        ((i-1)*matrixSize/numberOfBars)):(2*i*matrixSize/numberOfBars))...
        = 255;
end
i = 0;
image([0 255], [0 255], G);
axis ij  % put 0,0 in UL corner
axis equal
axis tight
title('Vertical Black and White Bars - 2^2');
colormap(gray(256)) % a 256 level (8-bit) grayscale

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(3)
numberOfBars = 2;
iterations = numberOfBars/2;

%For each iteration, the vertical distance is set,
for i= 1:iterations
    H(1:matrixSize, ((i*matrixSize/numberOfBars) + ...
        ((i-1)*matrixSize/numberOfBars)):(2*i*matrixSize/numberOfBars))...
        = 255;
end
image([0 255], [0 255], H);
axis ij  % put 0,0 in UL corner
axis equal
axis tight
title('Vertical Black and White Bars - 2^1');
colormap(gray(256)) % a 256 level (8-bit) grayscale

