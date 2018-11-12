%
%
% This script implements cubic polynomials for splines
%
% Input:
% -- Matrix of points
%
% Output:
% -- Graph
%

clc
clear all
close all

% Ask for data
DATA = input('Give me the data points as a 2 column matrix ');
[m,n] = size(DATA);
if n == 2
    %Order the data
    DATA = sortrows(DATA);
    % Graph of the points
    plot(DATA(:,1),DATA(:,2), 'o')
    hold on
    % Graph of the interpolation
    plot(DATA(:,1),DATA(:,2))
    hold on
    
    x = input(' Where do you need the estimation? ');
    if(x > max(DATA(:,1)) || x < min(DATA(:,1)))
        disp(' ERROR: Sorry, we can not make an extrapolation')
        return
    else
        pos = sum(x>DATA(:,1));
        x0 = DATA(pos,1);
        y0 = DATA(pos,2);
        x1 = DATA(pos+1,1);
        y1 = DATA(pos+1,2);
        
        y = y0 +((y1-y0)/(x1-x0))*(x-x0)
        plot(x,y,'*r')
        hold on
    end
    
else
    disp('ERROR: Matrix does not have 2 columns')
    return
end