%function ip_ex01()
% This is an m-file to generate and display some simple images
% Copyright (c) 2005-20014 Cameron H. G. Wright
close all
x=0:9; y=x;  % useful for mesh plotting purposes
A=zeros(10);  % preallocate the 10x10 matrix, filled with zeros
A(3:5,7:9)=255; % make a block of 255 in the UR corner
figure(1)
mesh(x,y,A)
axis ij  % put 0,0 in UL corner
%axis equal
axis tight
figure(2)
image([0 9],[0 9],A) % display a matrix as an image
axis ij  % put 0,0 in UL corner
axis equal
axis tight
colormap(gray(256)) % a 256 level (8-bit) grayscale
B=zeros(256);
x=0:255; y=x;
v=10;  % spatial frequency in the y direction
% Note: MATLAB uses (row, column) notation for (x, y)
for i=1:256
    for j=1:256
        B(i,j)=sin(j/v);  % ranges from -1 to +1
    end
end
% now shift and expand so sinusoid ranges from 0 to 255
B=B+1;  % move up range to be from 0 to 2
B=127.5*B;  % now ranges from 0 to 255
figure(3)
mesh(x,y,B) % using the default colormap
axis ij
axis([0 255 0 255 0 255]);  % tighten axes around data
figure(4)
image([0 255],[0 255],B) % display a matrix as an image
axis ij  % put 0,0 in UL corner
axis equal
axis tight
colormap(gray(256)) % a 256 valued (8-bit) grayscale
figure(1)  % start by showing the first figure
