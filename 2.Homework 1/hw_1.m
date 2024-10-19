close all
clear
clc

% 1 - Definizione del segnale e grafici
load('02_FilteredData/FilteredData_Subject_17_task_CW.mat');
x_n = ECG(50000:52000, 1);

subplot(3, 1, 1);
plot(x_n); hold on;

M1 = mean(x_n);
yline(M1, '-', 'Valore medio', 'LineWidth', 2.5, 'Color','#D95319');
V = var(x_n);
E1 = sum(x_n.^2);

text = {['Varianza: ' num2str(V)], ['Energia: ' num2str(E1)]};
pos = [0.75, 0.8, 0.5, 0.1];
annotation('textbox', pos, 'String', text, 'FitBoxToText','on', 'BackgroundColor', [1, 1, (204/255)], 'FontSize',12);

title('Cognitive workload del soggetto 17', 'FontSize',15);
xlabel('n', 'FontWeight','bold');
ylabel('x_n', 'FontWeight','bold');
grid;

% 2 - Degradazione del Segnale e grafico
y_n = x_n;
for i = 850:1150
y_n(i) = 0;
end

subplot(3, 1, 2);
plot(y_n); hold on;

M2 = mean(y_n);
yline(M2, '-', 'Valore medio', 'LineWidth', 2.5, 'Color','#D95319');
E2 = sum(y_n.^2);

txt2 = {'Energia:',E2};
text = {'Energia: ' num2str(E2)};
pos2 = [0.75, 0.5, 0.5, 0.1];
annotation('textbox', pos2, 'String', text, 'FitBoxToText','on', 'BackgroundColor', [1, 1, (204/255)], 'FontSize', 12);

title('Degradazione del segnale x_n', 'FontSize', 15);
xlabel('n', 'FontWeight','bold');
ylabel('y_n', 'FontWeight','bold');
ylim([-0.4 1.2]);
grid on;

% 3 - Calcolo correlazione e coefficiente di correlazione
load("02_FilteredData/FilteredData_Subject_1_task_CW.mat");
z_n = ECG(50000:52000, 1);

R = xcorr(y_n, z_n);
subplot(3, 1, 3);
plot(R);

coef = corr2(y_n, z_n);
txt3 = {'Coefficiente di correlazione:', num2str(coef)};
pos3 = [0.75, 0.2, 0.5, 0.1];
annotation('textbox', pos3, 'String', txt3, 'FitBoxToText','on', 'BackgroundColor', [1, 1, (204/255)], 'FontSize', 12);

title('Correlazione tra y_n e z_n','FontSize', 15);
xlabel('n','FontWeight', 'bold');
ylabel('R_y_z', 'FontWeight', 'bold');
grid;

% Impostazioni visualizzazione finestra
schermo = get(0, 'ScreenSize');
larghezza_schermo = schermo(3);
altezza_schermo = schermo(4);
set(gcf, 'Position', [1, 1, larghezza_schermo, altezza_schermo]);

% % Domanda Extra
% % - Versione con findpeaks():
% [peak_value, peak_location] = findpeaks(x_n, 'MinPeakHeight', 0.7);
% singola_distanza = peak_location(5) - peak_location(4);
% fprintf("Distanza tra quarto e quinto picco:" ); disp(singola_distanza);
% % risultato = 180
 
% %- Versione "manuale”: 
% soglia=0.7; c=1; n_entry_arraypicchi=0; array_pos_picchi=zeros(10000);
% while (c < length(x_n)) 
%     while (x_n(c)<soglia && c<length(x_n)) 
%         c=c+1; 
%     end                              	     
%     if(c==length(x_n))                             
%         break;                                     
%     else                                           
%         n_entry_arraypicchi=n_entry_arraypicchi+1; 
%         sum_pos_picchi=0;                          
%         nover=0;                                   
%     end                                            
%     while (x_n(c)>=soglia && c<length(x_n))        
%         nover=nover+1;
%         sum_pos_picchi=sum_pos_picchi+c;
%         c=c+1;
%     end
%     array_pos_picchi(n_entry_arraypicchi)=(sum_pos_picchi/nover); 
% end
% distanza=array_pos_picchi(5)-array_pos_picchi(4);
% fprintf("La distanza tra i picchi 4 e 5 è: %f\n",distanza);
% % risultato = 179.5
