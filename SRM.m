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

disp('SRM function')

% number of inputs at each synapse
N = 10; 
i = 1:N;
t = 0:0.1:10;
f_i = [];
g = [];

% number of spikes at each synapse without weights
M = 100;
j = 1:M;

potential = 0;
% for (i = 0; i < 
potential = sum(f_i, g);
thresh = 0;
if (potential > thresh)
    disp('spike');
end

%%%%%%%%%%%%%%% loading data %%%%%%%%%%%%%%%%%
data = load('data_gui_08.mat');
%        filter: [6.1360e-05 94.1404]
%          gain: [3.6675e-04 -0.0168 -1.6182]
%     threshold: [-41.4561 1.1721e+03 2.6385]
%       int_rel: [0.5000 0.7200]
%           g_e: [199999x2 double]
%           g_i: [199999x2 double]
%             v: [199999x2 double]
            
parameters = load('parameters.mat');
%        filter: [6.1360e-05 94.1404]
%          gain: [3.6675e-04 -0.0168 -1.6182]
%     threshold: [-41.4561 1.1721e+03 2.6385]

modeldb = load('modeldB_data.mat');
%                ETA: [1x35000 double]
%             filter: [1x1 struct]
%      cst_threshold: -40.2124
%     exp1_threshold: [-40.2124 10.6523 17.7802]
%               data: {[1x1 struct]  [1x1 struct]}
modeldb.data;

modeldb.filter;
%        a: 0.1082
%        b: -2.1664
%        c: 0.0027
%        d: -0.0630
%     fifi: [1x110 double]
modeldb.filter.fifi;

t = 0:10;
% f_i = 
% sum = \sum f_i(t^i_j) + \sum g(t^0_j)

% plot(g_e)
hold on;
% plot(g_i)
% plot(v)

