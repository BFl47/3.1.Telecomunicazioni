close all
clear
clc

% Es3
% Definire una stringa «choice_vect» che selezioni se si vuole lavorare sul segnale
% originale oppure su quello trasformato e secondo questa scelta:
% a)Calcolare il valore medio e l’energia del segnale scelto
% b)Fare un nuovo grafico del segnale scelto sovrapponendo una linea orizzontale
% rappresentante il valore medio e una nota sulla figura che indica il valore
% dell’energia. Scegliere opportunamente lo spessore e il colore della riga
% orizzontale
A = 5; % Ampiezza
phi = 1; % Fase

% Segnale originale
T = 2; % Periodo T
t = 0:0.05:2*T; % Intervallo di tempo da 0 a 2*pi con passo 0.05
x = A * cos(2*pi*t/T + phi);

% Segnale modificato
T1 = 2*T;   % Periodo T'
t1 = 0:0.05:2*T1;
y =  A * cos(2*pi*t1/T1 + phi) + 1;

choice_vect = input('Segnale originale o modificato? ', "s");
if strcmp(choice_vect, 'originale')
    % N = length(x);
    M = mean(x);    % M = 1/N * sum(x);
    E = sum(x.^2);

    stem(t, x);
    xlim([0 10]);
 
    title('Segnale originale');
    xlabel('t');
    ylabel('Ampiezza');
    hold on

    yline(M, 'LineWidth', 3, 'Color','b');  
    text(9, M+0.35, '\downarrow M');
   

    txt = {'Energia:',E};
    text(8.5,2.5,txt);

else
    M = mean(y);
    E = sum(y.^2);
 
    stem(t1, y);
    xlim([0 10]);

    title('Segnale modificato');
    xlabel('t');
    ylabel('Ampiezza');
    
    yline(M, 'LineWidth', 3, 'Color','b');  
    text(9, M+0.35, '\downarrow M');

    txt = {'Energia:',E};
    text(8.5,2.5,txt);

end
