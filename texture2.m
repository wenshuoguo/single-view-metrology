function [output] = texture2(img,H)
[height,width,~] = size(img);
%600 800 3


%vertex
pt1 = [1,1,1];
pt2 = [1,height,1];
pt3 = [width,1,1];
pt4 = [width,height,1];

%disp('debug')
pixel1 = H*transpose(pt1);
%disp(pixel1)
pixel1 = ceil(pixel1/pixel1(3));
pixel2 = H*transpose(pt2);
%disp(pixel2)
pixel2 = ceil(pixel2/pixel2(3));
pixel3 = H*transpose(pt3);
%disp(pixel3)
pixel3 = ceil(pixel3/pixel3(3));
pixel4 = H*transpose(pt4);
%disp(pixel4)
pixel4 = ceil(pixel4/pixel4(3));

%shift output(i,j)
xmin = min([pixel1(1) pixel2(1) pixel3(1) pixel4(1)]);
ymin = min([pixel1(2) pixel2(2) pixel3(2) pixel4(2)]);
xshift = 0;
yshift = 0;

if(xmin<=0)
    xshift = xmin;
    pixel1(1) = pixel1(1)-xmin+1;
    pixel2(1) = pixel2(1)-xmin+1;
    pixel3(1) = pixel3(1)-xmin+1;
    pixel4(1) = pixel4(1)-xmin+1;
end

if(ymin<=0)
    yshift = ymin;
    pixel1(2) = pixel1(2)-ymin+1;
    pixel2(2) = pixel2(2)-ymin+1;
    pixel3(2) = pixel3(2)-ymin+1;
    pixel4(2) = pixel4(2)-ymin+1;
end  

xmin = min([pixel1(1) pixel2(1) pixel3(1) pixel4(1)]);
ymin = min([pixel1(2) pixel2(2) pixel3(2) pixel4(2)]);
xmax = max([pixel1(1) pixel2(1) pixel3(1) pixel4(1)]);
ymax = max([pixel1(2) pixel2(2) pixel3(2) pixel4(2)]);
disp('debug')
disp(xmin)
disp(xmax)
disp(ymin)
disp(ymax)
disp(pixel1)
disp(pixel2)
disp(pixel3)
disp(pixel4)

%color vertex to white
output = zeros(ymax,xmax,3);
output(pixel1(2),pixel1(1),1:3) = [1 1 1];
output(pixel2(2),pixel2(1),1:3) = [1 1 1];
output(pixel3(2),pixel3(1),1:3) = [1 1 1];
output(pixel4(2),pixel4(1),1:3) = [1 1 1];

%color side
%1-2-4-3
output = side(output, pixel1,pixel2);
output = side(output, pixel2,pixel4);
output = side(output, pixel4,pixel3);
output = side(output, pixel3,pixel1);

%fill hole
output2 = rgb2gray(output);
output2 = imbinarize(output2);
output2 = imfill(output2,'holes');
%imshow(output2);


%color output
for j=1:ymax
    for i=1:xmax
        if output2(j,i) == 1
            j0 = j + yshift-1;
            i0 = i + xshift-1;
            pt = inv(H)*transpose([i0,j0,1]);
            pt = ceil(pt/pt(3));

            if pt(1)<width && pt(2)<height && pt(1)>0 && pt(2)>0
                output(j,i,1:3) = img(pt(2),pt(1), 1:3);
            end
        end
    end
end
%imshow(uint8(output));

end