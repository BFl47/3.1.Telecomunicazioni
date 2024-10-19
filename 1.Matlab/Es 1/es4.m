close all
clear
clc

% Es4
% Dato il vettore: phase_vector=[1, 1.25,1.5,1,75, 2]:
% A. Calcolare i segnali x (finiti prima) per i diversi valori di fase
% contenuti in questo vettore.
% B. Metterli in una matrice Matrix_signals che colleziona questi vettori per colonna.
% C. Al variare di questo parametro, calcolare l’autocorrelazione di questi segnali e la
% crosscorrelazione con x(t) di partenza. Calcolare anche il coefficiente di
% correlazione.
% Fare figura con i valori del coefficiente di correlazione

A = 5; % Ampiezza
T = 2; % Periodo T
phi = 1; % Fase
t = 0:0.05:2*T; % Intervallo di tempo da 0 a 2*pi con passo 0.05
x1 = A * cos(2*pi*t/T + phi);

phase_vector = [1, 1.25,1.5,1,75, 2];
i = 1;

Matrix_signals = {};
for phi = phase_vector
    x = A * cos(2*pi*t/T + phi);
    auto_c = xcorr(x);
    c = xcorr(x, x1);
    
    coef = corr2(x, x1);    % disp(coef);
    plot(i, coef, '-o');
    testo = strcat('\leftarrow c',int2str(i));
    text(i+0.1, coef, testo );
    hold on
  
    i = i+1;

    Matrix_signals = horzcat(Matrix_signals,x);
end   

title('Coefficienti di correlazione');
xlabel('x_i');
xlim([0 10]);
ylim([0 1.5]);
grid on
   