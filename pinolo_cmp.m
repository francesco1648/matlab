

filename = 'PID_pinolo_10ms.txt'; 
fileID = fopen(filename, 'r');

% Usa textscan per leggere tutto il file correttamente
data = textscan(fileID, '%s %f %f %f %f %f %f %f %f %f %f %f %s %f %f', ...
    'Delimiter', '\t', 'HeaderLines', 0, 'MultipleDelimsAsOne', true);

% Chiudi il file dopo la lettura
fclose(fileID);
% Divide i dati nelle rispettive colonne con nomi corretti
getspeed = data{1};  % Testuale (non viene plottato)
rpm = data{2};
kp = data{3};
ki = data{4};
kd = data{5};
error = data{6};
integral = data{7};
derivative = data{8};
refval = data{9};
oldint = data{10};
olderr = data{11};
output = data{12};
pidg2o = data{13};   % Testuale (non viene plottato)
out2 = data{14};
speed2power = data{15};

% Numero di righe nei dati
num_samples = length(rpm);

% Creazione di un asse X (può rappresentare il tempo o semplicemente l'indice della riga)
x = linspace(1, num_samples, num_samples);



% Plotta le colonne più significative (puoi aggiungere/rimuovere altre colonne)
figure;
hold on;
grid on;
plot(x, rpm, '-b', 'DisplayName', 'RPM');
plot(x, refval,  'DisplayName', 'Reference Value');
xlabel('Time');
ylabel('Values');
title('Grafico delle Variabili del PID');
legend;
%plot(x, kp, '-r', 'DisplayName', 'Kp');
%plot(x, ki, '-g', 'DisplayName', 'Ki');
%plot(x, kd, '-m', 'DisplayName', 'Kd');


figure;
hold on;
grid on;
plot(x, error, '-c', 'DisplayName', 'Error');
plot(x, integral, '--b', 'DisplayName', 'Integral');
plot(x, derivative, '--r', 'DisplayName', 'Derivative');
plot(x, oldint, '--m', 'DisplayName', 'Old Integral');
plot(x, olderr, '--c', 'DisplayName', 'Old Error');
plot(x, output, ':b', 'DisplayName', 'Output');
xlabel('Time');
ylabel('Values');
title('Grafico delle Variabili del PID');
legend;


figure;
hold on;
grid on;
plot(x, speed2power, 'b', 'DisplayName', 'Speed to Power');
xlabel('Time');
ylabel('Values');
title('Speed to power');
legend;







filename = 'PID_pinolo_100ms.txt'; 
fileID = fopen(filename, 'r');

% Usa textscan per leggere tutto il file correttamente
data = textscan(fileID, '%s %f %f %f %f %f %f %f %f %f %f %f %s %f %f', ...
    'Delimiter', '\t', 'HeaderLines', 0, 'MultipleDelimsAsOne', true);

% Chiudi il file dopo la lettura
fclose(fileID);
% Divide i dati nelle rispettive colonne con nomi corretti
getspeed = data{1};  % Testuale (non viene plottato)
rpm = data{2};
kp = data{3};
ki = data{4};
kd = data{5};
error = data{6};
integral = data{7};
derivative = data{8};
refval = data{9};
oldint = data{10};
olderr = data{11};
output = data{12};
pidg2o = data{13};   % Testuale (non viene plottato)
out2 = data{14};
speed2power = data{15};

% Numero di righe nei dati
num_samples = length(rpm);

% Creazione di un asse X (può rappresentare il tempo o semplicemente l'indice della riga)
x = linspace(1, num_samples, num_samples);



% Plotta le colonne più significative (puoi aggiungere/rimuovere altre colonne)
figure;

hold on;
grid on;
plot(x, rpm, '-b', 'DisplayName', 'RPM');
plot(x, refval,  'DisplayName', 'Reference Value');
xlabel('Time');
ylabel('Values');
title('Grafico delle Variabili del PID');
legend;
%plot(x, kp, '-r', 'DisplayName', 'Kp');
%plot(x, ki, '-g', 'DisplayName', 'Ki');
%plot(x, kd, '-m', 'DisplayName', 'Kd');
figure;
hold on;
grid on;
plot(x, error, '-c', 'DisplayName', 'Error');

plot(x, integral, '--b', 'DisplayName', 'Integral');

plot(x, derivative, '--r', 'DisplayName', 'Derivative');

plot(x, oldint, '--m', 'DisplayName', 'Old Integral');

plot(x, olderr, '--c', 'DisplayName', 'Old Error');

plot(x, output, ':b', 'DisplayName', 'Output');
xlabel('Time');
ylabel('Values');
title('Grafico delle Variabili del PID');
legend;
grid on;
figure;
hold on;
grid on;
plot(x, speed2power, 'b', 'DisplayName', 'Speed to Power');
xlabel('Time');
ylabel('Values');
title('Speed to power');
legend;