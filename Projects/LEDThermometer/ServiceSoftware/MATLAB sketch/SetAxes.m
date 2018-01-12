function SetAxes(AxArray, Value)

Red = [1 0 0];
Ambient = [0.992 0.918 0.796];

for i = 1:Value
    set(AxArray(i),'Color',Red,'XColor',Red,'YColor',Red);
end

for i = (Value + 1):length(AxArray)
    set(AxArray(i),'Color',Ambient,'XColor',Ambient,'YColor',Ambient);
end