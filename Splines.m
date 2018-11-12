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
    
    % Calculate and fill the vector of increments
    h = zeros(m-1,1)
    for i = 1:m-1
        h(i) = DATA(i+1,1) - DATA(i,1)
    end
    
    %Create and initialize with 0 vector sigma
    sigma0 = 0;
    sigmaM = 0;
    sigma = zeros(m-2,1);
    
    %Matrix of coefficients
    coeff = zeros(m-2);
    for i = 1:m-2
        for j = 1:m-2
            if i == j
                coeff(i,j) = 2*(h(i)+h(i+1));
            end
            if (i - j) == 1
                coeff(i,j) = h(j+1);
            end
            if (j - i) == 1
                coeff(i,j) = h(i+1);
            end
        end
    end
    
else
    disp('ERROR: Matrix does not have 2 columns')
    return
end