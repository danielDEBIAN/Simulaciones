%%
clear all
close all
clc
%%%%%%FORMACION DE LA MALLA
R=[0,0,0];
numGrados=20;
for r=.1:.1:1
    intervalo=0:2*pi/numGrados:2*pi;
    x=r*cos(intervalo);
    y=r*sin(intervalo);
    z=zeros(size(x));
    R=[R;x',y',z'];
end
%R=[rand(100,2),zeros(100,1)];
% plot3(R(:,1),R(:,2),R(:,3),'o');
% hold on
tri = delaunay(R(:,1),R(:,2));
trimesh(tri,R(:,1),R(:,2),R(:,3));
%%%%%%%%% INICIALIZACION
N=length(R);
for k=1:N
    p(k).r=R(k,:);%posicion
    p(k).v=[0,0,0];%velocidad
    p(k).f=[0,0,0];%fuerza
    [fil,col]=find(tri==k);
    ele=tri(fil,:);
    ele=unique(sort(ele(:)));
    vec=ele((ele>k));
    p(k).vec=vec;
    for j=1:length(vec)
        p(k).deq(j)=norm(R(k,:)-R(vec(j),:))*.9;
    end
end
for k=1:numGrados+1
    p(k).r(3)=1;
end
DT=.001;
K=100;%resorte
K2=1;%amortiguamiento
%%%%%% SIMULACION
for i=1:1000%Calculos
    for k=1:N-numGrados-1
        numVec=length(p(k).vec);
        for j=1:numVec
            indVec=p(k).vec(j);
            DR=p(indVec).r-p(k).r;
            modulo=norm(DR);
            U=DR/modulo;
            F=K*(modulo-p(k).deq(j))*U;
            p(k).f=p(k).f+F;
            p(indVec).f=p(indVec).f-F;
        end%+[0,0,-10]
        p(k).v=(p(k).f-K2*p(k).v)*DT+p(k).v;
        p(k).r=p(k).v*DT+p(k).r;
    end
    y(i)=p(1).r(3);
    for k=1:N
        R(k,1:3)=p(k).r;
        p(k).f=[0,0,0];       
    end
    %plot3(R(:,1),R(:,2),R(:,3),'.');
    trimesh(tri,R(:,1),R(:,2),R(:,3));
    axis([-1 1,-1 1,-2 2]);    pause(0.000001);
end
%%%%%%%% SONIDO
figure(2);plot(y)
sound(y,10000);