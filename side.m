function out1 = side(out0, pt1, pt2)
x1 = pt1(1);
y1 = pt1(2);
x2 = pt2(1);
y2 = pt2(2);

out1 = out0;
for i = min([x1 x2]): max([x1 x2])
    j = ceil(((y2-y1)/(x2-x1))*i + (y1*x2-y2*x1)/(x2-x1));
    out1(j,i,1:3) = [1 1 1];
end

for j = min([y1 y2]): max([y1 y2])
    i = ceil(((x2-x1)/(y2-y1))*j + (x1*y2-x2*y1)/(y2-y1));
    out1(j,i,1:3) = [1 1 1];
   
end
end