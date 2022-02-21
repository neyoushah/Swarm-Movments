dt=0.02; 
n=50; 
if 1<2
    x=rand(n,1);
    y=rand(n,1);
  
    zx=0.5;
    zy=0.5;
   
end

c=0.15;
a=1; b=0.2; p=3;


tplot=0;
predhist=[];

for t=0:dt:50; 
    
    xnew=zeros(n,1); 
    ynew=zeros(n,1); 
   
    for j=1:1:n; 
        R=0;P=0;
        for k=1:n; 
            if j~=k; 
                z=sqrt(((x(j)-x(k)).^2)+((y(j)-y(k)).^2)); 
                h=sqrt((x(j)-zx).^2+(y(j)-zy).^2);
                F1 = 1./z.^2-a.*z;
                F2 = b./h.^2;
                R=R+(x(j)-x(k))./z.*F1+(x(j)-zx)./h.*F2; 
                P=P+(y(j)-y(k))./z.*F1+(y(j)-zy)./h.*F2; 
               
            end; 
        end; 
        xnew(j)=x(j)+dt*R/n; 
        ynew(j)=y(j)+dt*P/n;
       
    end;
    
    G=0; H=0;
    for k=1:n
        s=sqrt((x(k)-zx).^2+(y(k)-zy).^2);
        G=G+(c/n)*((x(k)-zx)/s.^p);
        H=H+(c/n)*((y(k)-zy)/s.^p);
       
    end;
    zxnew=zx+dt*G;
    zynew=zy+dt*H;
   
    
    x=xnew;
    y=ynew;
  
    zx=zxnew;
    zy=zynew;
   
    
    oo=[zx, zy];
    predhist(end+1,:)=oo;
    
    if tplot<t;
        tplot=tplot+1;
        sqrt((x-mean(x)).^2+(y-mean(y)).^2);
        hold on;
       %plot(x,y,'.b');
         
        plot(zx,zy,'.r');

        title(sprintf('t=%g',t));
        axis equal;
        drawnow;
    end;
end;
%clf;plot(predhist);

xh=predhist(:,1);yh=predhist(:,2);
xh=xh-mean(xh); yh=yh-mean(yh);
%plot(sqrt(xh.^2+yh.^2));
