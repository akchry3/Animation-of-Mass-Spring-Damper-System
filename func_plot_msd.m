
function h_plot = func_plot_msd(p_cart_x, param_plot)

% 
% Drawing Mass-Spring-Damper System
% 
% h_plot = func_plot_msd(p_cart_x, param_plot)
% 
% Inputs:
%     p_cart_x: Coordinate of Cart
%     param_plot: Struct varable for drawing Cart
%         l_equi    : Equilibrium of Length of Spring & Damper
%         l_w_c     : Width of Cart
%         l_h_c     : Height of Cart
%         l_hdl_s   : Lengths of Hundle parts of Spring
%         num_s     : Number of turn of Spring
%         l_box_d   : Width of Dashpot part of Damper
%         p_wg_org  : Reference position of Wall & Ground
% Oputput: Hundle of Plot


%% Reading Parameters for drawing
l_equi = param_plot.l_equi;
l_w_c = param_plot.l_w_c;
l_h_c = param_plot.l_h_c;
l_hdl_s = param_plot.l_hdl_s;
num_s = param_plot.num_s;
l_box_d = param_plot.l_box_d;
p_wg_org = param_plot.p_wg_org;


%% Creating Data for drawing

% Cart
r_wheel = l_w_c/8;
p_cart = zeros(2,1);
p_cart(1) = p_cart_x;
p_cart(2) = l_h_c/2 + r_wheel;

% Basic length for drawing Spring & Damper
l_h_c_base = l_h_c/5;

% Spring
p_a_s = [0;4*l_h_c_base + r_wheel];
p_b_s = [p_cart(1) - l_w_c/2;p_a_s(2)];
l_w_s = 2*l_h_c_base;

% Damper
p_a_d = [0;l_h_c_base + r_wheel];
p_b_d = [p_b_s(1);p_a_d(2)];
l_w_d = 2*l_h_c_base;
l_ab_org = l_equi;

% Considering Position of Wall & Ground (as Reference)
p_cart = p_cart + p_wg_org;
p_a_s = p_a_s + p_wg_org;
p_b_s = p_b_s + p_wg_org;
p_a_d = p_a_d + p_wg_org;
p_b_d = p_b_d + p_wg_org;


%% Plots
hold on
h_plot_c = func_plot_cart(p_cart, l_w_c, l_h_c);
h_plot_s = func_plot_spring(p_a_s, p_b_s, l_w_s, l_hdl_s, num_s);
h_plot_d = func_plot_damper(p_a_d, p_b_d, l_w_d, l_box_d, l_ab_org);
hold off


%% Output of Set of Hundles of Plots
h_plot = [h_plot_c;h_plot_s;h_plot_d];


end
