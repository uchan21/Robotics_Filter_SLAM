%% set initial state

bel0_Open = 0.5; % initial state = open
bel0_Closed = 0.5; % initial state = closed

%% set noise
p_SenOp_open = 0.6; % when Door open, Sense open
p_SenClo_open = 0.4; % Sense close

p_SenOp_close = 0.2; % when Door close, Sense open
p_SenClo_close = 0.8; % Sense close

%% set state transition
p_Open_at_push_open = 1; % when Door open and robot push the door, than probability of Door'state open
p_Close_at_push_open = 0; % ~ , than probability of Door close
p_Open_at_push_close = 0.8; % when Door close and robot push the door, than probabilty of Door open
p_Close_at_push_close = 0.2; % ~ , than probability of Door close

p_Open_at_not_open = 1; % Door open and do nothing, than Door open
p_Close_at_not_open = 0; % Door open and do nothing, than Door close
p_Open_at_not_close = 0; % Door close and do nothing, than Door open
p_Close_at_not_close = 1; % Door close and do nothing, than Door Close

%% Bayes Filtering
% 1st Control Update
bel_ControlUp_x1_Open = p_Open_at_not_open*bel0_Open + p_Open_at_not_close*bel0_Closed; % When Final state is Open, probability of all cases
bel_ControlUp_x1_Close = p_Close_at_not_open*bel0_Open + p_Close_at_not_close*bel0_Closed; % When Final state is Close, probability of all cases

% 1st Measurement Update
bel_MeasureUp_x1_Open = p_SenOp_open*bel_ControlUp_x1_Open; % When Door Open, Sense Open
bel_MeasureUp_x1_Close = p_SenOp_close*bel_ControlUp_x1_Close; % When Door Close, Sense Open

normal_x1 = (bel_MeasureUp_x1_Open + bel_MeasureUp_x1_Close)^-1; % normalization

bel_MeasureUp_x1_Open = normal_x1*bel_MeasureUp_x1_Open;
bel_MeasureUp_x1_Close = normal_x1*bel_MeasureUp_x1_Close;

% 2nd Control Update
bel_ControlUp_x2_Open = p_Open_at_push_open * bel_MeasureUp_x1_Open + p_Open_at_push_close*bel_MeasureUp_x1_Close;
bel_ControlUp_x2_Close = p_Close_at_push_open* bel_MeasureUp_x1_Open + p_Close_at_push_close*bel_MeasureUp_x1_Close;

% 2nd Measurement Update
bel_MeasureUp_x2_Open = p_SenOp_open*bel_ControlUp_x2_Open;
bel_MeasureUp_x2_Close = p_SenOp_close*bel_ControlUp_x2_Close;

normal_x2 = (bel_MeasureUp_x2_Open+bel_MeasureUp_x2_Close)^-1;

bel_MeasureUp_x2_Open = normal_x2 *bel_MeasureUp_x2_Open;
bel_MeasureUp_x2_Close = normal_x2*bel_MeasureUp_x2_Close;

%% figure
figure; hold on; grid off;

Open = [bel0_Open bel_MeasureUp_x1_Open bel_MeasureUp_x2_Open];
Close = [bel0_Closed bel_MeasureUp_x1_Close bel_MeasureUp_x2_Close];
x = 1:1:size(Open,2);

plot(x,Open,'--*');plot(x,Close,'--o'); legend('Probability of Sensing Open','Probability of Sensing Close'); xlabel('Count'); ylabel('belief')