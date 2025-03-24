
A=K;
B=omega_n*zeta*2;
C=omega_n^2;
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

simOut1 = sim('pid_sim');
%%
simOut1 = sim('pid_sim');
results1 = simOut1.get('out_sistema'); % Supponiamo che il risultato sia salvato in 'yout'

figure 
plot(results1.time, results1.signals.values);
xlabel('Tempo');
ylabel('Valore');
grid on;


kp = 1.43;           % Guadagno proporzionale
ki = 7.15;           % Guadagno integrativo
kd = 0.07;           % Guadagno derivativo



simOut2 = sim('pid_sim');
results2 = simOut2.get('out_sistema'); % Supponiamo che il risultato sia salvato in 'yout'

figure 
plot(results2.time, results2.signals.values);
xlabel('Tempo');
ylabel('Valore');
grid on;
