clear all
clc
K = load ('C:\Users\sebas\OneDrive\Documenti\MATLAB\Vision Algorithm\exercise2\Exercise 2 - PnP\data\K.txt');
p_W_corners = load ('C:\Users\sebas\OneDrive\Documenti\MATLAB\Vision Algorithm\exercise2\Exercise 2 - PnP\data\p_W_corners.txt');
detected_corners = load ('C:\Users\sebas\OneDrive\Documenti\MATLAB\Vision Algorithm\exercise2\Exercise 2 - PnP\data\detected_corners.txt');

%% image 1
%first line (u1,v1,...,u12,v12)
first_line=detected_corners(1,:);
dim=size(first_line);
lenght=dim(1,2);
k=1;
for i=0:2:lenght-2
    p(k,1)=first_line(1,1+i);
    p(k,2)=first_line(1,2+i);
    k=k+1;
end

num_points=lenght/2;
%%
%matrix 12x1
M=estimatePoseDLT(p,p_W_corners,K);
%matrix 3x4
M=[transpose(M(1:4,1));
    transpose(M(5:8,1));
    transpose(M(9:12,1))];
if M(3,4)<0
    M=M*(-1);
end
%extract R & t
notR=M(1:3,1:3);
t=M(1:3,4);
[U,S,V]=svd(notR);
%proper R
R=U*eye(3)*V;
alpha=norm(R)/norm(notR);
%proper M
M=[alpha*notR,alpha*t];

%%
%reproject 3D points in current image
u=zeros(num_points,1);
v=zeros(num_points,1);
for i=1:1:num_points
    p_image=reprojectsPoints([p_W_corners(i,1:3),1],M,K);
    u(i,1)=p_image(1,1)/p_image(3,1);
    v(i,1)=p_image(2,1)/p_image(3,1);
end
% superimpose project corners to undistorted image
figure;
imshow('C:\Users\sebas\OneDrive\Documenti\MATLAB\Vision Algorithm\exercise2\Exercise 2 - PnP\data\images_undistorted\img_0001.jpg')
hold on;
%2D points from detected_corners
for i=1:1:num_points
    scatter(p(i,1),p(i,2),'red','filled');
end
%reprojected points
for i=1:1:num_points
    scatter(u(i,1),v(i,1),'blue','d');
end
hold off;