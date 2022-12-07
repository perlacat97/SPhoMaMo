import("stereomodels.lib");

a_d = hslider( "Source angle [unit:°]", 0, -180 , 180 , .01) : si.smoo;
r_m = hslider( "Source distance [unit:m]", 1, 0 , 10 , .01) : si.smoo;

ortf(r_m, a_r) = _ <: left(r_m, a_r, d_m), right(r_m, a_r, d_m)
with{
  d_m = .17;
  delta(r_m, a_r, d_m) = sqrt(r_m^2 - d_m*r_m*cos(a_r+ma.PI/2) + d_m^2/4) - sqrt(r_m^2 + d_m*r_m*cos(a_r+ma.PI/2) + d_m^2/4);
  left(r_m, a_r, d_m) = _*(sin(ma.PI*11/36)*sin(a_r) + cos(ma.PI*11/36)*cos(a_r) + 1)/2: de.fdelay3(pm.l2s(d_m), pm.l2s(max(delta(r_m, a_r, d_m), 0)));
  right(r_m, a_r, d_m) = _*(cos(ma.PI*11/36)*cos(a_r) - sin(ma.PI*11/36)*sin(a_r) + 1)/2 : de.fdelay3(pm.l2s(d_m), pm.l2s(max(-delta(r_m, a_r, d_m), 0)));
};

dl(r,a,d) = sqrt((r*cos(a))^2+(r*sin(a)-d/2)^2);
dr(r,a,d) = sqrt((r*cos(a))^2+(r*sin(a)+d/2)^2);

ortf_att(r_m, a_r) = ortf(r_m, a_r) : _*(1/dl(r_m, a_r,d_m)), _*(1/dr(r_m, a_r,d_m));

process = os.osc(200) <: ortf_att(r_m, d2r(a_d));
