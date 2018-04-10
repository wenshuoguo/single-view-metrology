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

H_xy = inv([a*x_vpt,b*y_vpt,transpose(o)])

%H_xy*[401;1;1]

%a = H_xy*transpose([174,366,1])
%a = a/a(3)
% texture mapping
xy_texture = texture2(img,H_xy);
