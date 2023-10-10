# 设参
# x = "[Ag+]"
# B = "[AgNP]"
# C = "[CsgA-MBP]"
# A = "n1"
# D = "Kd1"
# Max = "The maxinum of Ag+ absorbed"


# 引用库函数

import numpy as np
import matplotlib.pyplot as plt
from scipy import optimize as op
from sklearn.metrics import r2_score

plt.rcParams['axes.unicode_minus'] = False    # 用来正常显示负号

# 需要拟合的函数
def target_func(x, A, C, D):
    return A * C * (x ** A) / (D + x ** A)


# 需要拟合的数据组
x_group = [1.207144478, 1.834162582, 2.710764071, 4.756609937, 6.068810797]
y_group = [0.291178741, 0.420117353, 1.570224396, 1.857359967, 1.890588668]

# 得到返回的A,C,D值
a, c, d = op.curve_fit(target_func, x_group, y_group)[0]
print("CsgA-AG4=", c)
print("Kd=", d)
print("n=", a)

# 计算r2
y1_group = []
for i in range(5):
    y1_group.append(a * c * (x_group[i] ** a) / (d + x_group[i] ** a))

r2 = r2_score(y_group, y1_group)
print("r2=", r2)


# 数据点与原先的进行画图比较
plt.scatter(x_group, y_group, marker='*', s=80, color='orange', label='exper data')
plt.xlabel(r"Concentration of Ag ions input (mg/L)")
plt.ylabel(r"Concentration of Ag ions on steady state (mg/L)")
x = np.arange(0, 8, 0.5)
y = a * c * (x ** a) / (d + x ** a)
plt.plot(x, y, color='blue', label='ideal curve')
plt.legend()  # 显示label

# 图表标题
plt.title("The adsorption of Ag ions", fontsize=24)

plt.show()
