function Part4Homework01()
% Loads lena and shows image normal, 'flipped', and upside down
% These websites were used for reference on how to create re-order the two
% matrixs' values
% Call the function above to run the code
% Referenced data from www.geeksforgeeks.org

load('lena.mat', 'A512');

L=256;
L1=L-1;
A512=double(A512); % just in case
[X, Y]=size(A512);
% switch X and Y for proper image display
% (0,0) is in UL corner with X rows and Y columns
figure(1);
image(0:Y-1,0:X-1,A512)
axis ij
axis equal
axis tight
colormap(gray(L))

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flip the image left to right
% For each pixel location, store the opposite value
% It is being withheld within the temp variable
% Then decrement inc to move to the next pixel

img = A512;
[X, Y]= size(img);
figure(2);
for i = 1 : X
    inc = Y; 
    for j = 1 : Y
        if j < Y/2 
            temp = img(i, j);
            img(i, j) = img(i, inc);
            img(i, inc) = temp;
            inc = inc - 1;
        end
    end
end
image(img);
axis ij
axis equal
axis tight
colormap(gray(L))

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Flip the image up and down
% For each pixel location, store the opposite value, but vertically
% It is being withheld within the temp variable
% Then decrement inc to move to next pixel

img2 = A512;
[X, Y]= size(img2);
figure(3);
inc = X;
for i = 1 : X 
    for j = 1 : Y
        if i < X/2 
            temp = img2(i, j);
            img2(i, j) = img2(inc, j);
            img2(inc, j) = temp;
             
        end
    end
    inc = inc - 1;
end
image(img2);
axis ij
axis equal
axis tight
colormap(gray(L))
