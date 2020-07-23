clc
clear all
%=================================================================
disp('Solution of N-equation "[A][X]=[r]"')
n=input ('Enter number of Equations :');
A=input ('Enter Matrix [A]:');
r=input ('Enter Matrix [r]:');
D=A;d=r;
Lower=eye(n); %creating the lower trainguler mtarix skeleton as identity matrix
%-----------------------------------------------------------------
%create upper triangular matrix
s=0;
for j=1:n-1    
    if A(j,j)==0
        % looks for 0 in the pivot coefficient
        k=j;
        for k=k+1:n
            if A(k,j)==0 % looks for any other zeros in same column
                continue %goes into the next iteration ignoring anyfollowing commands
            end
        break
        end
        % replace the pivot equation
        B=A(j,:); C=r(j);
        A(j,:)=A(k,:); r(j)=r(k);
        A(k,:)=B; r(k)=C;
    end
    for i=1+s:n-1
        L=A(i+1,j)/A(j,j); %division by pivot coefficient
        Lower(i+1,j)=L;%pushing the pivot coef to the respective place(similar to current position in A where 0 will be made) in the lower triangular matrix skeleton to form lower triangular matrix
        A(i+1,:)=A(i+1,:)-L*A(j,:); %subtraction according to the theorem
        r(i+1)=r(i+1)-L*r(j); % similar process for the RHS
    end
    s=s+1;
end
%-----------------------------------------------------------------
U=A; %saving the upper triangular matrix to U

%solving for Y from LY=r
Y=0;
for i=1:n
    sum=0;
    for j=1:i-1                             
        sum=sum+Lower(i,j)*Y(j);
    end
    Y(i)=d(i)-sum;  %r was primarily saved to d in line 8          
end


%solving for X from UX=Y
X=0;
for i=n:-1:1
    sum=0;
    for j=n:-1:i+1                            
        sum=sum+U(i,j)*X(j);
    end
    
    X(i)=(Y(i)-sum)/U(i,i);
end

disp('Upper triangular Matrix [U] =');disp(U)
disp('Lower triangular Matrix [L] =');disp(Lower)
disp('step 1: solving [Y] from [L][Y]=[r]');
disp("[y]=");disp(Y')
disp('step 2: solving [X] from [U][X]=[Y]');
disp("[X]=");disp(X')
disp('solution of linear equations :');disp(X')