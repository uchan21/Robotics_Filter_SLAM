function [M_nowState,S_nowState] = Kalman_Filtering(M_preState,S_preState, M_preMotion, S_preMotion, M_nowMeas, S_nowMeas)
    x = [-20:.1:200];
    [M_predic,S_predic] = State_prediction(M_preState,S_preState,M_preMotion,S_preMotion);
    [M_nowState,S_nowState] = Measurement_update(M_predic,S_predic, M_nowMeas,S_nowMeas);

    y = normpdf(x,M_nowState,S_nowState);
    plot(x,y,"g"); hold on; % Filtering plot
end