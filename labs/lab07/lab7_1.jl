using Plots
using DifferentialEquations

#начальные значения
a1 = 0.94 #коэф,отвечающий за платную рекламу
a2 = 0.000094 #коэф,отвечающий за платную рекламу
N = 1040 #максимальное количество людей, которых может заинтересовать товар
n0 = 9 #количество людей, знающих о товаре в начальный момент времени

#уравнение, описывающее распространение рекламы

function caseOne(du, u, p, t)
    n = u
    du[1] = (a1 + a2*u[1])*(N - u[1])
end

#интервал временни и начальные значения
tspan = (0, 60)
u0 = [n0]

prob = ODEProblem(caseOne, u0, tspan)

sol = solve(prob, dtmax = 0.05)

n = [u[1] for u in sol.u]
Time = [t for t in sol.t]

pltOne = plot(dpi = 300, legend = false)

plot!(
    pltOne,
    Time,
    n,
    title = "График распространения информации о товаре с учетом платной
рекламы и с учетом сарафанного радио",
    titlefont = font(8),
    xlabel = "Время",
    ylabel = "n(t) - количество людей, знающих о товаре
    в момент времени t",
    guidefontsize=8,
    color=:red
    )

savefig(pltOne, "C:\\Users\\Mo\\work\\study\\2023-2024\\Математическое моделирование\\mathmod\\study_2023-2024_mathmod\\labs\\lab07\\images\\lab7_1_Julia")


