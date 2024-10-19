close all
clear
clc

syms t;

z = triangularPulse((t+3)/2) - triangularPulse((t-3)/2);
subplot(3,1,1);
fplot(z);

z1 = triangularPulse(t);
z2 = triangularPulse(-t);
% z1 = z2

subplot(3,1,2);
fplot(z1);
title('Segnale tri(t)');
xlabel('t');

subplot(3,1,3);
fplot(z2);
title('Segnale tri(-t)');
xlabel('t');
