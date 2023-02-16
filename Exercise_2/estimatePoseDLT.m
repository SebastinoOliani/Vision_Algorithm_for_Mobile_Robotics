function M = estimatePoseDLT(p,P,K)
%calibrate coordinates
x=zeros(6,1);
y=zeros(6,1);
%K_inv=inv(K);
for i=1:1:6
    A=K\[p(i,1);p(i,2);1];
    x(i,1)=A(1,1);
    y(i,2)=A(2,1);
end

%Q matrix
Q=zeros(12,12);
q1=zeros(1,12);
q2=zeros(1,12);
k=1;
for i=1:1:6
    q1=[P(i,1),P(i,2),P(i,3),1,0,0,0,0,-x(i,1)*P(i,1),-x(i,1)*P(i,2),-x(i,1)*P(i,3),-x(i,1)];
    q2=[0,0,0,0,P(i,1),P(i,2),P(i,3),1,-y(i,2)*P(i,1),-y(i,2)*P(i,2),-y(i,2)*P(i,3),-y(i,2)];
    Q(k,:)=q1;
    Q(k+1,:)=q2;
    k=k+2;
end
%applying svd in order to obtain no trivial solution
[U,S,V]=svd(Q);
M=V(:,12);
%M=Q\zeros(12,1);