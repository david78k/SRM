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

% PSPs P(t) = (Q/(d*sqrt(t)))*exp((-beta*d^2)/t)*exp(-t/tau)
% AHPs P(t) = R*exp(-t/gamma)
% where R denotes the instantaneous fall in potential after a spike
% and gamma controls its rate of recovery

disp('SRM function')

% number of inputs at each synapse
N = 100; 
i = 1:N;
t = 0:0.1:100;

% synaptic and axonal delays were combined and chosen from the realistic
% range [0.4, 0.9] msec.
delay = 0.8;

% PSPs
% Q denotes the connection strength randomly chosen from the range [1.0,
% 10.0] or fixed values depending upon the architecture
% The Q's at all synapses were scaled uniformly so that the average spike
% rate of the neurons in the network lay in a realistic range (i.e., did
% not exceed 20Hz).
Q = 5.0;
% distance of the synapse from the soma [1.0, 2.0]
% 1.5 for excitatory, 1.2 for inhibitory synapses
d = 1.5;
% beta and tau control the rate of rise and fall of the PSP
% AMPA
beta = 1.0;
tau = 20; % on exceitatory
% tau = 10; % on inhibitory
% GABA_B
% beta = 50.0;
% tau = 100;
% beta = 1000.0;
% tau = 2000;
% PSPs = (Q./(d*sqrt(t))).*exp((-beta*d*d)./t).*exp(-t/tau);
PSPs = 100*(Q./(d*sqrt(t))).*exp((-beta*power(d,2))./t).*exp(-t/tau);
% PSPs = (Q/d./sqrt(t)).*exp(-(beta*d^2)./t).*exp(-t/tau);

% AHPs
R = -1000.0; % default
R = -100;
gamma = 1.2;
threshold = 1.0;
AHPs = R*exp(-t/gamma);

plot(t, PSPs)
% hold on;
plot(t, AHPs)
potential = PSPs + AHPs;
% hold on;
plot(t, potential)

% number of spikes at each synapse without weights
M = 100;
j = 1:M;

% for (i = 0; i < 
% potential = sum(f_i, g);
thresh = 0;
if (potential > thresh)
    disp('spike');
end

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

