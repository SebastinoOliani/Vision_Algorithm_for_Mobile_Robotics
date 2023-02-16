function [projected_points] = projectPoints2(points_3d, K)
% Projects 3d points to the image plane (3xN), given the camera matrix (3x3) and
% distortion coefficients (4x1).

% get image coordinates
projected_points = K * points_3d;
projected_points = projected_points  ./ projected_points (3,:);

end

