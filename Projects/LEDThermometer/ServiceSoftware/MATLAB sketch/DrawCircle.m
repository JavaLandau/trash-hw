function H = DrawCircle(Coords, radius, Color, Ax)

th = 0:pi/50:2*pi;
X = radius * cos(th) + Coords(1);
Y = radius * sin(th) + Coords(2);

H = fill(X, Y, Color,'EdgeColor',Color,'Parent',Ax);