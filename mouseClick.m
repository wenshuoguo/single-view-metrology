function mouseClick(hObject,~)
    mousePos=get(gca,'CurrentPoint');
    disp(['You clicked X:',num2str(mousePos(1,1)),',  Y:',num2str(mousePos(1,2))]);
%set(gca,'YDir','normal')
    ClickX = mousePos(1,1);
    ClickY = mousePos(1,2);
end
