clear all
clc
close all

% link de los archivos de audio
%https://drive.google.com/drive/folders/1hyOmNIyIQgTDip7qnXb1L42yfVyVwSJS?usp=share_link

%----------------------Leyendo y procesando archivo de audio----------------------%
Nom='miguitarra.mp3';
%info = audioinfo(Nom)
[y1,Fs] = audioread(Nom);

y1=y1(:,1);

res_y1=resample(y1,20000, Fs);


figure
plot(res_y1);
title('Señal del archivo de audio con respecto al tiempo')
p= audioplayer(res_y1, 20000);
play(p)

X = fft(y1);
n = length(y1);
fs= 44100;
f = (0:n-1)* (fs/n);
x_norm = abs(X).^2/n; %normalización de la señal
figure
plot(f,x_norm)
xlim([0 10000]);

[x_norm_max, index] = max(x_norm); %obtención del máximo de la función (frecuencia fundmental)
f_max = f(index);
f_max;
x_norm_max;

ev=round(f_max);

%----------------------Base de datos de notas----------------------%
do4 = [255:265];
re4 = [289:299];
mi4 = [325:335];
fa4 = [344:354];
sol4 = [387:397];
la4 = [435:445];
si4 = [489:499];
do5 = [519:529];
re5 = [582:592];
mi5 = [654:664];
fa5 = [693:703];
sol5 = [778:788];
la5 = [875:885];
si5 = [982:992];
Nota=0;

sprintf('La frecuencia predominante en este archivo de audio es %d Hz.', ev)
for i=1:11
    if ev == do4(i)
        disp('La nota escuchada es Do')
        Nota=1;
    elseif ev == re4(i)
        disp('La nota escuchada es Re')
        Nota=2
    elseif ev == mi4(i)
        disp('La nota escuchada es Mi')
        Nota=3;
    elseif ev == fa4(i)
        disp('La nota escuchada es Fa')
        Nota=4;
    elseif ev == sol4(i)
        disp('La nota escuchada es Sol')
        Nota=5;
    elseif ev == la4(i)
        disp('La nota escuchada es La')
        Nota=6;
    elseif ev == si4(i)
        disp('La nota escuchada es Si')
        Nota=7;
    elseif ev == do5(i)
        disp('La nota escuchada es Do')
        Nota=1;
    elseif ev == re5(i)
        disp('La nota escuchada es Re')
        Nota=2
    elseif ev == mi5(i)
        disp('La nota escuchada es Mi')
        Nota=3;
    elseif ev == fa5(i)
        disp('La nota escuchada es Fa')
        Nota=4;
    elseif ev == sol5(i)
        disp('La nota escuchada es Sol')
        Nota=5;
    elseif ev == la5(i)
        disp('La nota escuchada es La')
        Nota=6;
    elseif ev == si5(i)
        disp('La nota escuchada es Si')
        Nota=7; 
    end 
end


%-------------------------Máximos locales-------------------------%


[x_norm_peaks, index2] = findpeaks(x_norm(1:10000), 'MinPeakProminence',0.5, 'MinPeakDistance',50); %discriminación de máximos locales
f_peaks = f(index2);
f_peaks;
index2;
x_norm_max;
S = sum( index2 , 'all' );

%---------------Base de datos de la suma de index 2---------------%
dos = [19000,13000,1400];
res = [16000,5000,1500];
mis = [25000,2500,1700];
fas = [29000,4800,1800];
sols = [18000,8700,2000];
las = [27000,13500,2300];
sis = [18000,11521,2500];

Notas = [dos;res;mis;fas;sols;las;sis];

w=[Notas(Nota,1),Notas(Nota,2),Notas(Nota,3)];

if  S>w(2) 
    disp('El instrumento es una Guitarra')
elseif  S>w(3) && S<w(2)
    disp('El instrumento es un Piano')
elseif  S<w(3)
    disp('Se trata de una onda Sinusoidal')
end
