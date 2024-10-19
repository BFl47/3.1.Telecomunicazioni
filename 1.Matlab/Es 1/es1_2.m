close all
clear
clc

% Es1
% Definire in matlab un segnale x(t) coseno con ampiezza A=5; periodo T= 2s,fase=1s
% a)Scrivere il vettore x tra 0 e 2T
% b)Fare il grafico fissando l asse x tra 0 e 10 s, 
% definendo il titolo della figura, i label degli assi.

A = 5; % Ampiezza
T = 2; % Periodo
phi = 1; % Fase

t = 0:0.05:2*T; % Intervallo di tempo da 0 a 2*pi con passo 0.05

x = A * cos(2*pi*t/T + phi);


subplot(2, 1, 1);
stem(t,x);
xlim([0 10]);   % axis([0 10 -5 5]);
title("Segnale originale");
xlabel('t');
ylabel('Ampiezza');

% Es2
% Definire il segnale y(t)=x(t/2)+1
% a)Scrivere il vettore y tra 0 e 2T’ 
% b)Fare il grafico fissando l’asse x tra 0 e 10 s, definendo il titolo della figura,
% i label degli assi. Fare uniunica figura contenente i due grafici (con subplot)
T1 = 2*T;   % T'
t1 = 0:0.05:2*T1;
y =  A * cos(2*pi*t1/T1 + phi) + 1;

subplot(2, 1, 2);
stem(t1, y);
title('Segnale modificato');
xlabel('t');
ylabel('Ampiezza');
xlim([0 10]);



