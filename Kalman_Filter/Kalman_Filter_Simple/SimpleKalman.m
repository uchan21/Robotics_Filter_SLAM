function [volt,Px,K] = SimpleKalman(z)
persistent A H Q R
persistent firstRun
persistent x P

if isempty(firstRun)
    A=1;
    H=1;
    Q=0;
    R=4;

    x = 14;
    P = 6;

    firstRun = 1;
end

xp = A*x;
Pp = A*P*A' +Q;

K = Pp*H'/(H*Pp*H' + R);

x = xp+K*(z-H*xp);
P = Pp-K*H*Pp;

volt = x;
Px = P;