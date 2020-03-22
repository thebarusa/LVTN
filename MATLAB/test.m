close all
clc
clear all

subplot(2,1,1);
plot(linspace(0, (8000/2), 129), melfb(20, 256, 8000)');
subplot(2,1,2);
plot(linspace(0, (8000/2), 129), melfb_v2(20, 256, 8000)');