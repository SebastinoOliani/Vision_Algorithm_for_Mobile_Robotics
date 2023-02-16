clear all
clc

% load text files
load K.txt;
load D.txt;
load poses.txt;

% read image into Matlab
img=imread("C:\Users\sebas\OneDrive\Documenti\MATLAB\Vision Algorithm\Exercise 1 - Augmented Reality Wireframe Cube\data\images\img_0001.jpg");
% convert image to grayscale
img_gray=rgb2gray(img);
% Create a matrix containing the 3D positions of all the checkerboard corners
x=0:0.04:0.32;
y=0:0.04:0.2;
z=0;
[X,Y,Z]=meshgrid(x,y,z);
[R,t] = poseVectorToTransformationMatrix(poses);
for i=1:1:6
    for j=1:1:9
        [u(i,j),v(i,j)]=projectPointsDistorted([X(i,j);Y(i,j);0;1],K,R,t,D);
    end
end
%% superimpose project corners to undistorted image
figure;
imshow('C:\Users\sebas\OneDrive\Documenti\MATLAB\Vision Algorithm\Exercise 1 - Augmented Reality Wireframe Cube\data\images\img_0001.jpg')
hold on;
scatter(u,v,'red','filled');
hold off;

%% undistorting an image
% compute pixel in normalized coord
% undistort
% come back form normalized coord