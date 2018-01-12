function AxArray = CreateAxes(Radius, Size, Coords, CurFig)

Red = [1 0 0];
Ambient = [0.992 0.918 0.796];

AxCircle = axes('Color',Ambient,'Units','centimeters',...
                'XColor',Ambient,'YColor',Ambient,'Parent',CurFig);
set(AxCircle,'Position',[Coords(1)-Radius/2 + Size(1)/2 Coords(2) Radius Radius]);
DrawCircle([0 0], Radius, Red, AxCircle);

set(AxCircle,'Color',Ambient,'Units','centimeters',...
             'XColor',Ambient,'YColor',Ambient,'XTick',[],'YTick',[]);
    
         
AxArray = zeros(size(-5:40));
for i = -5:40
    AxArray(i + 6) = axes('Color',Ambient,'Units','centimeters','XTick',[],'YTick',[],...
                          'XColor',Ambient,'YColor',Ambient,'Parent',CurFig);
    set(AxArray(i + 6),'Position',[Coords + (i + 5)*[0 Size(2)] + [0 Radius] Size]);
end