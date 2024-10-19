close all
clear
clc

% Rettangolo originale
syms x;
a = -1/2;
b = 1/2;
rettangolo = rectangularPulse(a,b,x);

% Grafico del rettangolo originale
subplot(3, 2, 1);
fplot(rettangolo, [-2,2]);
title('Rettangolo Originale');
xlabel('Tempo');
ylabel('z(t)');

% Rettangolo shiftato a destra (ritardo)
rettangolo_shifted_dx = rectangularPulse(a,b,x-1);

%Grafico rettangolo shiftato verso dx
subplot(3, 2, 4);
fplot(rettangolo_shifted_dx, [-2,2]);
title('Rettangolo con ritardo');
xlabel('Tempo');
ylabel('z(t)');

% Rettangolo shiftato a sinistra (anticipo)
rettangolo_shifted_dx = rectangularPulse(a,b,x+1);

%Grafico rettangolo shiftato verso sx
subplot(3, 2, 3);
fplot(rettangolo_shifted_dx, [-2,2]);
title('Rettangolo con anticipo');
xlabel('Tempo');
ylabel('z(t)');

% Rettangolo reciproco
rettangolo_rec = rectangularPulse(-2,2,1/x);

% Grafico del rettangolo reciproco
subplot(3, 2, 2);
fplot(rettangolo_rec, [-2,2]);
title('Rettangolo Reciproco');
xlabel('Tempo');
ylabel('z(t)');

% Rettangolo dilatato
rettangolo_dilatato = rectangularPulse(a,b,1/2*x);

%Grafico rettangolo dilatato
subplot(3, 2, 5);
fplot(rettangolo_dilatato, [-2,2]);
title('Rettangolo dilatato');
xlabel('Tempo');
ylabel('z(t)');

% Rettangolo contratto
rettangolo_contratto = rectangularPulse(a,b,2*x);

%Grafico rettangolo contratto
subplot(3, 2, 6);
fplot(rettangolo_contratto, [-2,2]);
title('Rettangolo contratto');
xlabel('Tempo');
ylabel('z(t)');
