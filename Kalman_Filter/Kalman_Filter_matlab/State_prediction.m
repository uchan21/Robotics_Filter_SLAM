function [m,s] = State_prediction(m, s, M_motion,S_motion)
    x = [-20:.1:200];
    m = m+M_motion;
    s = s+S_motion;

    y = normpdf(x,m,s);
    plot(x,y,"R"); hold on; % State_prediction plot
end