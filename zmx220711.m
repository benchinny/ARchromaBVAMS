
clear all;
x=[1 0; 0 1.6]*[1 2; 0 1]*[1 0; 0.00125 0.9375]*[1 10; 0 1]*[1 0; -0.0067 0.667]*[1 300; 0 1]*[0; 0.01]

c=[0.02 -0.02 0]
n=[1.5   1.6  1]
d=[10    2    0]

f=c.*(n-1); f(2)=-0.002;
M=[1 0; 0 1]; MM=M;
M=[1 300; 0 1]*[0; 0.01]; MM=M;
n0=1;
for k=1:3
    R=[1 0; -f(k)./n(k) n0./n(k)]; RR(:,:,k)=R;
    T=[1 d(k); 0 1]; TT(:,:,k)=T;
    M=T*R*M;
    MM(:,k)=M
    n0=n(k)
end

%M*[1 300; 0 1]*[0; 0.01]