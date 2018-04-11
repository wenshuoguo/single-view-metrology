img = imread('cube.jpg');
%img = flipdim(img ,1);
[height,width,chn] = size(img);
image(img);
set (gcf, 'WindowButtonMotionFcn', @mouseMove);
%set (gcf,'WindowButtonDownFcn',@mouseClick);

disp('Please indicate 6 points,each 2 for a line to calculate vx');
[x,y] = ginput(6)
w = 1;

% calculate the vanishing point
x_p = [[[x(1),y(1),w],[x(2),y(2),w]];[[x(3),y(3),w],[x(4),y(4),w]];[[x(5),y(5),w],[x(6),y(6),w]]];
x_vpt = vanishingPT(x_p);

disp('Please indicate 6 points,each 2 for a line to calculate vy');
[x,y] = ginput(6)
y_p = [[[x(1),y(1),w],[x(2),y(2),w]];[[x(3),y(3),w],[x(4),y(4),w]];[[x(5),y(5),w],[x(6),y(6),w]]];
y_vpt = vanishingPT(y_p);

disp('Please indicate 6 points,each 2 for a line to calculate vz');
[x,y] = ginput(6)
z_p = [[[x(1),y(1),w],[x(2),y(2),w]];[[x(3),y(3),w],[x(4),y(4),w]];[[x(5),y(5),w],[x(6),y(6),w]]];
z_vpt = vanishingPT(z_p);
 
x_vpt = x_vpt/x_vpt(3)
y_vpt = y_vpt/y_vpt(3)
z_vpt = z_vpt/z_vpt(3)

disp('Please click the origin');
[x,y] = ginput(1)
o = [x(1),y(1),1];

disp('specify three reference points which locates at x,y,z axis respectively')
[x,y] = ginput(3);
refx = [x(1),y(1),1];
refy = [x(2),y(2),1];
refz = [x(3),y(3),1];

X = input('specify real X');
Y = input('specify real Y');
Z = input('specify real Z');
[a,b,c] = ScaleFactor(X,Y,Z,x_vpt,y_vpt,z_vpt,refx,refy,refz,o);

% proj_H = [a*x_vpt,b*y_vpt,c*z_vpt,transpose(o)];

H_xy = inv([a*x_vpt,b*y_vpt,transpose(o)]);

H_xz = inv([a*x_vpt,c*z_vpt,transpose(o)]);

H_yz = inv([c*z_vpt,b*y_vpt,transpose(o)]);

% texture mapping

xy_texture = texture2(img,H_xy);
xz_texture = texture2(img,H_xz);
yz_texture = texture2(img,H_yz);

imwrite(uint8(xy_texture),'xy.jpg');
imwrite(uint8(xz_texture),'xz.jpg');
imwrite(uint8(yz_texture),'yz.jpg');

ans = input('Please crop your photo and rename it')

disp('specify ruler B & R points')
[x,y] = ginput(2);
rulerB = ceil([x(1),y(1),1])
rulerR = ceil([x(2),y(2),1])

R = input('specify R');

%construct a table to store the 3d coor of all pts in image
% threeD = zeros(height,width,3);


%construct a straight line

slope = (rulerB(2)-rulerR(2))/(rulerB(1)-rulerR(1));
% 
% 
xmin = min(rulerB(1),rulerR(1));
xmax = max(rulerB(1),rulerR(1));
% 
if(rulerB(1)<rulerR(1))
     xminy = rulerB(2);
else
     xminy = rulerR(2);
end

% mmax = input('max height of z0 plane');
% nmax = input('max width of z0 plane');
% for i = xmin:xmax
%     if slope ~= Inf
%         j = ceil(slope*(i-xmin)+xminy);
%     else 
%         j = ceil(xminy + 1);
%     end
    
%     disp('debug')
%     disp(rulerB)
%     disp(rulerR)
%     disp(slope)
%    disp(j)
%     t = [i,j,1];
%     h = (norm(t-rulerB)*norm(z_vpt-transpose(rulerR)))/(norm(rulerR-rulerB)*norm(z_vpt-transpose(t)))*R;
%     z0 = [0,0,h];
%     threeD(i,j,1:3) = z0;
    
    %planar perspective map Hz
%     Hz = [a*x_vpt,b*y_vpt,c*z0*z_vpt+transpose(o)];
    
    %tranverse through the Hz 3D plane
%     for m = 1:mmax
%         for n = 1:nmax
%             pixel = Hz*transpose([m,n,1]);
%             pixel = ceil(pixel/pixel(3));
%             if pixel(1)>0 && pixel(1)<height && pixel(2)>0 && pixel(2)<width
%                 threeD(pixel(1),pixel(2),1:3) = [m,n,h];
%             end
%         end
%     end
% end

%now select the point to generate .wrl file
n = input('Please indicate the number to textures');
allPts = [];
for i=1:n
    disp('Select 8 pts for one texture');
    [x,y] = ginput(8)

    for j=1:4
        
        target = [ceil(x(2*j-1)),ceil(y(2*j-1)),1];
        xClick = x(2*j)
        yClick = y(2*j)
        
        %if slope == inf
            t = [xmin,yClick,1];
        %else
         %   t = [xClick,ceil(slope*(xClick-xmin)+xminy),1];
        %end
        
        h = (norm(t-rulerB)*norm(z_vpt-transpose(rulerR)))/(norm(rulerR-rulerB)*norm(z_vpt-transpose(t)))*R;
        z0 = [0,0,h]
        
        %planar perspective map Hz
        Hz = [a*x_vpt,b*y_vpt,c*h*z_vpt+transpose(o)];
        target_3D = inv(Hz)*transpose(target)
        target_3D = target_3D/target_3D(3)
        target_3D = transpose(target_3D);
        target_3D(3) = h;
        temp = target_3D(1);
        target_3D(1) = target_3D(2);
        target_3D(2) = temp;
     
        allPts = [allPts;target_3D];
    end
end
%normalize allPts
max_all = max(allPts(:));
allPts = allPts/max_all;
savewrl('cube',n,allPts);

    

