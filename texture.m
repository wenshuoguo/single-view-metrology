function [output] = texture(img,H)
[height,width,chn] = size(img);

y_all = zeros(height,width);
x_all = zeros(height,width);

for i=1:height
    for j=1:width
        %retrieve this point's corresponding pixel
        pt = [j,i,1];
        pixel = H*transpose(pt);
        pixel = ceil(pixel/pixel(3));
        
        x_all(i,j) = pixel(1);
        y_all(i,j) = pixel(2);

    end
end

%normalize output(i,j)
xmin = min(x_all(:));
ymin = min(y_all(:));

if(xmin<=0)
    x_all = x_all-xmin+1;
end
if(ymin<=0)
    y_all = y_all-ymin+1;
end

xmin = min(x_all(:));
ymin = min(y_all(:));
xmax = max(x_all(:));
ymax = max(y_all(:));

output = zeros(xmax,ymax,3);
for i=1:height
    for j=1:width
        output(x_all(i,j),y_all(i,j),1:3) = img(i,j,1:3);
    end
end

%for i=2:xmax-1
 %   for j=2:ymax-1
        %if(output(i,j,1:3)==0)
        %output(i,j,1:3) = (output(i-1,j-1,1:3)+output(i+1,j-1,1:3)+output(i-1,j+1,1:3)+output(i+1,j+1,1:3))/4;
        %count = (output(i-1,j-1,1:3)~=0)+(output(i+1,j-1,1:3)~=0)+(output(i-1,j+1,1:3)~=0)+(output(i+1,j+1,1:3)~=0);
        %if(count)
        %output(i,j,1:3) = output(i,j,1:3)./count;
  %      end
        
   %     end
  %  end
%end
output=imfill(output);
imshow(uint8(output));
end

