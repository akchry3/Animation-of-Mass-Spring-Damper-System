
function [x_res, y_res] = func_resample_v02(x_org, y_org, width_res)

% 
% Resampling of Data ver. 02
% 
% [x_res, y_res] = func_resample_v02(x_org, y_org, width_res)
% 
% Inputs:
%     x_org: Input of Original data (Only Type of Vector)
%     y_org: Output of Original data (Matrix OK) 
%     width_res: Sampling time
% Outputs:
%     x_res: Input of Resampled data
%     y_res: Output of Resampled data 


%% Checking Basic properties of Data

% Sizes of Data
size_x_org = size(x_org);
size_y_org = size(y_org);

% Checking Style of Data: Column of Row (flag_size = 1: Column; 2: Row)
[~, flag_size] = min(size_x_org);


%% Resamling Input data
x_start = x_org(1);
x_end = x_org(end);
x_res = x_start:width_res:x_end;


%% Preliminary for Resampling Output data

if flag_size == 2 % Case: Row
    size_res = [size_y_org(2), floor((x_end-x_start)/width_res)+1];
    x_org = x_org';
    y_org = y_org';
else % Case: Column
    size_res = [size_y_org(1), floor((x_end-x_start)/width_res)+1];
end

% Setting Variable for Resampled Oputput data
y_res  = zeros(size_res);


%% Resamling Output data

for i = 1:size_res(2)
    [~, idx_tmp] = min(abs(x_org - x_res(i)));
    %
    if x_res(i) > x_org(idx_tmp)    % t_res(i) in [t_org(idx_tmp), t_org(idx_tmp+1)]
        a = x_org(idx_tmp);
        b = x_org(idx_tmp+1);
        c = x_res(i);
        fa = y_org(:,idx_tmp);
        fb = y_org(:,idx_tmp+1);
        fc = fa + (c-a)/(b-a)*(fb-fa);
    elseif x_res(i) < x_org(idx_tmp)    % t_res(i) in [t_org(idx_tmp-1), t_org(idx_tmp)]
        a = x_org(idx_tmp-1);
        b = x_org(idx_tmp);
        c = x_res(i);
        fa = y_org(:,idx_tmp-1);
        fb = y_org(:,idx_tmp);
        fc = fa + (c-a)/(b-a)*(fb-fa);
    elseif x_res(i) == x_org(idx_tmp)
        fc = y_org(:,idx_tmp);
    end
    %
    y_res(:,i) = fc;
end


%% Matching Style of Data
if flag_size == 2 % Case: Row
    x_res = x_res';
    y_res = y_res';
end

end








