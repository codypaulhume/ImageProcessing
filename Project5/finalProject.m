function finalProject(A,B)
% This function is the top level file for the final project for EE 5620.
% Calling the function with two parameters A and B for the visible image
% and the IR image respectively.
% The visible image will be manipulated by first cropping the image to
% match the IR image. Next, a bilinear interpolation function is used to
% resize the image to match the IR image dimensions. Next, a Gaussian high
% pass filter will capture the edges. Next, the result is added to the
% IR image and adjusted for better display by using a laplacian. Last, the
% image is scaled.

L = 256;

A = double(A);

% Capture size of IR image

B = double(B);
[h,w] = size(B);

% Crop the visible image to the match the IR image

ACropped = A(460:1045, 650:1440);

% Perform bilinear interpolation of the cropped image with the dimensions
% of the IR image

resized = new_bilin_int(ACropped, h, w);

% Perform a Gaussian high pass filter on the previous result to capture the
% edges of the clock.

hpf = ip_HPFG(resized, 20);

% Add the previous result to the IR image

hpfIR = hpf + B;

% Laplacian

laplac = ip_laplacian(hpfIR);

% Scaling final result

hpfIRScale = laplac;

minFinal = min(min(hpfIRScale));
hpfIRScale = hpfIRScale-minFinal; % shift
maxFinal = max(max(hpfIRScale));
if maxFinal~=0
    hpfIRScale = hpfIRScale*255/maxFinal; % compress or expand
end

% Display results

figure(1);
subplot(1,2,1), image(ACropped);
title("Visible Image Cropped");
axis ij
axis equal
axis tight
subplot(1,2,2), image(resized);
title("IR Image");
axis ij
axis equal
axis tight
colormap(gray(L))

figure(2);
image(hpf);
title("Gaussian High Pass Filter (GHPF)");
axis ij
axis equal
axis tight
colormap(gray(L))

figure(3);
image(hpfIR);
title("GHPF + IR Image Combined");
axis ij
axis equal
axis tight
colormap(gray(L))

figure(4);
image(hpfIRScale);
title("Final Image");
axis ij
axis equal
axis tight
colormap(gray(L))
end
