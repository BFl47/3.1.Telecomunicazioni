close all
clear
clc

% Triangolo originale
syms x;
triangolo = triangularPulse(x);

% Grafico del rettangolo originale
subplot(3, 1, 1);
fplot(triangolo, [-2,2]);
title('Triangolo Originale');
xlabel('Tempo');

% Triangolo contratto
tri_contratto = triangularPulse(2*x);

% Grafico del rettangolo originale
subplot(3, 1, 2);
fplot(tri_contratto, [-2,2]);
title('Triangolo Contratto');
xlabel('Tempo');

% Triangolo dilatato
tri_contratto = triangularPulse(1/3*x);

% Grafico del rettangolo originale
subplot(3, 1, 3);
fplot(tri_contratto, [-4,4]);
title('Triangolo Dilatato');
xlabel('Tempo');