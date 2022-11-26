
function [] = set_plot_style_v03(size_text, size_axes, size_line)

% 
% Note: Original function is made by Dr. Ichiro Maruta
% SET_PLOT_STYLE (Change Settings of Plots at Once)
% 
% set_plot_style_v03(size_text, size_axes, size_line)
% 
% size_text: Font size of Labels & Annotations
% size_axes: Font size of Axes
% size_line: Linewidth of Plots


%% Change Settings of Plots

set(findobj('type','axes'),'fontname','times'); 
set(findobj('type','axes'),'fontsize',size_axes); 
set(findobj('type','axes'),'fontweight','demi'); 
set(findobj('type','axes'),'box','on'); 
set(findobj('type','axes'),'xgrid','on'); 
set(findobj('type','axes'),'ygrid','on'); 
set(findobj('type','axes'),'linewidth',1.5); 
set(findobj('type','line'),'linewidth',size_line); 

% set(findobj('string','text'),'fontsize',12); 
% % get(gca,'ylabel')
% set(get(gca,'ylabel'),'fontsize',12); 

% tmp = findall(gca,'type','text')
tmp  = findobj('type','axes');
tmp = findall(tmp,'type','text');
set(tmp,'fontsize',size_text)
set(tmp,'fontweight','demi')
% set(tmp,'fontname','MS UI Gothic')
set(tmp,'fontname','times')

end




