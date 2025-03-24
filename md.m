clc 
clear all
close all

filename = 'md.txt'; 
fileID = fopen(filename, 'r');

% Usa textscan per leggere tutto il file correttamente
data = textscan(fileID, '%s %f %s %f %f %f %f %f %f %f %f %f %f %s %f ', ...
    'Delimiter', '\t', 'HeaderLines', 0, 'MultipleDelimsAsOne', true);

% Chiudi il file dopo la lettura
fclose(fileID);
% Divide i dati nelle rispettive colonne con nomi corretti
pwm = data{2};
volt= data{15};



% Plotta le colonne più significative (puoi aggiungere/rimuovere altre colonne)
figure;

grid on;
plot(pwm(1:733), volt, '-b', 'DisplayName', 'RPM');
hold on;

legend;
%plot(x, kp, '-r', 'DisplayName', 'Kp');
%plot(x, ki, '-g', 'DisplayName', 'Ki');
%plot(x, kd, '-m', 'DisplayName', 'Kd');
%%
figure;

plot(x, error, '-c', 'DisplayName', 'Error');
hold on;
plot(x, integral, '--b', 'DisplayName', 'Integral');
hold on;
plot(x, derivative, '--r', 'DisplayName', 'Derivative');
hold on;
plot(x, oldint, '--m', 'DisplayName', 'Old Integral');
hold on;
plot(x, olderr, '--c', 'DisplayName', 'Old Error');
hold on;
plot(x, output, ':b', 'DisplayName', 'Output');
xlabel('Time');
ylabel('Values');
title('Grafico delle Variabili del PID');
legend;
grid on;
figure;

grid on;
plot(x, speed2power, 'b', 'DisplayName', 'Speed to Power');
xlabel('Time');
ylabel('Values');
title('Speed to power');
legend;
% Configura il grafico
% Numero totale di righe dei dati
num_righe = length(refval); % Assumiamo che 'rpm' abbia già i dati

% Creazione della seconda colonna
tempo = zeros(num_righe, 1); % Inizializza tutta la colonna a zero

% Da riga 160 in poi (indice 159 in MATLAB) aumenta di 0.01 per ogni riga
tempo(159:end) = (0:0.01:(num_righe-159)*0.01)';

% Combina le due colonne in una matrice

simData = [tempo,refval];

% Salvare il file in formato MAT
save('refvalue_data.mat', 'simData');

simData = timeseries(refval, tempo);


J  = 0.008;    %  (momento di inerzia del rotore)
B  = 0.05;     %  (coefficiente di attrito viscoso)
KM = 0.22;    %(costante di coppia motore)
R  = 2;       % Resistenza [Ohm]
L  = 0.0014;     % Induttanza [H]
N = 30;                  % riduttore di velocita
% Parametri del PWM e motor driver
V_supply = 12;      % Tensione di alimentazione [V]

 kp=kp_sp(100,1);  %kp = 1.43;           % Guadagno proporzionale
 ki= ki_sp(100,1)  %ki = 7.15;           % Guadagno integrativo
 kd=kd_sp(100,1);  %kd = 0.07;           % Guadagno derivativo
dt=0.08;
alpha =1;
dt_function=dt;

MAX_SPEED = 330;
max_output = MAX_SPEED;

th=50;
tl=40;

%%
for i = 2:length(tempo) % Inizia da 2 perché il primo valore non ha precedente
    if isnan(tempo(i))
        tempo(i) = tempo(i-1); % Sostituisci con il valore precedente
    end
end
for i = 2:length(speed2power) % Inizia da 2 perché il primo valore non ha precedente
    if isnan(speed2power(i))
        speed2power(i) = speed2power(i-1); % Sostituisci con il valore precedente
    end
end
for i = 2:length(rpm_actual) % Inizia da 2 perché il primo valore non ha precedente
    if isnan(rpm_actual(i))
        rpm_actual(i) = rpm_actual(i-1); % Sostituisci con il valore precedente
    end
end
for i = 159:3500 % Inizia da 2 perché il primo valore non ha precedente
    
       time(i-158,1) = tempo(i); % Sostituisci con il valore precedente
       voltage(i-158,1)=0.0117 .* speed2power(i);
       w_rad(i-158,1) = rpm_actual(i) .* (2*3.14/60);         % Converte rpm in rad/s
end

Ts=0.01;
data = iddata(w_rad, voltage, Ts);
model = tfest(data, 4);

compare(data, model);
[num, den] = tfdata(model, 'v'); % Ottieni i coefficienti del numeratore e denominatore

disp('Numeratore:');
disp(num);
disp('Denominatore:');
disp(den);









