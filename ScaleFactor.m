function [ a,b,c ] = ScaleFactor(x,y,z,vx,vy,vz,refx,refy,refz,o)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
a = (refx-o)/(vx-refx)/x;

b = (refy-o)/(vy-refy)/y;

c = (refz-o)/(vz-refz)/z;



end

