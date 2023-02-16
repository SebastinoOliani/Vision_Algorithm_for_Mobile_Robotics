function [u,v] = projectPoints(p,K,R,t)
M=K*[R,t]*p;
u=M(1,1)/M(3,1);
v=M(2,1)/M(3,1);
end

