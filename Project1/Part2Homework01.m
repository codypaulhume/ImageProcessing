function Part2Homework01()
% Store the sin values from 1 to 256 in B and divide by frequency to change
% the number of bars
% Call the function above to run the code

freq = 5;
for i=1:256
    for j=1:256
        B(i,j)=sin(j/freq);  % ranges from -1 to +1
    end
end
% now shift and expand so sinusoid ranges from 0 to 255
B=B+1;  % move up range to be from 0 to 2
B=127.5*B;  % now ranges from 0 to 255
image([0 255],[0 255],B) % display a matrix as an image
axis ij  % put 0,0 in UL corner
title('16 Bars');
colormap(gray(256)) % a 256 valued (8-bit) grayscale