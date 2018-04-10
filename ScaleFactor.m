function [ a,b,c ] = ScaleFactor(x,y,z,vx,vy,vz,refx,refy,refz,o)

a = (refx-o)/(transpose(vx)-refx)/x;

b = (refy-o)/(transpose(vy)-refy)/y;

c = (refz-o)/(transpose(vz)-refz)/z;



end

