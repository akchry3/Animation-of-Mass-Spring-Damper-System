
function h_plot = func_plot_spring(p_a, p_b, l_w, l_h, num_s)

%
% Drawing Spring
% 
% h_plot = func_plot_spring(p_a, p_b, l_w, l_h, num_s)
% 
% Inputs:
%     p_a: Start position
%     p_b: End position
%     l_w: Width
%     l_h: Length of Both sides (Hudle parts)
%     num_s: Number of turn
% Oputput: Hundle of Plot


%% Length & Direction angle
p_ab = p_b - p_a;
l_ab = norm(p_ab);
ang_ab = atan2(p_ab(2), p_ab(1));


%% Lengths for Spring part

l_s_total = l_ab - 2*l_h;   % Length of Spring (Total)
l_s_one = l_s_total/num_s;  % Length of Spring (per One turn)

% Checking whether Lenght of Spring part is positive or not
if l_s_total <= 0
    error(['The length for the handle parts is greater than the total length !' ...
        ' The length 2*l_h must be smaller than the distance between p_a and p_b.']);
end


%% Creating Basic data for drawing Spring

p_s = [0;0];        % Start point
p_h_s = [l_h;0];    % Position of Hundle (Side of Start)

% Data of Turing points (Upper & Lower Sides)
p_u = zeros(2, num_s);
p_l = zeros(2, num_s);
p_ul_x_org = 0:l_s_one:(num_s-1)*l_s_one;
p_u(1, :) = p_ul_x_org + l_s_one/4 + l_h;
p_l(1, :) = p_ul_x_org + 3*l_s_one/4 + l_h;
p_u(2, :) = l_w/2*ones(1,num_s);
p_l(2, :) = -l_w/2*ones(1,num_s);

p_h_e = [l_ab-l_h;0];   % Position of Hundle (Side of End)
p_e = [l_ab;0];         % End point

% Total Basic data
p_s_all_org = zeros(2,4+2*num_s);
idx_u = (1:2:(2*num_s-1)) + 2;
idx_l = (2:2:(2*num_s)) + 2;
p_s_all_org(:, 1) = p_s;
p_s_all_org(:, 2) = p_h_s;
p_s_all_org(:, idx_u) = p_u;
p_s_all_org(:, idx_l) = p_l;
p_s_all_org(:, end-1) = p_h_e;
p_s_all_org(:, end) = p_e;


%% Considering Absolute coordinates of Damper

% Rotation matrix of Spring direction
R_ab = [cos(ang_ab), -sin(ang_ab);sin(ang_ab), cos(ang_ab)];

% Data for drawing Spring
size_tmp = size(p_s_all_org);
p_s_all = p_a*ones(1, size_tmp(2)) + R_ab*p_s_all_org;


%% Plot
h_plot = plot(p_s_all(1,:), p_s_all(2,:));

end


