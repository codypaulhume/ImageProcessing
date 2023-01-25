function topLevelP4(A, B)
% This is the top level function that runs everything needed for project
% four. The two arguments are A and B for the test image and noisy Lena
% image respectively.

L = 256;

% Using "iptest01" as the test image, a gaussian low pass filter is
% applied to it and imaged with a D0 of 15

LPFTestresult = ip_LPFG(A, 15);

% Using "iptest01" as the test image, a gaussian high pass filter is
% applied to it and imaged with a D0 of 30

HPFTestresult = ip_HPFG(A, 30);

figure(1);
subplot(1,2,1), image(LPFTestresult);
title("LPFG Image Result");
axis ij
axis equal
axis tight
subplot(1,2,2), image(HPFTestresult);
title("HPFG Image Result");
axis ij
axis equal
axis tight
colormap(gray(L))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Project 4 Lena Code Below
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Using the gaussian notch reject filter with a D0 value of 130, u0 of 155
% and a v0 of 100. These are distances from the center.
% The value of GBNF is the result of the filter, twoDmagSpec is used
% to display the 2-D and the 3-D magnitude spectrum of the noisy Lena
% image. magSpecFilter is used for displaying the filter and magSpecImg is
% the magnitude spectrum of the filtered image. 

[GBNF, twoDmagSpec, magSpecFilter, magSpecImg] = ip_GBNF(B, 130, 155, 100);

% Image original noisy Lena

figure(2);
image(B);
title("Orginal Noisy Lena");
axis ij
axis equal
axis tight
colormap(gray(L))

% Image the 2-D magnitude spectrum of the noisy image and the 3-D mesh plot
% magnitude spectrum. twoDmagSpec is used to show the 2-D magnitude
% spectrum as well as the 3-D.

% Scaling twoDmagSpec
minTD=min(min(twoDmagSpec));
twoDmagSpec=twoDmagSpec-minTD; % shift
maxTD=max(max(twoDmagSpec));
if maxTD~=0
    twoDmagSpec=twoDmagSpec*255/maxTD; % compress or expand
end

figure(3)
subplot(1,2,1), image(twoDmagSpec)
title("2-D Magnitude Spectrum of Noisy Lena");
axis ij
axis equal
axis tight
subplot(1,2,2), mesh(twoDmagSpec);
title("3-D Mesh Magnitude Spectrum of Noisy Lena");
axis ij
axis equal
axis tight
colormap(gray(L))

% Image the filter function as a 2-D image
% Scaling filter for display

minSF=min(min(magSpecFilter));
magSpecFilter=magSpecFilter-minSF; % shift
maxSF=max(max(magSpecFilter));
if maxSF~=0
    magSpecFilter=magSpecFilter*255/maxSF; % compress or expand
end

figure(4);
image(magSpecFilter);
title("Filter Magnitude Spectrum");
axis ij
axis equal
axis tight
colormap(gray(L))

% Image a 2-D magnitude spectrum of the newly filtered image
% Scaling result for display

minR=min(min(magSpecImg));
magSpecImg=magSpecImg-minR; % shift
maxR=max(max(magSpecImg));
if maxR~=0
    magSpecImg=magSpecImg*255/maxR; % compress or expand
end

figure(5);
image(magSpecImg);
title("Magnitude of Filtered Image");
axis ij
axis equal
axis tight
colormap(gray(L))

minF=min(min(GBNF));
GBNF=GBNF-minF; % shift
maxF=max(max(GBNF));
if maxF~=0
    GBNF=GBNF*255/maxF; % compress or expand
end

figure(6);
image(GBNF);
title("Final Image Result");
axis ij
axis equal
axis tight
colormap(gray(L))

end