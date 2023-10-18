clear all;
close all;
%hold on
T=1*86400;%incremento en tiempo 1 dia=86400 S;
G=6.67E-11;%m3/s2Kg gravedad
N=6;%numero de part?culas: sol mercurio venus tierra marte
M=[333000,.0558,.815,1,.07,310]*5.98E24;%masas S M V T M J
%M=[333000,.0558,.815,1,.07,310]*5.98E24;%masas S M V T M J T
R=[0 0;57.9 0;108 0;150 0;228 0;778 0]*1E9;%posici?n inicial
Rf=R;%auxiliar
V=[0 0;0 47.9;0 35;0 29.8;0 24.1;0 13.1]*1E3;%velocidad inicial (tangente)
while(1);%for k=1:1000
    for i=1:N
   	    A=[0 0];%inicializa aceleraci?n
		for j=1:N
     		if i~=j
         	    r=R(i,:)-R(j,:);
                r2=norm(r);
                A=A-G*M(j)*r*(1/r2^3);%-.25/r2^4);
            end
        end
        %A=A-.1*V(i,:);
        V(i,:)=V(i,:)+A*T;
        Rf(i,:)=R(i,:)+V(i,:)*T;       
    end
    R=Rf;
    plot(R(1:N,1),R(1:N,2),'.b')
    axis([-1E12,1E12,-1E12,1E12])
    %break
    hold on
    pause(0.1)
end
