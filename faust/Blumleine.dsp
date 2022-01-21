import("stdfaust.lib");
//card = _<: (omni+fig_8)/2;
p = hslider("Midpolar pattern", 0.5, 0, 1 , .001) : 
si.smoo;
d = hslider( "Source angle", 0, -180 , 180 , .1) : 
si.smoo;

d2r(a) = a*ma.PI/180; 


left(r) = _*(sin(r) + cos(r)) *1/sqrt (2);
right(r) = _*(cos(r) - sin(r)) *1/sqrt (2);
blumlein(r) = _ <: left(r), right(r);
process = os.osc(1000) : blumlein(d2r(d));
