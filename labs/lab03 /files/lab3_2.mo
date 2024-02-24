model lab3_2

Real x; 
Real y; 

Real a = 0.343; 
Real b = 0.895; 
Real c = 0.699; 
Real h = 0.433;
Real t = time;

initial equation
x = 22022;
y = 33033;

equation
der(x) = -a*x - b*y + 2*sin(2*t);
der(y) = -c*x*y -b*y + 2*cos(t);

end lab3_2;
