using Plots
using DifferentialEquations

#Вариант 36
1032215135%70 + 1

#начальные значения
alpha = 0.01 #коэффициент заболеваемости
beta = 0.02 #коэффициент выздоровления

N = 12400 #общая численность популяции
I0 = 150 #количество инфицированных особей в начальный момент времени
R0 = 55 #количество здоровых особей с иммунитетом в начальный момент времени
S0 = N - I0 - R0 #количество восприимчивых к болезни особей в начальный момент времени

#случай, когда I(0)<=I*

function caseOne(du, u, p, t)
    S, I, R = u
    du[1] = 0
    du[2] = -beta * u[2]
    du[3] = beta * u[2]
end

#интервал временни и начальные значения
tspan = (0, 60)
u0 = [S0, I0, R0]

prob = ODEProblem(caseOne, u0, tspan)

sol = solve(prob, dtmax = 0.05)

S = [u[1] for u in sol.u]
I = [u[2] for u in sol.u]
R = [u[3] for u in sol.u]
Time = [t for t in sol.t]

pltOne = plot(dpi = 300, legend =:topright)

plot!(
    pltOne,
    Time,
    S,
    title = "Динамика изменения числа людей в каждой из трех групп в случае, когда I(0) <= I* ",
    titlefont = font(8,"Computer Modern"),
    label = "S(t)",
    color=:blue
    )
plot!(
    pltOne,
    Time,
    I,
    title = "Динамика изменения числа людей в каждой из трех групп в случае, когда I(0) <= I* ",
    titlefont = font(8,"Computer Modern"),
    label = "I(t)",
    color=:green
    )
plot!(
    pltOne,
    Time,
    R,
    title = "Динамика изменения числа людей в каждой из трех групп в случае, когда I(0) <= I* ",
    titlefont = font(8,"Computer Modern"),
    label = "R(t)",
    color=:red
    )

savefig(pltOne, "C:\\Users\\Mo\\work\\study\\2023-2024\\Математическое моделирование\\mathmod\\study_2023-2024_mathmod\\labs\\lab06\\report\\images\\lab6_1.png")


