fs=44100;
N=fs;
t =0:1/fs:0.3;
f=440;
tone ={};
bannhac=[];

for i =1:12
tone{i}=0.3*sin(2*pi*f*(2^(i-1)).^(1/12)*t);
end
%'A' 'A#' 'B' 'C' 'C#' 'D' 'D#' 'E' 'E#' 'F' 'G' 'G#'
A = tone{1}; A1=tone{2}; B = tone{3};C=tone{4};C1=tone{5}; D=tone{6};D1=tone{7};E=tone{8};E1=tone{9};F=tone{10};G=tone{11};G1=tone{12};
bannhac = [G C D D E1 E1 C D E1 D G1 G1 G1 G A1 B B C C D E1 D C B ];
[g,fs]=audioread('orig-input.wav');
y=repmat(bannhac,2);

bannhac1 = y(1:length(g));
p = g + bannhac1'; %tron tin hieu voice va melody
sound (p,44100);
Y = fft(p);
plot(abs(Y))

N = fs
transform = fft(p,N)/N;
magTransform = abs(transform);

faxis = linspace(-fs/2,fs/2,N);
plot(faxis,fftshift(magTransform));
xlabel('Frequency (Hz)')


N =length(p);
transform = fft(g,N)/N;
magTransform = abs(transform);
faxis = linspace(-N/2,N/2,N);
figure(1);
plot(faxis,fftshift(magTransform));
title('The Spectrum');
xlabel('Frequency (Hz)')
figure(2);
win = 128;
hop = win/2;          

nfft = win; 
spectrogram(p,win,hop,nfft,fs,'yaxis')
yt = get(gca,'YTick');  
set(gca,'YTickLabel', sprintf('%.0f|',yt))
title('Spectrogram');
