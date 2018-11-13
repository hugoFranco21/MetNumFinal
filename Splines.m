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
if m < 2
    disp(' To use splines you need at least 2 points in the plane ');
    return
end
if n == 2
    %Order the data
    DATA = sortrows(DATA);
    
    
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
    sigma = [sigma;sig;sigma];
    %fun = zeros(m,1);
    q = cell(m-1,1);
    for i = 1:m-1
        q{i,1} = @(x) (sigma(i)/6)*(((DATA(i+1,1)-x).^3)/h(i)-h(i)*((DATA(i+1,1)-x))) + (sigma(i+1)/6)*(((x-DATA(i,1)).^3)/h(i)-h(i)*((x-DATA(i,1)))) + DATA(i,2)*((DATA(i+1,1)-x)/h(i))+ DATA(i+1,2)*((x-DATA(i,1))/h(i));
        
    end
    opc = 1;
    
    while opc == 1
        con = 1;
        ind = 2;
        xu = input(' Write x value in which you want to see the value of the approximation: ');
        %Check the polynomial that xu has to use
        while xu > DATA(ind,1)
            con = con + 1;
            ind = ind + 1;
        end
        yu = q{con}(xu);
        plot(xu,yu,'o')
        hold on
        % Graph the spline
        for i = 1:m-1
            x1 = linspace(DATA(i,1),DATA(i+1,1));
            y1 = q{i}(x1);
            % Graph of the points
            plot(DATA(:,1),DATA(:,2), 'x')
            hold on
            plot(x1,y1,'m')
            hold on
        end
        opc = input(' Do you want another aproximation? (1 for Yes, 0 for No) ');
    end
else
    disp('ERROR: Matrix does not have 2 columns')
    return
end

