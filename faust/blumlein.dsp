import("stereomodels.lib");
p = hslider("Midpolar pattern", 0.5, 0, 1 , .001) : si.smoo;
d = hslider( "Source angle", 0, -180 , 180 , .1) : si.smoo;
process = os.osc(1000) : blumlein(d2r(-d));
