import("stereomodels.lib");

a_d = hslider( "Source angle [unit:°]", 0, -180 , 180 , .1) : si.smoo;
r_m = hslider( "Source distance [unit:m]", 1, 0 , 10 , .1) : si.smoo;

ortf(r_m, a_r) = _ <: left(r_m, a_r, d_m), right(r_m, a_r, d_m)
with{
  d_m = .17;
  delta(r_m, a_r, d_m) = sqrt(r_m^2 - d_m*r_m*cos(a_r) + d_m^2/4) - sqrt(r_m^2 + d_m*r_m*cos(a_d) + d_m^2/4);
  left(r_m, a_r, d_m) = _*(sin(ma.PI*11/36)*sin(a_r) + cos(ma.PI*11/36)*cos(a_r) + 1)/2 : de.fdelay3(pm.l2s(d_m), max(delta(r_m, a_r, d_m), 0));
  right(r_m, a_r, d_m) = _*(cos(ma.PI*11/36)*cos(a_r) - sin(ma.PI*11/36)*sin(a_r) + 1)/2 : de.fdelay3(pm.l2s(d_m), max(-delta(r_m, a_r, d_m), 0));
};

process = 1 : ortf(r_m, d2r(-a_d));