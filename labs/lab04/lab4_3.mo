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
