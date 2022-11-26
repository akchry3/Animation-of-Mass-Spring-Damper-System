
% Creating animation of a mass-spring-damper system

clear;
close all;


%% Simulation of a mass-spring-damter system

% Paramters
m = 1;
k = 50;
wn = sqrt(k/m);
zeta = 0.05;
c = 2*zeta*wn*m;

% Input
u = 0;

% State equation
fcn_x_dot = @(t,x)[x(2);(-c*x(2) - k*x(1) + u)/m];

% Initial values
x_ini = [0.5;0];

% Time duration for Simulation
Tspan = [0, 10];

% Solving State equation by ODE45
opts = odeset('RelTol', 1e-3, 'AbsTol', 1e-3, 'MaxStep', 1e-2);
[tout, x] = ode45(@(t,x)fcn_x_dot(t,x), Tspan, x_ini, opts);

% Plot of Time response
figure('WindowStyle','docked', 'Name', 'Cart Response');
ylabel_tmp = {'x [m]', 'x dot [m/s]'};
for i = 1:2
    subplot(2,1,i)
    plot(tout, x(:,i))
    ylabel(ylabel_tmp{i})
end
xlabel('time [sec]')

set_plot_style_v03(16, 16, 2)


%% Setting Parameters for drawing

% Length of Equilibrium
l_equi = 2;

% Cart
l_w_c = 0.8;    % Width
l_h_c = 0.6;    % Height

% Spring
l_hdl_s = l_equi/10;    % Length of Sides of Spring
num_s = 5;              % Number of turns

% Damper
l_box_d = l_equi/4;     % Width of Dashpot

% Wall & Ground
l_wg_xy = [l_equi + l_w_c;1.5*l_h_c];
p_wg_org = [0;0];
% p_wg_org = [0.2;0.2];

% Struct variable for drawing
param_plot_msd.l_equi = l_equi;
param_plot_msd.l_w_c = l_w_c;
param_plot_msd.l_h_c = l_h_c;
param_plot_msd.l_hdl_s = l_hdl_s;
param_plot_msd.num_s = num_s;
param_plot_msd.l_box_d = l_box_d;
param_plot_msd.p_wg_org = p_wg_org;

% Data for drawing Wall & Ground
p_wg = zeros(2,3);
p_wg(:,1) = [0;l_wg_xy(2)];
p_wg(:,2) = [0;0];
p_wg(:,3) = [l_wg_xy(1);0];
p_wg = p_wg + p_wg_org;


%% Plot: Initial situation
figure('WindowStyle','docked', 'Name', 'Drawing');
plot(p_wg(1,:), p_wg(2,:))
hold on
h_plot_msd = func_plot_msd(l_equi, param_plot_msd);
axis equal

for i = 1:numel(h_plot_msd)
    h_plot_msd(i).LineWidth = 2;
end

set_plot_style_v03(16, 16, 2)


%% Creating Animation

close all;

% Resampling for Animation
fs_ani = 20;    % Sampling rate
[tout_ani, p_cart_x_ani] = func_resample_v02(tout, x(:,1), 1/fs_ani);   % Resampling with Sampling rate
num_frame_ani = numel(tout_ani);    % Number of Data in Animation

% Struct variable for Making a movie file
Mov(num_frame_ani) = struct('cdata',[],'colormap',[]);

% Ranges of Plot
range_x = [-0.25, 3];
range_y = [-0.25, 1];

% Plots at All Time steps
figure;
for i = 1:num_frame_ani

    p_cart_x = l_equi + p_cart_x_ani(i);

    h_plot_ref = plot(l_equi*[1, 1], range_y, '--', 'LineWidth', 2);
    hold on
    h_plot_wg  = plot(p_wg(1,:), p_wg(2,:), 'LineWidth', 2);
    h_plot_msd = func_plot_msd(p_cart_x, param_plot_msd);
    hold off

    exp_p_cart = exp(-10*abs(p_cart_x_ani(i))/l_equi);
    cmap_tmp = [1-exp_p_cart, 0, exp_p_cart];

    h_plot_wg.Color = h_plot_ref.Color;
    h_plot_msd(1).Color = h_plot_ref.Color;
    h_plot_msd(2).Color = cmap_tmp;
    h_plot_msd(3).Color = cmap_tmp;

    for j = 1:numel(h_plot_msd)
        h_plot_msd(j).LineWidth = 2;
    end

    grid on
    axis equal

    xlim(range_x)
    ylim(range_y)

    drawnow;
    Mov(i) = getframe(gcf);
    pause(0);

end

% Setting Parameters for Creating a movie file
name_movie = 'test';
vidObj = VideoWriter([name_movie, '.avi']);
vidObj.FrameRate = fs_ani;

% Creating a movie file
open(vidObj)
for i = 1:num_frame_ani
    writeVideo(vidObj , Mov(i).cdata);
end
close(vidObj)


