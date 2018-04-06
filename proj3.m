img = imread('painting.jpg');
I = flipdim(img ,1);
image(I);
set (gcf, 'WindowButtonMotionFcn', @mouseMove);
set(gca,'YDir','normal')

% calculate the vanishing point
x_p = [[[0,1,1],[1,1,1]];[[1,2,1],[2,2,1]]];
y_p = [[[0,1,1],[0,2,1]];[[1,1,1],[1,2,1]]];
z_p = [[[481,1113,1],[533,758,1]];[[271,1113,1],[392,905,1]]];

x_vpt = vanishingPT(x_p);
y_vpt = vanishingPT(y_p);
z_vpt = vanishingPT(z_p);

% specify reference plane
