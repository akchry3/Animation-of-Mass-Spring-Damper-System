
function h_plot = func_plot_damper(p_a, p_b, l_w, l_box, l_ab_org)

% 
% Drawing Damper
% 
% h_plot = func_plot_damper(p_a, p_b, l_w, l_box, l_ab_org)
% 
% Inputs:
%     p_a: Start position
%     p_b: End position
%     l_w: Width
%     l_ab_org: Length of Equilibrium
% Oputput: Hundle of Plot


%% Length & Direction angle
p_ab = p_b - p_a;
l_ab = norm(p_ab);
ang_ab = atan2(p_ab(2), p_ab(1));


%% Creating Basic data for drawing Damper

% Creating Horizontal position
dis_l_ab = l_ab - l_ab_org;
rate_cover = -2*abs(dis_l_ab)/l_ab_org;
p_cover_x = l_ab/2 - sign(dis_l_ab)*l_box/2*(1 - exp(rate_cover));

% Start point
p_s = [0;0];

% Position of Cover
p_h_s = [p_cover_x;0];

% Data for drawing Cover
p_cover = zeros(2,2);
p_cover(:,1) = [p_cover_x;-l_w/2];
p_cover(:,2) = [p_cover_x;l_w/2];

% Data for drawing Dashpot
p_box = zeros(2,4);
p_box(:,1) = [l_ab/2 - l_box/2;l_w/2];
p_box(:,2) = p_box(:,1) + [l_box;0];
p_box(:,3) = p_box(:,2) + [0;-l_w];
p_box(:,4) = p_box(:,3) + [-l_box;0];

% End point of Dashpot
p_h_e = [l_ab/2 + l_box/2;0];

% End point
p_e = [l_ab;0];

% Total Basic data
p_d_all_org = zeros(2,11);
p_d_all_org(:, 1) = p_s;
p_d_all_org(:, 2) = p_h_s;
p_d_all_org(:, 3:4) = p_cover;
p_d_all_org(:, 5:6) = p_box(:,1:2);
p_d_all_org(:, 7:8) = [p_h_e, p_e];
p_d_all_org(:, 9) = p_h_e;
p_d_all_org(:, 10:11) = p_box(:,3:4);


%% Considering Absolute coordinates of Damper

% Rotation matrix of Damper direction
R_ab = [cos(ang_ab), -sin(ang_ab); sin(ang_ab), cos(ang_ab)];

% Data for drawing Damper
size_tmp = size(p_d_all_org);
p_d_all = p_a*ones(1, size_tmp(2)) + R_ab*p_d_all_org;


%% Plot
h_plot = plot(p_d_all(1,:), p_d_all(2,:));

end


