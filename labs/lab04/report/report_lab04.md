---
title: "Лабораторная работа №4"
subtitle: "Модель гармонических колебаний"
author: "Абу Сувейлим Мухаммед Мунифович"
lang: ru-RU
toc-title: "Содержание"
bibliography: bib/cite.bib
csl: pandoc/csl/gost-r-7-0-5-2008-numeric.csl
toc: true
toc-depth: 2
lof: true
lot: false
fontsize: 12pt
linestretch: 1.5
papersize: a4
documentclass: scrreprt
polyglossia-lang:
  name: russian
  options:
    - spelling=modern
    - babelshorthands=true
polyglossia-otherlangs:
  name: english
babel-lang: russian
babel-otherlangs: english
mainfont: PT Serif
romanfont: PT Serif
sansfont: PT Sans
monofont: PT Mono
mainfontoptions: Ligatures=TeX
romanfontoptions: Ligatures=TeX
sansfontoptions: Ligatures=TeX,Scale=MatchLowercase
monofontoptions: Scale=MatchLowercase,Scale=0.9
biblatex: true
biblio-style: "gost-numeric"
biblatexoptions:
  - parentracker=true
  - backend=biber
  - hyperref=auto
  - language=auto
  - autolang=other*
  - citestyle=gost-numeric
figureTitle: "Рис."
tableTitle: "Таблица"
listingTitle: "Листинг"
lofTitle: "Список иллюстраций"
lotTitle: "Список таблиц"
lolTitle: "Листинги"
indent: true
header-includes:
  - \usepackage{indentfirst}
  - \usepackage{float}
  - \floatplacement{figure}{H}
---


## Цель работы

- Целью работы является познокомится с моделью гармонических колебаний.

## Задание

1. Постройте фазовый портрет гармонического осциллятора и решение уравнения гармонического осциллятора для следующих случаев
   - Постройте фазовый портрет гармонического осциллятора и решение уравнения гармонического осциллятора для следующих случаев $\ddot x + 6x = 0$;

   - Колебания гармонического осциллятора c затуханием и без действий внешней силы $\ddot x + 6\dot x + 6x = 0$;

   - Колебания гармонического осциллятора c затуханием и без действий внешней силы $\ddot x + 6\dot x + 12x = \sin{6t}$.

На интервале $t \in [0, 60]$ (шаг 0.05) с начальными условиями $x_0 = 0.6$ и $y_0 = 1.6$

## Теоретическое введение

Гармонические колебания – это одно из основных понятий в физике, которое широко применяется для описания различных явлений и систем. Они характеризуются регулярным и повторяющимся движением вокруг равновесного положения. Гармонические колебания имеют важное значение в различных областях, включая механику, электродинамику, акустику и оптику.

## Выполнение лабораторной работы

### Модлеирование на языке программеровании Julia

#### Колебания гармонического осциллятора без затуханий и без действий внешней силы Julia

1. Во-первых, я использвал пакеты Plots и DifferentialEquations.

   ```Julia
   using Plots
   using DifferentialEquations
   ```

2. Инициализировал нужны нам константи и функции в моделии.
   w - частота; g - затухание; f(t) - внешняя сила, действующая на осциллятор. Вместо урванения второго порядка я написал систему из двух уравнений первого порядка caseOne.

   ```Julia
   #x'' + g * x' + w^2 * x = f(t)
   #для колебании гармонического осциллятора без затуханий и без действий внешней силы x'' + 6x = 0
   #g - затухание
   #w - частота
   #f(t) - внешняя сила, действующая на осциллятор

   w = 6
   g = 0
   #f(t) = 0

   function caseOne(du, u, p, t)
      x, y = u
      du[1] = u[2]  
      du[2] = -g*u[2] - w*u[1]
   end
   ```

3. Далее я обозначал наши начальные параметры, которые были нам данни в задании.

   ```Julia
   x0 = 0.6
   y0 = 1.6
   u0 = [x0, y0]
   tspan = (0, 60) #интервал временни
   ```

4. Теперь я начал решать диффернцалбное уравнение.

   ```Julia
   probOne = ODEProblem(caseOne, u0, tspan)
   ```

5. Осталось только решить ОДУ.

   ```Julia
   solOne = solve(probOne, dtmax = 0.05)
   ```

6. Здесь я переименавал названия переменных.

   ```Julia
   X = [u[1] for u in solOne.u]
   Y = [u[2] for u in solOne.u]
   Time = [t for t in solOne.t]
   ```

7. Далее я поготовил место для графиков.

   ```Julia
   plt = plot(layout = (1, 2), dpi = 300, legend = false)
   ```

8. Наконец, построил два графика.

   ```Julia
   plot!(
    plt[1], 
    Time, 
    X, 
    title = "Решение Уравнения", 
    color=:red)
   plot!(
    plt[2], 
    X, 
    Y, 
    title = "Фазовый Портрет", 
    color=:blue)
   ```

9. Получуные график.

   ![Case One Julia](./images/lab4_1.png){ width=50% }

#### Колебания гармонического осциллятора с затуханием и без действий внешней силы Julia


1. Во-первых, я использвал пакеты Plots и DifferentialEquations.

   ```Julia
   using Plots
   using DifferentialEquations
   ```

2. Инициализировал нужны нам константи и функции в моделии.
   w - частота; g - затухание; f(t) - внешняя сила, действующая на осциллятор. Вместо урванения второго порядка я написал систему из двух уравнений первого порядка caseOne.

   ```Julia
   #x'' + g * x' + w^2 * x = f(t)
   #для колебании гармонического осциллятора c затуханием и без действий внешней силы x'' + 6x' + 6x = 0
   #g - затухание
   #w - частота
   #f(t) - внешняя сила, действующая на осциллятор

   w = 6
   g = 6
   #f(t) = 0

   function caseTwo(du, u, p, t)
      x, y = u
      du[1] = u[2]  
      du[2] = -g*u[2] - w*u[1]
   end
   ```

3. Далее я обозначал наши начальные параметры, которые были нам данни в задании.

   ```Julia
   x0 = 0.6
   y0 = 1.6
   u0 = [x0, y0]
   tspan = (0, 60) #интервал временни
   ```

4. Теперь я начал решать диффернцалбное уравнение.

   ```Julia
   probTwo = ODEProblem(caseTwo, u0, tspan)
   ```

5. Осталось только решить ОДУ.

   ```Julia
   solTwo = solve(probTwo, dtmax = 0.05)
   ```

6. Здесь я переименавал названия переменных.

   ```Julia
   X = [u[1] for u in solTwo.u]
   Y = [u[2] for u in solTwo.u]
   Time = [t for t in solTwo.t]
   ```

7. Далее я поготовил место для графиков.

   ```Julia
   plt = plot(layout = (1, 2), dpi = 300, legend = false)
   ```

8. Наконец, построил два графика.

   ```Julia
   plot!(
    plt[1], 
    Time, 
    X, 
    title = "Решение Уравнения", 
    color=:red)
   plot!(
    plt[2], 
    X, 
    Y, 
    title = "Фазовый Портрет", 
    color=:blue)
   ```

9. Получуные график.

   ![Case Two Julia](./images/lab4_2.png){ width=50% }

#### Колебания гармонического осциллятора c затуханием и под действием внешней силы Julia

1. Во-первых, я использвал пакеты Plots и DifferentialEquations.

   ```Julia
   using Plots
   using DifferentialEquations
   ```

2. Инициализировал нужны нам константи и функции в моделии.
   w - частота; g - затухание; f(t) - внешняя сила, действующая на осциллятор. Вместо урванения второго порядка я написал систему из двух уравнений первого порядка caseOne.

   ```Julia
   #x'' + g * x' + w^2 * x = f(t)
   ##x'' = - g * x' - w^2 * x + f(t)
   #для колебании гармонического осциллятора c затуханием и без действий внешней силы x'' + 6x' + 12x = sin(6t)
   #g - затухание
   #w - частота
   #f(t) - внешняя сила, действующая на осциллятор

   w = 12
   g = 6
   ```

3. Далее я обозначал наши начальные параметры, которые были нам данни в задании.

   ```Julia
   x0 = 0.6
   y0 = 1.6
   u0 = [x0, y0]
   tspan = (0, 60) #интервал временни
   ```

4. Теперь я начал решать диффернцалбное уравнение.

   ```Julia
   probThree = ODEProblem(caseThree, u0, tspan)
   ```

5. Осталось только решить ОДУ.

   ```Julia
   solThree = solve(probThree, dtmax = 0.05)
   ```

6. Здесь я переименавал названия переменных.

   ```Julia
   X = [u[1] for u in solThree.u]
   Y = [u[2] for u in solThree.u]
   Time = [t for t in solThree.t]
   ```

7. Далее я поготовил место для графиков.

   ```Julia
   plt = plot(layout = (1, 2), dpi = 300, legend = false)
   ```

8. Наконец, построил два графика.

   ```Julia
   plot!(
    plt[1], 
    Time, 
    X, 
    title = "Решение Уравнения", 
    color=:red)
   plot!(
    plt[2], 
    X, 
    Y, 
    title = "Фазовый Портрет", 
    color=:blue)
   ```

9. Получуные график.

   ![Case Two Julia](./images/lab4_3.png){ width=50% }

### Модлеирование на языке программеровании OpenModelica

#### Колебания гармонического осциллятора без затуханий и без действий внешней силы OpenModelica

1. В OpenModelica все прощее. Я просто переписал код из Julia. В этой прошраиие все величины имею тот же смысл, что и в Julia.

   ```OpenModelica
   model lab4_1
   Real x;
   Real y;
   Real w = 6;
   Real g = 0;
   Real t = time;

   initial equation

   x = 0.6;
   y = 1.6;

   equation

   der(x) = y;
   der(y) = - g*y - w*x;

   end lab4_1;
   ```

2. График в OpenModelica указывает на решению уравнений и фазовый портрет.

   ![OpenModelica Case One Graph Equation solution](./images/lab4_1_1_OM.png){ width=50% }
   ![OpenModelica Case One Graph phase portrait](./images/lab4_1_2_OM.png){ width=50% }

#### Колебания гармонического осциллятора с затуханием и без действий внешней силы OpenModelica

1. График в OpenModelica указывает на решению уравнений и фазовый портрет.

   ![OpenModelica Case One Graph Equation solution](./images/lab4_2_1_OM.png){ width=50% }
   ![OpenModelica Case One Graph phase portrait](./images/lab4_2_2_OM.png){ width=50% }

#### Колебания гармонического осциллятора с затуханием и под действием внешней силы OpenModelica

1. График в OpenModelica указывает на решению уравнений и фазовый портрет.

   ![OpenModelica Case One Graph Equation solution](./images/lab4_3_1_OM.png){ width=50% }
   ![OpenModelica Case One Graph phase portrait](./images/lab4_3_2_OM.png){ width=50% }

## Исходный код

### Julia

1. Колебания гармонического осциллятора без затуханий и без действий внешней силы

   ``` Julia
   using Plots
   using DifferentialEquations

   #x'' + g * x' + w^2 * x = f(t)
   #для колебании гармонического осциллятора без затуханий и без действий внешней силы x'' + 6x = 0
   #g - затухание
   #w - частота
   #f(t) - внешняя сила, действующая на осциллятор

   w = 6
   g = 0
   #f(t) = 0

   function caseOne(du, u, p, t)
      x, y = u
      du[1] = u[2]  
      du[2] = -g*u[2] - w*u[1]
   end
   x0 = 0.6
   y0 = 1.6
   u0 = [x0, y0]
   tspan = (0, 60) #интервал временни
   probOne = ODEProblem(caseOne, u0, tspan)
   solOne = solve(probOne, dtmax = 0.05)
   X = [u[1] for u in solOne.u]
   Y = [u[2] for u in solOne.u]
   Time = [t for t in solOne.t]
   plt = plot(layout = (1, 2), dpi = 300, legend = false)
   plot!(
      plt[1], 
      Time, 
      X, 
      title = "Решение Уравнения", 
      color=:red)
   plot!(
      plt[2], 
      X, 
      Y, 
      title = "Фазовый Портрет", 
      color=:blue)
   ```

2. Колебания гармонического осциллятора c затуханием и без действий внешней силы

   ``` Julia
   using Plots
   using DifferentialEquations
   #x'' + g * x' + w^2 * x = f(t)
   #для колебании гармонического осциллятора без затуханий и без действий внешней силы x'' + 6x' + 6x = 0
   #g - затухание
   #w - частота
   #f(t) - внешняя сила, действующая на осциллятор

   w = 6
   g = 6
   #f(t) = 0

   function caseTwo(du, u, p, t)
      x, y = u
      du[1] = u[2]  
      du[2] = -g*u[2] - w*u[1]
   end
   x0 = 0.6
   y0 = 1.6
   u0 = [x0, y0]
   tspan = (0, 60) #интервал временни
   probTwo = ODEProblem(caseTwo, u0, tspan)
   solTwo = solve(probTwo, dtmax = 0.05)
   X = [u[1] for u in solTwo.u]
   Y = [u[2] for u in solTwo.u]
   Time = [t for t in solTwo.t]
   plt = plot(layout = (1, 2), dpi = 300, legend = false)
   plot!(
      plt[1], 
      Time, 
      X, 
      title = "Решение Уравнения", 
      color=:red)
   plot!(
      plt[2], 
      X, 
      Y, 
      title = "Фазовый Портрет", 
      color=:blue)
   ```

3. Колебания гармонического осциллятора c затуханием и под действием внешней силы.

   ```Julia
   using Plots
   using DifferentialEquations
   #x'' + g * x' + w^2 * x = f(t)
   #для колебании гармонического осциллятора без затуханий и без действий внешней силы x'' + 6x' + 12x = sin(6t)
   #g - затухание
   #w - частота
   #f(t) - внешняя сила, действующая на осциллятор

   w = 12
   g = 6

   function caseThree(du, u, p, t)
      x, y = u
      du[1] = u[2]  
      du[2] = sin(6*t) -g*u[2] - w*u[1]
   end
   x0 = 0.6
   y0 = 1.6
   u0 = [x0, y0]
   tspan = (0, 60) #интервал временни
   probThree = ODEProblem(caseThree, u0, tspan)
   solThree = solve(probThree, dtmax = 0.05)
   X = [u[1] for u in solThree.u]
   Y = [u[2] for u in solThree.u]
   Time = [t for t in solThree.t]
   plt = plot(layout = (1, 2), dpi = 300, legend = false)
   plot!(
      plt[1], 
      Time, 
      X, 
      title = "Решение Уравнения", 
      color=:red)
   plot!(
      plt[2], 
      X, 
      Y, 
      title = "Фазовый Портрет", 
      color=:blue)
   ```

### OpenModelica

1. Колебания гармонического осциллятора без затуханий и без действий внешней силы

   ``` OpenModelica
   model lab4_1
   Real x;
   Real y;
   Real w = 6;
   Real g = 0;
   Real t = time;

   initial equation

   x = 0.6;
   y = 1.6;

   equation

   der(x) = y;
   der(y) = - g*y - w*x;

   end lab4_1;
   ```

2. Колебания гармонического осциллятора c затуханием и без действий внешней силы 

   ``` OpenModelica
   model lab4_2

   Real x;
   Real y;
   Real w = 6;
   Real g = 6;
   Real t = time;

   initial equation

   x = 0.6;
   y = 1.6;

   equation

   der(x) = y;
   der(y) = - g*y - w*x;

   end lab4_2;
   ```

3. Колебания гармонического осциллятора c затуханием и под действием внешней силы

   ```OpenModelica
   model lab4_3

   Real x;
   Real y;
   Real w = 12;
   Real g = 6;
   Real t = time;

   initial equation

   x = 0.6;
   y = 1.6;

   equation

   der(x) = y;
   der(y) = sin(6*t) - g*y - w*x;

   end lab4_3;
   ```

## Вывод

- Движение грузика на пружинке, а также эволюция во времени многих систем можно описать одним и тем же дифференциальным уравнением, которое в теории колебаний выступает в качестве основной модели
- Можно построить моделт гармонического колебаний осциллятора без затуханий / с затуханием и без действий / под действием внешней силы

## Библиография

1. Julia 1.10 Documentation // Julia URL: <https://docs.julialang.org/en/v1/> (дата обращения: 24.02.2024).

2. Медведев Д. А., Куперштох А. Л., Прууэл Э. Р., Сатонкина Н. П., Карпов Д. И. Моделирование физических
процессов и явлений на ПК: Учеб. пособие / Новосибирск: Новосиб. гос. ун-т., 2010. — 101 с
