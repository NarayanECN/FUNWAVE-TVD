clear all

foldname='st_360_av_240';
%foldname='st_120_av_240';
fdir_results=['/Volumes/DISK_2020_5/OceanBeach_onyx/PlaneBeach_',foldname,'/'];
fdir_curr='/Users/fengyanshi/WORK/papers/zhang_etal_2022/idealized_beach/';

% st means start averaging, av means averaging interval
% in /PlaneBeach_st_600_av_480/ use output number 1, you can see \bar{uuH} become \bar{UUH}
% in /PlaneBeach_st_120_av_480/ use output number 2, OK but averaging time too long to remove mean
% in /PlaneBeach_st_120_av_240/ use output number 3,4, OK  
% in /PlaneBeach_st_360_av_240/ use output number 2,3, looks great to represent small sxx along node

m=960;
n=480;
DimsX={[m n]};

dx=2.0;
x=[0:m-1]*dx;
y=[0:n-1]*dx;
[X,Y]=meshgrid(x,y);

xshift=-m*2;
yshift=-n+20.0-318;

X=X+xshift;
Y=Y+yshift;
x=x+xshift;

icount=0;

SHsig=zeros(n,m);
Setamean=zeros(n,m);
Sum=zeros(n,m);
Svm=zeros(n,m);
SDxSxx=zeros(n,m);
SDySxy=zeros(n,m);
SPgrdX=zeros(n,m);
SFRCX=zeros(n,m);
SDxUUH=zeros(n,m);
SDyUVH=zeros(n,m);
SDySyy=zeros(n,m);
SDxSxy=zeros(n,m);
SPgrdY=zeros(n,m);
SFRCY=zeros(n,m);
SDxUVH=zeros(n,m);
SDyVVH=zeros(n,m);

ncount=0;
for numb=2:3
ncount=ncount+1;

eval(['cd ' fdir_results]);
fnum=sprintf('%.5d',numb);

fname=['eta_' fnum];
fileID=fopen(fname);
eta=fread(fileID,DimsX{1},'*single');
fclose(fileID);
eta=eta';

fname=['Hsig_' fnum];
fileID=fopen(fname);
Hsig=fread(fileID,DimsX{1},'*single');
fclose(fileID);
Hsig=Hsig';
SHsig=SHsig+Hsig;

fname=['etamean_' fnum];
fileID=fopen(fname);
etamean=fread(fileID,DimsX{1},'*single');
fclose(fileID);
etamean=etamean';
Setamean=Setamean+etamean;

fname=['umean_' fnum];
fileID=fopen(fname);
um=fread(fileID,DimsX{1},'*single');
fclose(fileID);
um=um';
Sum=Sum+um;

fname=['vmean_' fnum];
fileID=fopen(fname);
vm=fread(fileID,DimsX{1},'*single');
fclose(fileID);
vm=vm';
Svm=Svm+vm;


% x -direction ----------

fname=['DxSxx_' fnum];
fileID=fopen(fname);
DxSxx=fread(fileID,DimsX{1},'*single');
fclose(fileID);
DxSxx=DxSxx';
SDxSxx=SDxSxx+DxSxx;

fname=['DySxy_' fnum];
fileID=fopen(fname);
DySxy=fread(fileID,DimsX{1},'*single');
fclose(fileID);
DySxy=DySxy';
SDySxy=SDySxy+DySxy;

fname=['PgrdX_' fnum];
fileID=fopen(fname);
PgrdX=fread(fileID,DimsX{1},'*single');
fclose(fileID);
PgrdX=PgrdX';
SPgrdX=SPgrdX+PgrdX;


fname=['FRCX_' fnum];
fileID=fopen(fname);
FRCX=fread(fileID,DimsX{1},'*single');
fclose(fileID);
FRCX=FRCX';
SFRCX=SFRCX+FRCX;

fname=['DxUUH_' fnum];
fileID=fopen(fname);
DxUUH=fread(fileID,DimsX{1},'*single');
fclose(fileID);
DxUUH=DxUUH';
SDxUUH=SDxUUH+DxUUH;

fname=['DyUVH_' fnum];
fileID=fopen(fname);
DyUVH=fread(fileID,DimsX{1},'*single');
fclose(fileID);
DyUVH=DyUVH';
SDyUVH=SDyUVH+DyUVH;

% y -direction ----------

fname=['DySyy_' fnum];
fileID=fopen(fname);
DySyy=fread(fileID,DimsX{1},'*single');
fclose(fileID);
DySyy=DySyy';
SDySyy=SDySyy+DySyy;

fname=['DxSxy_' fnum];
fileID=fopen(fname);
DxSxy=fread(fileID,DimsX{1},'*single');
fclose(fileID);
DxSxy=DxSxy';
SDxSxy=SDxSxy+DxSxy;

fname=['PgrdY_' fnum];
fileID=fopen(fname);
PgrdY=fread(fileID,DimsX{1},'*single');
fclose(fileID);
PgrdY=PgrdY';
SPgrdY=SPgrdY+PgrdY;

fname=['FRCY_' fnum];
fileID=fopen(fname);
FRCY=fread(fileID,DimsX{1},'*single');
fclose(fileID);
FRCY=FRCY';
SFRCY=SFRCY+FRCY;

fname=['DyVVH_' fnum];
fileID=fopen(fname);
DyVVH=fread(fileID,DimsX{1},'*single');
fclose(fileID);
DyVVH=DyVVH';
SDyVVH=SDyVVH+DyVVH;

fname=['DxUVH_' fnum];
fileID=fopen(fname);
DxUVH=fread(fileID,DimsX{1},'*single');
fclose(fileID);
DxUVH=DxUVH';
SDxUVH=SDxUVH+DxUVH;

end

% avg
Hsig=SHsig/ncount;
etam=Setamean/ncount;
um=Sum/ncount;
vm=Svm/ncount;
DxSxx=SDxSxx/ncount;
DySxy=SDySxy/ncount;
PgrdX=SPgrdX/ncount;
FRCX=SFRCX/ncount;
DxUUH=SDxUUH/ncount;
DyUVH=SDyUVH/ncount;
DySyy=SDySyy/ncount;
DxSxy=SDxSxy/ncount;
PgrdY=SPgrdY/ncount;
FRCY=SFRCY/ncount;
DxUVH=SDxUVH/ncount;
DyVVH=SDyVVH/ncount;


[vort tmp]=curl(X,Y,um,vm);


% look at friction from mean velocity
%FRCX=0.005*sqrt(um.^2+vm.^2).*um;
%FRCY=0.005*sqrt(um.^2+vm.^2).*vm;

% --------- residual
Rx=DxSxx+DySxy+PgrdX+FRCX+DxUUH+DyUVH;
Ry=DySyy+DxSxy+PgrdY+FRCY+DyVVH+DxUVH;
% ---------

eval(['cd ' fdir_curr]);


nn2=390;  % anti
nn1=370;  % middle
nn3=350;  % node 

yy1=Y(nn2,1);
yy2=Y(nn1,1);
yy3=Y(nn3,1);

ax1=[-600 0 -225 175];
txt_x=-580;
txt_y=150;

fig=figure(1);
clf
wid=8.0;
len=10.0;
%set(fig,'units','inches','paperunits','inches','papersize',...
%    [wid len],'position',[1 1 wid len],'paperposition',[0 0 wid len]);
colormap jet
t = tiledlayout(2,2,'TileSpacing','Compact','Padding','Compact');
nexttile
pcolor(X,Y,eta),shading interp
caxis([-0.9 1.9])
axis(ax1)
hold on
%plot([-748 -748],[-500 500],'k--','LineWidth',2)
%ht=text(-700,-100,'slope toe');
%set(ht,'Rotation',90)
%set(ht,'FontSize',14)
%set(ht,'Color','k')
plot([-1000 0],[yy1 yy1],'w-','LineWidth',2)
%plot([-1000 0],[yy2 yy2],'w-','LineWidth',2)
plot([-1000 0],[yy3 yy3],'w-','LineWidth',2)
text(-180,17,'Prof 1')
%text(-180,-27,'Prof 2')
text(-180,-70,'Prof 2')

%xlabel('x (m)')
ylabel('y (m)')
text(txt_x, txt_y, '(a)','Color','w','FontSize',14)

cbar=colorbar;
set(get(cbar,'ylabel'),'String','\eta ( m ) ')

set(gca, 'LineWidth',  1)

nexttile
pcolor(X,Y,Hsig),shading interp
caxis([0 3.0])
axis(ax1)
hold on
%plot([-1000 0],[yy2 yy2],'w-','LineWidth',2)
plot([-1000 0],[yy1 yy1],'w-','LineWidth',2)
plot([-1000 0],[yy3 yy3],'w-','LineWidth',2)

%xlabel('x (m)')
%ylabel('y (m)')
cbar=colorbar;
set(get(cbar,'xlabel'),'String','wave height ( m ) ')
text(txt_x, txt_y, '(b)','Color','k','FontSize',14)

nexttile
vb=[-0.2:0.03:-0.02 0.01:0.03:0.1 0.1:0.02:0.3];
contourf(X,Y,etam,vb),shading interp
caxis([-0.3 0.3])
axis(ax1)
hold on
%plot([-1000 0],[yy2 yy2],'w-','LineWidth',2)
plot([-1000 0],[yy1 yy1],'w-','LineWidth',2)
plot([-1000 0],[yy3 yy3],'w-','LineWidth',2)
text(txt_x, txt_y, '(c)','Color','k','FontSize',14)

xlabel('x (m)')
ylabel('y (m)')
cbar=colorbar;
set(get(cbar,'xlabel'),'String','setup ( m ) ')

set(gca, 'LineWidth',  1)

nexttile
pcolor(X,Y,vort),shading interp
hold on
sk=8;
sc=50;
quiver(X(1:sk:end,1:sk:end),Y(1:sk:end,1:sk:end),um(1:sk:end,1:sk:end)*sc,vm(1:sk:end,1:sk:end)*sc,0)
axis(ax1)
%plot([-1000 0],[yy2 yy2],'w-','LineWidth',2)
plot([-1000 0],[yy1 yy1],'w-','LineWidth',2)
plot([-1000 0],[yy3 yy3],'w-','LineWidth',2)
xlabel('x (m)')
cbar=colorbar;
set(get(cbar,'ylabel'),'String','vort ( 1/s ) ')
text(txt_x, txt_y, '(d)','Color','k','FontSize',14)
set(gca, 'LineWidth',  1)

xlabel('x (m)')
%ylabel('y (m)')

set(fig, 'PaperPositionMode', 'auto')

print('-depsc2',['plots/ideal_4_frame_2prof_',foldname, '.eps'])
print('-djpeg',['plots/ideal_4_frame_2prof_',foldname, '.jpg'])


txt_x=-390;
txt_y=0.09;

fig=figure(2);

ax2=[-400 -40 -0.04 0.075];

wid=9.0;
len=10.0;
set(fig,'units','inches','paperunits','inches','papersize',...
    [wid len],'position',[1 1 wid len],'paperposition',[0 0 wid len]);
colormap jet

subplot(4,1,[1])

plot(x,PgrdX(nn2,:),'b',x,DxSxx(nn2,:),'r', x,DySxy(nn2,:),'r--',x,DxUUH(nn2,:)+DyUVH(nn2,:),'k',x,FRCX(nn2,:),'b--',x,Rx(nn2,:),'c--','LineWidth',1)

axis(ax2)
grid
ylabel('m^2/s^2')
legend('$gH\frac{\partial \bar{\eta}}{\partial x}$','$\frac{\partial Sxx}{\partial x}$', '$ \frac{\partial Sxy}{\partial y}$','$\frac{\partial \bar{P}\bar{P}/H}{\partial x} + \frac{\partial \bar{P}\bar{Q}/H}{\partial y}$','$\bar{\tau}_x$','Rx','fontsize',14,'interpreter','latex','Orientation','horizontal')

text(txt_x,txt_y,'(a)','FontSize',14)

subplot(4,1,[2])
plot(x,PgrdX(nn3,:),'b',x,DxSxx(nn3,:),'r',x, DySxy(nn3,:),'r--',x,(DxUUH(nn3,:)+DyUVH(nn3,:)),'k',x,FRCX(nn3,:),'b--',x,Rx(nn3,:),'c--','LineWidth',1)

axis(ax2)
grid
ylabel('m^2/s^2')

text(txt_x,txt_y,'(b)','FontSize',14)

legend('$gH\frac{\partial \bar{\eta}}{\partial x}$','$\frac{\partial Sxx}{\partial x}$', '$ \frac{\partial Sxy}{\partial y}$','$\frac{\partial \bar{P}\bar{P}/H}{\partial x} + \frac{\partial \bar{P}\bar{Q}/H}{\partial y}$','$\bar{\tau}_x$','Rx','fontsize',14,'interpreter','latex','Orientation','horizontal')


subplot(4,1,[3])

plot(x,PgrdY(nn2,:),'b',x,DxSxy(nn2,:),'r', x,DySyy(nn2,:),'r--',x,DyVVH(nn2,:)+DxUVH(nn2,:),'k',x,FRCY(nn2,:),'b--',x,Ry(nn2,:),'c--','LineWidth',1)

axis(ax2)
grid
ylabel('m^2/s^2')
legend('$gH\frac{\partial \bar{\eta}}{\partial y}$','$\frac{\partial Sxy}{\partial x}$', '$ \frac{\partial Syy}{\partial y}$','$\frac{\partial \bar{Q}\bar{Q}/H}{\partial y} + \frac{\partial \bar{P}\bar{Q}/H}{\partial x}$','$\bar{\tau}_y$','Ry','fontsize',14,'interpreter','latex','Orientation','horizontal')

text(txt_x,txt_y,'(c)','FontSize',14)


subplot(4,1,[4])
plot(x,PgrdY(nn3,:),'b',x,DxSxy(nn3,:),'r', x,DySyy(nn3,:),'r--',x,DyVVH(nn3,:)+DxUVH(nn3,:),'k',x,FRCY(nn3,:),'b--',x,Ry(nn3,:),'c--','LineWidth',1)

axis(ax2)
grid
xlabel('x (m)')
ylabel('m^2/s^2')
text(txt_x,txt_y,'(d)','FontSize',14)

legend('$gH\frac{\partial \bar{\eta}}{\partial y}$','$\frac{\partial Sxy}{\partial x}$', '$ \frac{\partial Syy}{\partial y}$','$\frac{\partial \bar{Q}\bar{Q}/H}{\partial y} + \frac{\partial \bar{P}\bar{Q}/H}{\partial x}$','$\bar{\tau}_y$','Ry','fontsize',14,'interpreter','latex','Orientation','horizontal')

print('-depsc2',['plots/momentum_xy_', foldname, '.eps'])
print('-djpeg',['plots/momentum_xy_', foldname, '.jpg'])

return
