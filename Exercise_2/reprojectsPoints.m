function [p_reprojected] = reprojectsPoints(P,M,K)
p_reprojected=zeros(3,1);
p_reprojected=K*M*transpose(P);
end
    


