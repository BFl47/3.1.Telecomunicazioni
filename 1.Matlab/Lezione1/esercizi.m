close all
clear
clc

syms x;

% Rettangolo 
a = -1/2;
b = 1/2;
rettangolo = rectangularPulse(a,b,x);

% Triangolo
triangolo = triangularPulse(x);

% % 1
% e1 = rectangularPulse(x/3);
% subplot(3, 1, 1);
% fplot(e1, [-2,2]);
% t1 = '\textbf{ rect($\frac{t}{3}$) }';
% title(t1, Interpreter="latex");
% 
% % 2
% e2 = 2*e1;
% subplot(3, 1, 2);
% t2 = '\textbf{ 2rect($\frac{t}{3}$) }';
% fplot(e2, [-2,2]);
% title(t2, Interpreter="latex");
% 
% 3
% e3 = triangularPulse(2*x -3); 
% % il centro si sposta con passo 0.5 di 3 posizioni
% subplot(3, 1, 3);
% fplot(e3, [-1,3]);
% title('tri(2t - 3)');
% 
% 4
e4_1 = rectangularPulse(x + 0.5);
e4_2 = 3 * triangularPulse(x/2);
e4 = e4_1 * e4_2;

subplot(3, 1, 1);
fplot(e4_1, [-3,3]);
t4_1 = '\textbf{ rect(t + $\frac{1}{2}$) }';
title(t4_1, interpreter="latex");

subplot(3, 1, 2);
fplot(e4_2, [-3,3]);
t4_2 = '\textbf{ 3tri($\frac{t}{2}$) }';
title(t4_2, interpreter="latex");

subplot(3, 1, 3);
fplot(e4, [-3,3]);
t4 = '\textbf{rect(t + $\frac{1}{2}$) * 3tri($\frac{t}{2}$) }';
title(t4, interpreter="latex");

% 5
% e5_1 = 2 * rectangularPulse(x/2 - 4);
% % il centro si sposta con passo 2 di 4 posizioni
% e5_2 = triangularPulse(x + 2);
% % il centro si sposta (con passo 1) di 2 posizioni
% e5 = e5_1 + e5_2;
% 
% subplot(3, 1, 1);
% fplot(e5_1, [2, 10]);
% t5_1 = '\textbf{ 2rect($\frac{t}{2}$ - 4) }';
% title(t5_1, Interpreter="latex");
% 
% subplot(3, 1, 2);
% fplot(e5_2,[-4,0]);
% t5_2 = '\textbf{ tri(t + 2) }'; 
% title(t5_2, Interpreter="latex");
% 
% subplot(3, 1, 3);
% fplot(e5, [-3.5, 9.5]);
% t5 = '\textbf{ 2rect($\frac{t}{2}$ - 4) + tri(t + 2)}';
% title(t5, Interpreter="latex");

