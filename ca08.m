% Assignment: MACM 316 Computing Assignment 8
% Title: Predicting the population of BC
% Author: Jerry Chen
% File name: ca08.m

clear all; close all;
% reading CSV
M = csvread('population.csv');
% chosen starting year
N = M(1,1)
% P of population values for the years N,N+1,...,2015
P = M(find(M==N):end,2);
dP = zeros(1,length(P)-1)';
tspan = [N 2040];
P0 = P(1);

for i = 1:length(dP)
    dP(i) = P(i+1) - P(i);
end

dP;

parfit = fit(P(1:end-1), dP, fittype('b*x-k*x^2'), 'start', [0,0]);

% the estimated values of b and k can now be obtained as follows
b_est = parfit.b;
k_est = parfit.k;

func = @(t,P) b_est*P - k_est*(P)^2;
[y p] = ode45(func, tspan, P0);

figure
% plotting the population output from ode45 from year N to 2040
plot(y,p)
hold on
% plotting the exact data values of the population from year N to 2015
plot(M(find(M==N):end,1),P,'.')
hold off

title('Population VS Year', 'fontsize', 12)
xlabel('Year', 'fontsize', 10)
ylabel('Population', 'fontsize', 10)