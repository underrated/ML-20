clear all;

function result = cost(X, Y, theta)
    m = length(X);
    H = X * theta;
    result = (1/(2*m)) * sum((H-Y).^2);
endfunction

function result = delta(X, Y, theta, alpha)
    m = length(X);
    H = X * theta;
    D = H - Y;
    D = repmat(D, 1, 2);
    result = - alpha * (1/m) * sum(D.*X);
endfunction

function [result,hist, j_hist] = f_gd_one_var(X, Y, theta, alpha, iterations)
    theta_hist = zeros(iterations+1,2);
    jhist = zeros(iterations+1, 1);
    j_hist(1) = cost(X, Y, theta);
    for i = 1:iterations
        theta += (delta(X, Y, theta, alpha))';
        theta_hist(i+1,1) = theta(1);
        theta_hist(i+1,2) = theta(2);
        j_hist(i+1) = cost(X, Y, theta);
    endfor
    result = theta;
    hist = theta_hist;
endfunction

function plot_data_and_estimate(X, Y, theta)
    Xmin = min(X(:,2));
    Xmax = max(X(:,2));
    Xrange = Xmin:0.01:Xmax;
    Yrange = theta(1) + theta(2)*Xrange;
    hold on;
    plot(X(:,2), Y, 'rx');
    plot(Xrange, Yrange);
    hold off;
endfunction

function plot_cost_contour(X, Y)
    % Grid over which we will calculate J
    theta0_vals = linspace(-10, 10, 100);
    theta1_vals = linspace(-1, 4, 100);

    % initialize J_vals to a matrix of 0's
    J_vals = zeros(length(theta0_vals), length(theta1_vals));

    % Fill out J_vals
    for i = 1:length(theta0_vals)
        for j = 1:length(theta1_vals)
    	  t = [theta0_vals(i); theta1_vals(j)];    
    	  J_vals(i,j) = cost(X, Y, t);
        end
    end

    % Because of the way meshgrids work in the surf command, we need to 
    % transpose J_vals before calling surf, or else the axes will be flipped
    J_vals = J_vals';
    % Surface plot
    %figure;
    %surf(theta0_vals, theta1_vals, J_vals)
    %xlabel('\theta_0'); ylabel('\theta_1');

    % Contour plot
    figure;
    % Plot J_vals as 15 contours spaced logarithmically between 0.01 and 100
    contour(theta0_vals, theta1_vals, J_vals, logspace(-2, 3, 20))
    xlabel('\theta_0'); ylabel('\theta_1');
    hold on;
endfunction

data = load('../data_sets/ex1data1.txt');
m = length(data);
X = [ ones(m,1) data(:,1) ]; 
Y = data(:,2);

theta = zeros(2,1);
iterations = 1500;
alpha = 0.01;

[theta, hist, j_hist] = f_gd_one_var(X,Y,theta,alpha,iterations);
%plot_data_and_estimate(X,Y,theta);
plot_cost_contour(X,Y);
plot(theta(1), theta(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
plot(hist(:,1), hist(:,2), 'r');

figure;
plot(j_hist);



