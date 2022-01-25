import("stereomodels.lib");
d = hslider( "Source angle", 0, -180 , 180 , .1) : si.smoo;
process = os.osc(1000) : xy90(d2r(-d));