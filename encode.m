% encode state theta to spike train
total_step = 1000;
threshold = 0.03;    % threshold to fire
dt = 0.001; % 1ms time step
tau = 0.1; % 20ms time constant

spikes = 0;
steps = [];
F = []; % membrane potential
s = []; % input stimulus
k1 = []; % kernel 1
k2 = [];
k3 = [];
state = []; % e.g., theta, theta_dot, h, h_dot

f1 = inline('t*exp(-t/tau)'); % threshold = 0.35
f2 = inline('sin(t)*exp(-t/tau);'); % threshold = 0.3
f3 = inline('cos(t)*exp(-t/tau);'); % threshold 
f4 = inline('tan(t)*exp(-t/tau);'); % threshold 
f5 = inline('1/sqrt(2*pi)*exp(-t*t*0.5/tau)'); % gaussian

tic

for step = 1:total_step,
    steps(step) = (step - 1)*dt;
    t = steps(step);
        
    fun = @(t) t .* exp(-t);
    k1(step) = f1(t, tau); % threshold = 0.35
    k2(step) = f2(t, tau); % threshold = 0.3
    k3(step) = f3(t, tau); % 
    k4(step) = f4(t, tau); %
    k5(step) = f5(t, tau); %
    
    % generate random input: theta [0, 1]
    x = rand();
    state(step) = x;
    s(step) = f1(x, tau);
%     s(step) = f2(x, tau);
%     s(step) = f5(x, tau);
    
    if s(step) >= threshold
%         disp(['Fired'])
        spikes = spikes + 1;
    end
end

disp(['Spikes ' num2str(spikes) '/' num2str(total_step)])

subplot(2,1,1);
% % plot(steps,k1);
% hold on;
% plot(steps,k2);
% hold on;
plot(steps,k2);
ylabel('kernel output');
xlabel('kernel input');

hold on;
subplot(2,1,2);
plot(steps,s);

ylabel('potential');
xlabel('time (sec)');
% plot(steps,push);
hold off;

toc