close all
clear
clc

syms t;
% Creare tri e rect
tri = triangularPulse(t+2);
rect = rectangularPulse(1/4*(t-5));

% Grafico della sinusoide originale
fplot(tri, [-10,10]);
hold on
fplot(rect);
title('Tri + Rect');
xlabel('Tempo');
grid on
