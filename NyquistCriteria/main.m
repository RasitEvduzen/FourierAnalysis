clc, clear all, close all;
% Nyquist Sampling Frequency Limit Simulation
% Written By: Rasit
% 10-Mar-2024

%% Creating a sinc^2 signal
Fs = 1;                   % frequency of impulse
time = (-5:1e-2:5)';      % Time range for impulse train
Signal = sinc(time).^2;   % sinc^2 signal

% impulse train
Fsample = 10;              % sampling frequency with oversampling factor
Ts_sample = 1/Fsample;
t_sample = (min(time):Ts_sample:max(time))';
impulse = zeros(size(time));
impulse(mod(time, Ts_sample) == 0) = 1;

%% Plot Result

% Time domain of sinc^2 signal
subplot(321)
plot(time, Signal, 'r', 'LineWidth', 2), grid on
xlabel("Time"), ylabel("Signal"), title("Time Domain")

% Frequency domain of sinc^2 signal
Signal_fft = abs(fftshift(fft(Signal)));
frequencies = linspace(-Fs/2, Fs/2, length(Signal_fft));
subplot(322)
plot(frequencies, Signal_fft/length(time), "r", 'LineWidth', 2), grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title("Frequency Domain")

% Time domain of impulse train
subplot(323)
stem(time, impulse, '^', 'LineWidth', 2), grid on;
ylabel('Amplitude'), xlabel('Time (sec)');
title('Impulse Train'), ylim([0 2]);

% Frequency domain of impulse train
Impulse_fft = abs(fftshift(fft(impulse)));
subplot(324)
plot(frequencies, Impulse_fft/length(time), "r", 'LineWidth', 2), grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title("Frequency Domain")

% Time domain of sinc^2 * impulse train
sinc_impulse = Signal .* impulse;
subplot(325)
plot(time, sinc_impulse, 'b', 'LineWidth', 2), grid on
xlabel('Time (s)'), ylabel('Amplitude')
title('Time Domain of sinc^2 * Impulse Train')

% Frequency domain of convolution
Sinc_fft = fft(Signal);
Impulse_fft_full = fft(impulse, length(Signal));
Convolution_fft = abs(fftshift(ifft(Sinc_fft .* Impulse_fft_full)));
subplot(326)
plot(frequencies, Convolution_fft/length(time), "b", 'LineWidth', 2), grid on
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title("Frequency Domain of Convolution")
