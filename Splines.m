%
%
% This script implements cubic polynomials for splines
% After some mathematical analysis, we get to the conclusion
% that this problem can be solved as a system of linear equations
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
    h = zeros(m-1,1);
    for i = 1:m-1
        h(i) = DATA(i+1,1) - DATA(i,1);
    end
       
    %Matrix of coefficients
    coeff = zeros(m-2);
    %Fill matrix of coefficients
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
    
    %Vector of constants
    con = zeros(m-2,1);
    %Fill vector of constants
    for i = 1:m-2
        con(i) = 6*((DATA(i+2,2)-DATA(i+1,2))/(h(i+1)) - (DATA(i+1,2)-DATA(i,2))/(h(i)));
    end
    
    % Now we have to calculate the values of the sigmas
    %Create and initialize with 0 vector sigma
    sigma = 0;
    sig = coeff\con;
    sigma = [sigma;sig;sigma]
    %fun = zeros(m,1);
    q = cell(m-1,1)
    for i = 1:m-1
        q{i,1} = @(x) (sigma(i)/6)*(((DATA(i+1,1)-x)^3)/h(i)-h(i)*((DATA(i+1,1)-x))) + (sigma(i+1)/6)*(((x-DATA(i,1))^3)/h(i)-h(i)*((x-DATA(i,1)))) + DATA(i,2)*((DATA(i+1,1)-x)/h(i))+ DATA(i+1,2)*((x-DATA(i,1))/h(i))
        
    end
    
else
    disp('ERROR: Matrix does not have 2 columns')
    return
end

