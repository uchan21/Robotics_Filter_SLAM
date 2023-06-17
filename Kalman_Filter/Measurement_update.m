function [m,s] = Measurement_update(m,s,M_meas,S_meas)
    x = [-20:.1:200];
    y = normpdf(x,M_meas,S_meas);
    plot(x,y,"b"); hold on; % Measurement plot

    m = (M_meas*s+m*S_meas)/(s+S_meas);
    s = (s*S_meas)/(s+S_meas);
end