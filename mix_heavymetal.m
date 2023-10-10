clear
% 已知参数
V_total = 1;
V_solid = 0.5;
n1 = 7;
n3 = 6;
n4 = 5;
K_a = 146;
K_b = 72;
K_c = 40;
%k_a = 0.9;
k_minus_a = 1;
%k_b = 1.2;
k_minus_b = 1;
%k_c = 1.2;
k_minus_c = 1;
Cd_total = 0.0089;% 1mg/L
Cu_total = 0.01574;
Pb_total = 0.00482;

% 目标 SmtA 值的范围
SmtA_range = linspace(0, 1000, 1000);

% 优化选项
options = optimoptions('fmincon', 'Display', 'off');

% 优化函数
smtA_func = @(x, SmtA_target) abs((1/3) * ((V_total * (Cd_total - x(1)) / (V_solid * n1)) / (x(1) ^ n1 * K_a / k_minus_a) ...
    + (V_total * (Cu_total - x(2)) / (V_solid * n1)) / (x(2) ^ n1 * K_b / k_minus_b) ...
    + (V_total * (Pb_total - x(3)) / (V_solid * n1)) / (x(3) ^ n1 * K_c / k_minus_c)) ...
    + (V_total * (Cd_total - x(1)) / (V_solid * n1)) ...
    + (V_total * (Cu_total - x(2)) / (V_solid * n3)) ...
    + (V_total * (Pb_total - x(3)) / (V_solid * n4)) - SmtA_target);

% 初始化结果矩阵
Cd_values = zeros(size(SmtA_range));
Cu_values = zeros(size(SmtA_range));
Pb_values = zeros(size(SmtA_range));

% 对每个 SmtA 值进行优化
for i = 1:length(SmtA_range)
    SmtA_target = SmtA_range(i);
    x0 = [0.1, 0.1, 0.1]; % 初始猜测值
    lb = [0, 0, 0]; % 变量下界
    ub = [Cd_total, Cu_total, Pb_total]; % 变量上界
    [x_opt, ~] = fmincon(@(x) smtA_func(x, SmtA_target), x0, [], [], [], [], lb, ub, [], options);
    Cd_values(i) = x_opt(1);
    Cu_values(i) = x_opt(2);
    Pb_values(i) = x_opt(3);
end

% 绘制结果
figure;
plot(SmtA_range, Cd_values, 'r', 'LineWidth', 2);
hold on;
plot(SmtA_range, Cu_values, 'g', 'LineWidth', 2);
plot(SmtA_range, Pb_values, 'b', 'LineWidth', 2);
xlabel('SmtA (mol)');
ylabel('Residual metal ion concentration /mol·L^{-1}');
legend('Cd', 'Cu', 'Pb');
title('Residual heavy metal concentration vs. SmtA');
grid on;