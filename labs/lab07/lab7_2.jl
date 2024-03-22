using Plots
using DifferentialEquations

#начальные значения
a2 = 0.94 #коэф,отвечающий за платную рекламу
a1 = 0.000094 #коэф,отвечающий за платную рекламу
N = 1040 #максимальное количество людей, которых может заинтересовать товар
n0 = 9 #количество людей, знающих о товаре в начальный момент времени


#уравнение, описывающее распространение рекламы

function caseTwo(du, u, p, t)
    n = u
    du[1] = (a1 + a2*u[1])*(N - u[1])
end


#интервал временни и начальные значения
tspan = (0, 60)
u0 = [n0]


prob = ODEProblem(caseTwo, u0, tspan)

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
    color=:green
    )

# Находим момент времени, когда скорость распространения рекламы максимальна
max_dndt_ind = argmax([(0.0000094 + 0.94 * n_val) * (N - n_val) for n_val in n])
max_dndt_t = Time[max_dndt_ind]

result_array = [(0.000094 + 0.94 * n_val) * (N - n_val) for n_val in n]
println(result_array)

result_array = [(0.000094 + 0.94 * n_val) * (N - n_val) for n_val in n]
println(result_array)

sol(0.005319411243810851)


