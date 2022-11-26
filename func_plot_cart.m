
function h_plot = func_plot_cart(p_cart, l_w, l_h)

% 
% Drawing Cart
% 
% h_plot = func_plot_cart(p_cart, l_w, l_h)
% 
% Inputs:
%     p_cart: Position of Cart
%     l_w: Width of Cart
%     l_h: Hieght of Cart
% Output: Hundle of Plot


%% Data for Drawing Box
p_box_org = zeros(2,5);
p_box_org(:,1) = [l_w/2;-l_h/2];
p_box_org(:,2) = p_box_org(:,1) + [-l_w;0];
p_box_org(:,3) = p_box_org(:,2) + [0;l_h];
p_box_org(:,4) = p_box_org(:,3) + [l_w;0];
p_box_org(:,5) = p_box_org(:,1);


%% Data for drawing Wheel
r_w = l_w/8;
th = 0:-pi/20:-pi;
p_wheel_org = r_w*[cos(th);sin(th)];
p_wheel_r = p_wheel_org + [2*r_w;-l_h/2];
p_wheel_l = p_wheel_org + [-2*r_w;-l_h/2];


%% Data for drawing Cart(Box & Wheel)
p_box = [p_box_org, p_wheel_r, p_wheel_l] + p_cart;


%% Plot
h_plot = plot(p_box(1,:), p_box(2,:));

end


