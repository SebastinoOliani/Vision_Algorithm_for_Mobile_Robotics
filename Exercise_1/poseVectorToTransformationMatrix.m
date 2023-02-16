function [R,t] = poseVectorToTransformationMatrix(poses)
w=[poses(1,1);poses(1,2);poses(1,3)];
t=[poses(1,4);poses(1,5);poses(1,6)];
k=w/norm(w);
theta=norm(w);
k_skew=[0,-k(3,1),k(2,1);
    k(3,1),0,-k(1,1);
    -k(2,1),k(1,1),0];
R=eye(3)+sin(theta)*k_skew+(1-cos(theta))*k_skew^2;
end

