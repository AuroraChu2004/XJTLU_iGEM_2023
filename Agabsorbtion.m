% Parameters
K = 299.359;
V = 5;
n = 7.35;
%Vtot=1L
%Vsolid=7.8E-5,有255个膜,Vsolid=0.2L
ag_total = 0.009259;

% Options for fmincon
options = optimoptions('fmincon','Display','off');

% Range of CsgA MBP3 values
csga_values = linspace(0, 0.04, 50);
agplus_values = zeros(size(csga_values));

for i = 1:length(csga_values)
    csga_initial = csga_values(i);
    % Use fmincon to find the value of Ag+ that minimizes the error function
    agplus_values(i) = fmincon(@(agplus) compute_error(agplus, csga_initial, K, V, n, ag_total), 0.0005, [], [], [], [], 0, ag_total, [], options);
end

% Plot
figure;
plot(csga_values.*0.2, agplus_values,'b','LineWidth',1.5);
xlabel('Amount of input CsgA=AG4 /mol');
ylabel('Residual Ag^+ concentration /mol·L^{-1}');
title('Change of the residual Ag" conc with the amout of CsgA-AG4');
grid on;

function error_func = compute_error(agplus, csga_initial, K, V, n, ag_total)
    % Define the function based on the equation
    val = (V/n * (ag_total - agplus)) / (agplus^n * (csga_initial - V * (ag_total - agplus))) - K;
    error_func = val^2; % We want to minimize the square of this difference
end
