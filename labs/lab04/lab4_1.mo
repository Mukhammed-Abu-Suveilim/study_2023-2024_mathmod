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
