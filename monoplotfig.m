clear all;clc
close all;
%% plot
load monosignal;
load('ECTDdistributionmono.mat','ECTDdistributionmono');


ECTDdistribution = ECTDdistributionmono;

[steps N1 M]=size(ECTDdistribution);

nabegin = round(linspace(1,N-N1,steps));

for is = 1:steps
    fr1(is) = (-4*k/c*Phi1(nabegin(is)+N1/2));
    fa1(is) = (Phi1(nabegin(is)+N1/2)-Phi1(nabegin(is)+N1/2-1))/2/pi*PRF+1;
end
fr1bin = fr1/(fs/M)+M/2;
fa1bin = fa1/(PRF/N1)+N1/2;


%% Fig a&b
clear img;
img = abs(ECTDdistribution);
for is = 1:steps
    img(is,:,:) = db(img(is,:,:)/max(max(img(is,:,:))))/2;
end
figure;hold on;
for istep = 1:steps
    for in = 1:N1
        for im = 1:M
            if img(istep,in,im)>=-10
                plot3(nabegin(istep),im,in,'*');
            end
        end
    end
end
xlabel('ta');
ylabel('fr');
zlabel('fa');
xlim([1 N]);
ylim([0 M]);
zlim([0 N1]);
set(gca,'ztick',[N1/4, N1/2, N1*3/4]);
set(gca,'zticklabel',[-PRF/2, 0,PRF/2]);
set(gca,'ytick',[M/4, M/2, M*3/4]);
set(gca,'yticklabel',[-fs/4e6, 0,fs/4e6]);
set(gca,'xtick',[1, N/2, N]);
set(gca,'xticklabel',[0, floor(N/PRF/2),floor(N/PRF)]);
xlabel('ta (s)','FontSize',14);
ylabel('fr (MHz)','FontSize',14);
zlabel('fa (Hz)','FontSize',14);
set(gca,'FontSize',14);
view(40,45);


LineWidth = 4;
figure;
hold on;
plot3(nabegin,fr1bin,fa1bin,'c','LineWidth',LineWidth);
set(gca,'ztick',[N1/4, N1/2, N1*3/4]);
set(gca,'zticklabel',[-PRF/2, 0,PRF/2]);
set(gca,'ytick',[M/4, M/2, M*3/4]);
set(gca,'yticklabel',[-fs/4e6, 0,fs/4e6]);
set(gca,'xtick',[1, N/2, N]);
set(gca,'xticklabel',[0, floor(N/PRF/2),floor(N/PRF)]);
xlabel('ta (s)','FontSize',14);
ylabel('fr (MHz)','FontSize',14);
zlabel('fa (Hz)','FontSize',14);
set(gca,'FontSize',14);
xlim([1 N]);
ylim([0 M]);
zlim([0 N1]);
view(40,45);


%% Fig c&d
if steps>113
    E1 = 15;E2 = 113;
else 
    E1 = round(step/4);E2 = round(step/2);
end

for in = 1:N1
    for im = 1:M
        Dimg(in,im) = ECTDdistribution(E1,in,im);
    end
end
clear img;
img = abs(Dimg);
img = db(img/max(max(img)))/2;
figure;imagesc((-M/2:M/2-1)/M*fs/1e6,(-N/2:N/2-1)/N*PRF,img,[-30 0]);
set(gca,'FontSize',14);
title(sprintf('ECTD cross-section view 1'));
xlabel('Fr(MHz)');
ylabel('Fa(Hz)');
ylim([-50 50]);
colorbar;
set(gca,'FontSize',14);

for in = 1:N1
    for im = 1:M
        Dimg(in,im) = ECTDdistribution(E2,in,im);
    end
end
clear img;
img = abs(Dimg);
img = db(img/max(max(img)))/2;
figure;imagesc((-M/2:M/2-1)/M*fs/1e6,(-N/2:N/2-1)/N*PRF,img,[-30 0]);
set(gca,'FontSize',14);
title(sprintf('ECTD cross-section view 2'));
xlabel('fr(MHz)');
ylabel('fa(Hz)');
ylim([-50 50]);
colorbar;
set(gca,'FontSize',14);
%% Fig e

projDIFA = zeros(N1,steps);
for is = 1:steps
    for in  = 1:N1
        projDIFA(in,is) = sum(abs(ECTDdistribution(is,in,:)));
    end
end
clear img;
img = abs(projDIFA);
img = db(img/max(max(img)))/2;
figure;imagesc(img,[-20 0]);
xlim([1 steps]);
ylim([N1/4 3*N1/4]);
set(gca,'ytick',[N1/4, N1/2, 3*N1/4]);
set(gca,'yticklabel',[-PRF/4, 0,PRF/4]);
set(gca,'xtick',[1, steps/2, steps]);
set(gca,'xticklabel',[0, floor(N/PRF/2),floor(N/PRF)]);
colorbar;
xlabel('ta (s)','FontSize',14);
ylabel('fa (Hz)','FontSize',14);
set(gca,'FontSize',14);
