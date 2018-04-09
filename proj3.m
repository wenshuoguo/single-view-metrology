img = imread('sample.bmp');
I = flipdim(img ,1);
[height,width,chn] = size(img);
image(I);
set (gcf, 'WindowButtonMotionFcn', @mouseMove);
set(gca,'YDir','normal')

% calculate the vanishing point
x_p = [[[391,542,w],[174,366,w]];[[393,399,w],[162,227,w]];[[618,290,w],[379,139,w]]];
y_p = [[[391,542,w],[606,431,w]];[[393,399,w],[618,290,w]];[[162,227,w],[379,139,w]]];
z_p = [[[391,542,w],[393,399,w]];[[174,366,w],[162,227,w]];[[606,431,w],[618,290,w]]];

x_vpt = vanishingPT(x_p)
y_vpt = vanishingPT(y_p)
z_vpt = vanishingPT(z_p)

x_vpt = x_vpt/x_vpt(3)
y_vpt = y_vpt/y_vpt(3)
z_vpt = z_vpt/z_vpt(3)

o = [391,542,1];
%specify three reference points which locates at x,y,z axis respectively
refx = [505,363,1];
refy = [460,350,1];
refz = [477,378,1];
%[a,b,c] = ScaleFactor(1,1,1,x_vpt,y_vpt,z_vpt,refx,refy,refz,o);


% specify reference plane
