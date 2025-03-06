
k = -10:0.01:10;    %Vektor k

w_s = 2*pi*50;  %cut-off frequency in Hz
w_c = 2*pi*1e3;    % carrier-Frequency in Hz
T_a = (2*pi/w_s)/2;    %sampling period in s
A = 1;  %Amplitude of carrier in Volt
phi = 0;    %Phase of carrier in grad
m_AM = 1; %Modulation grad m_AM = -min(s(t)) <= 1;

s_kTa = cos(w_s.*k*T_a);    %source signal s(t)=cos(w_s*t)
m_kTa = A*cos(w_c.*k*T_a + phi);  %carrier signal who carry the source signal to high frequency, m(t) = A*cos(w_c*t + phi)
X_kTa = (1 + m_AM.*s_kTa).*m_kTa;    %amplitude modulated Signal Xam_(t)=A(1+m_AMs(t))cos(wc.t + phi);

%Generierung von s(t) und Xam(t)
subplot(2,1,1);
plot(k,s_kTa, 'DisplayName', 's(t)');
[up,lo]=envelope(s_kTa,100,'analytic');
hold on
plot(k,up, '--', 'linewidth', 1.5, 'DisplayName', 'Pos envelope')
plot(k,lo, '--', 'linewidth', 1.5, 'DisplayName', 'Neg envelope')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')
legend;
grid on;
hold off

subplot(2,1,2);
plot(k,X_kTa, 'DisplayName', 'Xam(t)');
[up2,lo2]=envelope(X_kTa,100,'analytic');
hold on
plot(k,up2, '--', 'linewidth', 1.5, 'DisplayName', 'Pos envelope')
plot(k,lo2, '--', 'linewidth', 1.5, 'DisplayName', 'Neg envelope')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')
legend;
grid on;
hold off

%%  generate an AM-Signal with a bandlimited source signal
w_sf = 2*pi*1;   %cut-off frequency in Hz
w_0 = 2*pi*1;    % signal frequency in Hz
w_c1 = 2*pi*12;  % carrier frequency in Hz
A = 1;  % Amplitude in Volt
a = 0.75;   % constant
T_a1 = (2*pi/w_sf)/2;    %sampling period in s
m_AM1 = 1;     %Modulation order

m_kTa1 = A*cos(w_c1.*k*T_a1 + phi);  %carrier signal of source signal in high frequency holds m(t) = A*cos(w_c*t + phi)
% Generierung des Bandbegrenztes Signal Sr(t) im Zeitbereich
Sr_kTa = (((w_sf+w_0/2)/pi)*sinc((w_sf+w_0/2).*k*T_a1)) - ...
    ((a*(w_sf-w_0/2)/pi)*sinc((w_sf-w_0/2).*k*T_a1)) - ...
    (w_sf*(1-a)/pi)*sinc(w_sf.*k*T_a1).*sinc((w_0.*k*T_a1)/2);
figure;
subplot(2,1,1);
plot(k,Sr_kTa, 'DisplayName', 'Sr(t)');
[up,lo]=envelope(Sr_kTa,100,'analytic');
hold on
plot(k,up, '--', 'linewidth', 1.5, 'DisplayName', 'Pos envelope')
plot(k,lo, '--', 'linewidth', 1.5, 'DisplayName', 'Neg envelope')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')
legend;
grid on;
hold off

% create the amplitude demodulated Signal Xam,r(t) in time domain
XrAM_kTa = (1+m_AM1*Sr_kTa).*m_kTa1;
subplot(2,1,2);
plot(k,XrAM_kTa, 'DisplayName', 'Xam,r(t)');
[up,lo]=envelope(XrAM_kTa,100,'analytic');
hold on
plot(k,up, '--', 'linewidth', 1.5, 'DisplayName', 'Pos envelope')
plot(k,lo, '--', 'linewidth', 1.5, 'DisplayName', 'Neg envelope')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')
legend;
grid on;
hold off




