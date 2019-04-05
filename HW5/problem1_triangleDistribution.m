clear all; clc;

a= -4; 
b= 2;  
h=2/(b-a); 
k1=-h/a;
k2=-h/b; 
 
invcdf=@(s)(sqrt(2*s/k1)+a).*(s<=-a*h/2)+...
    (b-sqrt(2*(s-1)/k2)).*(s>-a*h/2);
 
N=1000000;            
RV=invcdf(rand(1,N)); 
K=1000;                
xx=linspace(a+(b-a)/K/2,b-(b-a)/K/2,K);
n = hist(RV,xx);     
p=K*n/N/(b-a);       
 
x=[a 0 b];
y=[0 h 0];  
 
bar(xx,p,1);
hold on
plot(x,y,'r','linewidth',2);
hold off
xlabel('x');
ylabel('probability');
legend('probability histogram','triangular pdf');
