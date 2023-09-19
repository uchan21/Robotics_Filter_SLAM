function [z, vel] = GetPos()

persistent Velp Posp

if isempty(Posp)
    Posp=0;
    Velp = 80;
end

dt = 0.1;
w = 0+randn;
v = 0+3*randn;

z = Posp + Velp*dt+v;
Posp = z-v;
Velp = 80+w;
vel = Velp;