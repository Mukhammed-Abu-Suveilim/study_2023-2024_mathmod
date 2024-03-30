using Plots
using DifferentialEquations

#начальные значения
Mi1 = 3.7 #начальное значение объема оборотных средств M1
Mi2 = 2.8 #начальное значение объема оборотных средств M2
p_cr =  27 #критическая стоимость продукта
N = 37 #число потребителей производимого продукта
q = 1 #максимальная потребность одного человека в продукте в единицу времени
tau1 = 27 #длительность производственного цикла фирмы 1
tau2 = 17 #длительность производственного цикла фирмы 2
p1 = 6.7 #себестоимость продукта у фирмы 1
p2 = 11.7 #себестоимость продукта у фирмы 2

a1 = p_cr/(tau1^2*p1^2*N*q)
a2 = p_cr/(tau2^2*p2^2*N*q)
b = p_cr/(tau1^2*p1^2*tau2^2*p2^2*N*q)
c1 = (p_cr - p1)/(tau1*p1)
c2 = (p_cr - p2)/(tau2*p2)

#уравнение, описывающее динамики оборотных средств двух фирм, производящие взаимозаменяемые товары
#одинакового качества и находящиеся в одной рыночной нише 


function caseTwo(du, u, p, t)
    M1, M2 = u
    du[1] = u[1] - (b/c1)*u[1]*u[2] - (a1/c1)*u[1]^2
    du[2] = (c2/c1)*u[2] - (b/c1 + 0.00063)*u[1]*u[2] - (a2/c1)*u[2]^2
end

#интервал временни и начальные значения
tspan = (0, 10)
u0 = [Mi1, Mi2]

prob = ODEProblem(caseTwo, u0, tspan)

sol = solve(prob, dtmax = 0.05)

M1 = [u[1] for u in sol.u]
M2 = [u[2] for u in sol.u]
Time = [t for t in sol.t]

pltOne = plot(dpi = 300, legend =:topright, ylims=(0,500))

plot!(
    pltOne,
    Time,
    M1,
    title = "График изменения оборотных средств фирмы 1 (синий) и фирмы 2
(зеленый)",
    titlefont = font(8),
    xlabel = "Время",
    ylabel = "оборотные средства",
    guidefontsize=8,
    label = "M1",
    color=:blue
    )
plot!(
    pltOne,
    Time,
    M2,
    title = "График изменения оборотных средств фирмы 1 (синий) и фирмы 2
(зеленый)",
    titlefont = font(8),
    xlabel = "Время",
    ylabel = "оборотные средства",
    label = "M2",
    guidefontsize=8,
    color=:green
    )

savefig(pltOne, "C:\\Users\\Mo\\work\\study\\2023-2024\\Математическое моделирование\\mathmod\\study_2023-2024_mathmod\\labs\\lab08\\report\\images\\lab8_2_short_Julia")


