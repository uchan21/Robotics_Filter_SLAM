clear all
dt = 0.2;
t = 0:dt:10;
Nsamples = length(t);
Xsaved = zeros(Nsamples,3);
Zsaved = zeros(Nsamples,1);

for k = 1:Nsamples
    z = GetVolt();
    [volt, Cov, Kg] = SimpleKalman(z);
    Xsaved(k,:) = [volt Cov Kg];
    Zsaved(k) = z;

end

figure
plot(t,Xsaved(:,1),'o-')
hold on;
plot(t,Zsaved,'r:*')
xlabel('Time[sec]')
ylabel('Voltage[V]')
legend('KalmanFilter','Measurements')

figure
plot(t,Xsaved(:,2),'o-')
xlabel('Time [sec]')
ylabel('Variance')

figure
plot(t,Xsaved(:,3),'o-')
xlabel('Time [sec]')
ylabel('Kalman gain')