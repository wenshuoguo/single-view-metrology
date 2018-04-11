img = imread('sample.bmp');
%img = flipdim(img ,1);
[height,width,chn] = size(img);
image(img);
set (gcf, 'WindowButtonMotionFcn', @mouseMove);
%set(gca,'YDir','normal')

w = 1;

% calculate the vanishing point
x_p = [[[391,542,w],[174,366,w]];[[393,399,w],[162,227,w]];[[618,290,w],[379,139,w]]];
y_p = [[[391,542,w],[606,431,w]];[[393,399,w],[618,290,w]];[[162,227,w],[379,139,w]]];
z_p = [[[391,542,w],[393,399,w]];[[174,366,w],[162,227,w]];[[606,431,w],[618,290,w]];[[382,277,w],[379,139,w]]];

x_vpt = vanishingPT(x_p);
y_vpt = vanishingPT(y_p);
z_vpt = vanishingPT(z_p);

x_vpt = x_vpt/x_vpt(3);
y_vpt = y_vpt/y_vpt(3);
z_vpt = z_vpt/z_vpt(3);

o = [391,542,1];
%specify three reference points which locates at x,y,z axis respectively
refx = [174,366,1];
refy = [606,431,1];
refz = [393,399,1];
[a,b,c] = ScaleFactor(401,297,186,x_vpt,y_vpt,z_vpt,refx,refy,refz,o);

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

% specify interesting points
rulerB = [391,542,1];
rulerR = [393,399,1];

%construct a table to store the 3d coor of all pts in image
threeD = zeros(height,width,3);

%construct a straight line
slope = (rulerB(2)-rulerR(2))/(rulerB(1)-rulerR(1));

xmin = min(rulerB(1),rulerR(1));
xmax = max(rulerB(1),rulerR(1));

if(rulerB(1)<rulerR(1))
    xminy = rulerB(2);
else
    xminy = rulerR(2);
end

for i = xmin:xmax
    j = ceil(slope*(i-xmin)+xminy);
    t = [i,j,1];
    h = (norm(t-rulerB)*norm(z_vpt-transpose(rulerR)))/(norm(rulerR-rulerB)*norm(z_vpt-transpose(t)))*186;
    z0 = [0,0,h];
    threeD(i,j,1:3) = z0;
    
    %planar perspective map Hz
    Hz = [a*x_vpt,b*y_vpt,c*z0*z_vpt+transpose(o)];
    
    %tranverse through the Hz 3D plane
    for m = 1:401
        for n = 1:297
            pixel = Hz*transpose([m,n,1]);
            pixel = ceil(pixel/pixel(3));
            threeD(pixel(1),pixel(2),1:3) = [m,n,h];
        end
    end
end


    

