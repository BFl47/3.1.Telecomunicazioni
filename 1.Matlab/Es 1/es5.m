close all
clear
clc

% Es 5
% Prendere un filtro con risposta impulsiva diversa da 0 (e pari a 1) tra 1 e 2 secondi.
% 1. Calcolare l’uscita del filtro quando in ingresso c’è x(t)
% 2. Fare il grafico di x(t), h(t) e y(t)

% y(t) = x(t) * h(t)
% h(t) = delta * filtro

% x(t)
A = 5; % Ampiezza
phi = 1; % Fase
T = 2; % Periodo T
t = 0:0.001:2*T; % Intervallo di tempo da 0 a 2*pi con passo 0.05
x = A * cos(2*pi*t/T + phi);

plot(t, x); hold on;

filtro = rectangularPulse(t - 1.5);   
h = ones([1 2]);

plot(h); hold on;

y = conv(x, h, 'same');
plot(t, y);

xlim([0 4]);
ylim([-11 11]);

legend('x(t)','h(t)','y(t)')

