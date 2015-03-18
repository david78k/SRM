% The SRM model of a neuron is as follows. It has the following parameters.

% Number of inputs N.
% PSP (post synaptic potential attached to each input) f_i(t) for i=1..N
% AHP (after hyperpolarization) for output g(t)
% 
% The neuron receives spike trains at each synapse.
% spike train at synapse i is <t^i_1,t^i_2,....>
% 
% Past output spikes of the neuron are <t^0_1,t^0,2....>
%  
% Potential at soma of neuron is:
% 
% \sum_synapses 1...N  \sum spikes at synapse_i   f_i(t^i_j)   + \sum g(t^0_j)
% 
% when potential crosses the threshold, the neuron generates a new spike
%  
% The controller will receive the state of the system as a spike train, and will send out a control signal also as a spike train.

%%%%%%%%%%%%%%% Membrane potential %%%%%%%%%%%%%%%%%
% Choose AMPA for excitatory and GABA_A for inhibitory synapses. 
% The most important constant is tau which should be 20msec and 10 msec respectively.

% PSPs P(t) = (Q/(d*sqrt(t)))*exp((-beta*d^2)/t)*exp(-t/tau)
% AHPs P(t) = R*exp(-t/gamma)
% where R denotes the instantaneous fall in potential after a spike
% and gamma controls its rate of recovery

disp('SRM function')

% number of inputs at each synapse
% N = 100; 
% i = 1:N;
totaltime = 10; % ms
% dt = 0.001;     % 1 ms time step
dt = 1;     % time step
% t = 0:dt:0.1;   % for AMPA
% t = 0:dt:25;   % for AMPA. (15, -0.0037267), (20, -5.7777e-05), (25, -8.9577e-07)
% t = 0:dt:0.01;  % for GABA_A
t = 0:dt:totaltime;  % for GABA_A, (100, 0.006588), (150, 0.00044487), (170, 0.000154), (180, 9.0842e-05) (200, 3.1743e-05)

% synaptic and axonal delays were combined and chosen from the realistic
% range [0.4, 0.9] msec.
delay = 0.8;

% PSPs
% Q denotes the connection strength randomly chosen from the range [1.0,
% 10.0] or fixed values depending upon the architecture
% The Q's at all synapses were scaled uniformly so that the average spike
% rate of the neurons in the network lay in a realistic range (i.e., did
% not exceed 20Hz).
% Q = 1.0;    % max potential: 0.0668, 12neurons needed to fire
% Q = 5.0;    % max potential: 0.3924, 3neurons needed to fire
% Q = 10.0;    % max potential: 0.8407, 2neurons needed to fire
Q = 0.001;    % max potential: 0.8407, 2neurons needed to fire
% distance of the synapse from the soma [1.0, 2.0]
% 1.5 for excitatory, 1.2 for inhibitory synapses
d = 1.5;
% beta and tau control the rate of rise and fall of the PSP

% AMPA for excitatory
beta = 1.0;
% tau = 0.02; % 20ms on exceitatory
tau = 20; % 20ms on exceitatory
% tau = 10; % 10ms on inhibitory

% GABA_A for inhibitory
% beta = 1.1;
% tau = 0.01; % 10ms

% GABA_B
% beta = 50.0;
% tau = 100;

disp([ 'total steps = ' num2str(totalsteps) ', tau = ' num2str(tau) ', Q = ' num2str(Q) ', d = ' num2str(d) ', beta = ' num2str(beta)]);

PSPs = 0;
for i = 1:3
    PSPs = PSPs + (Q/d./sqrt(t)).*exp(-(beta*d^2)./t).*exp(-t/tau);
end

% AHPs
% R = -1000.0; % default
R = -1.0; % default
% gamma = 0.0012; % 1.2 msec
gamma = 1.2; % 1.2 msec
AHP = R*exp(-t/gamma);

potential = PSPs + AHP;

subplot(3,1,1);
plot(t, PSPs)
ylabel('PSPs');
hold on;
subplot(3,1,2);
plot(t, AHP)
ylabel('AHP');
hold on;
subplot(3,1,3);
plot(t, potential)

ylabel('potential');
xlabel('time (ms)');

% [min, max] end
disp(['PSPs: [' num2str(min(PSPs)) ', ' num2str(max(PSPs)) '] min ' num2str(PSPs(end)) ])
disp(['AHPs: [' num2str(min(AHP)) ', ' num2str(max(AHP)) '] min ' num2str(AHP(end)) ])
disp(['potential: [' num2str(min(potential)) ', ' num2str(max(potential)) '] min ' num2str(potential(end)) ])

% number of spikes at each synapse without weights
M = 100;
j = 1:M;

% potential = sum(f_i, g);
threshold = 1.0;
if (max(potential) > threshold)
    disp('fired');
end

%%%%%%%%%%%%%%% function Force %%%%%%%%%%%%%%%%%
% clf; clear all;

% fmax = 1000; % F(-7.3576, 7.3576)
% fmax = 2000; % F(-14.7152, 14.7152)
% fmax = 10000; % F(-73.5759, 73.5759)
% dt = 0.02; % 20ms, tau = 1, Fmax = 0.3679, period = 9.18sec 460steps (300-400 ok)
% dt = 0.001; % 1ms, tau = 1, Fmax = 0.36788, period = 9.199sec, 9200steps
% dt = 0.001; % 1ms, tau = 0.02, Fmax = 0.0073576, period = 0.179sec, 180steps
% tau = 1; % 
% tau = 0.5; % dt = 0.02, Fmax = 0.18394, period = 4.38sec, 220steps
% tau = 0.02; % dt = 0.001, Fmax = 0.0073576, period = 0.18sec, 10steps
% last_steps = 200; % 460, 8000, 9200
% total_steps = 2000; % 1sec
% 
% steps = []; F = []; push = [];

% tic
% for step = 1:(total_steps)
% %     step
% %     endpoint = min(last_steps, step + last_steps);
%     startpoint = mod(step, last_steps);
%     endpoint = startpoint + last_steps - 1;
%     if startpoint == 1   
%         push = mod(randi(3),3) - 1;
%         for i = startpoint: endpoint
%             steps(step + i) = (step + i - 1)*dt;
%             t = steps(i);            
% %             F(step + i) = t*exp(-t/tau);
%             F(step + i) = fmax * push * t*exp(-t/tau);
% %             steps(step + i) = step * dt;
% %             F(step + i) = step+ i;
%         end
%     end
% %     step = step + 1;
% end
% 
% disp(['steps(end): ' num2str(steps(end)) ', F(end): ' num2str(F(end)) ', F(' num2str(min(F)) ', ' num2str(max(F)) ')' ] );
% 
% hold on;
% plot(steps,F);
% ylabel('Force');
% xlabel('time');
% hold off;
% 
% toc

%%%%%%%%%%%%%%% loading data %%%%%%%%%%%%%%%%%
% data = load('data_gui_08.mat');
%        filter: [6.1360e-05 94.1404]
%          gain: [3.6675e-04 -0.0168 -1.6182]
%     threshold: [-41.4561 1.1721e+03 2.6385]
%       int_rel: [0.5000 0.7200]
%           g_e: [199999x2 double]
%           g_i: [199999x2 double]
%             v: [199999x2 double]
            
% parameters = load('parameters.mat');
%        filter: [6.1360e-05 94.1404]
%          gain: [3.6675e-04 -0.0168 -1.6182]
%     threshold: [-41.4561 1.1721e+03 2.6385]

% modeldb = load('modeldB_data.mat');
%                ETA: [1x35000 double]
%             filter: [1x1 struct]
%      cst_threshold: -40.2124
%     exp1_threshold: [-40.2124 10.6523 17.7802]
%               data: {[1x1 struct]  [1x1 struct]}

% data1 = modeldb.data{1,1}
%     spiketimes: [656x1 double]
%              V: [34000x1 double]
%              I: [34000x1 double]
%           mean: 480
%            std: 165
%      int_coinc: 0.7100


% data2 = modeldb.data{1,2}
%     spiketimes: [218x1 double]
%              V: [34000x1 double]
%              I: [34000x1 double]
%           mean: 160
%            std: 330
%      int_coinc: 0.8900
     
% modeldb.filter;
%        a: 0.1082
%        b: -2.1664
%        c: 0.0027
%        d: -0.0630
%     fifi: [1x110 double]
% modeldb.filter.fifi;

% t = 0:10;
% f_i = 
% sum = \sum f_i(t^i_j) + \sum g(t^0_j)

% g_e = data.g_e;
% g_i = data.g_i;
% plot(g_e)
% hold on;
% plot(g_i)
% plot(data.v)

