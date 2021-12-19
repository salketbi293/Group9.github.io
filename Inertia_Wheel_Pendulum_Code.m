% From the book: V. M. Hernández-Guzmán, R. Silva-Ortigoza, Automatic Control with Experiments

% Inertial Wheel pendulam
function [out] = Big_file_Wheel()
%% G21_Inertia_Wheel_Pendulum_Block
    function [Sys,x0]=InertialWheelPendulum(t,x,u,flag)
        N=3;
        switch flag,
            case 0,
                [Sys,x0] = Initialization(N);
            case 1,
                Sys = State_Equations(t,x,u,N);
            case 3,
                Sys = Output(t,x,u);
            case 9,
                Sys = [];
            otherwise
                Sys = [];
        end
    end
% Initialization
    function [Sys,x0]=Initialization(N)
        NumContStates = N;  % number of state
        NumDiscStates = 0;  % number of descretat states
        NumOutputs = N;     % number of outputs
        NumInputs = 1;      % number of input
        DirFeedthrough = 0; %
        NumSampleTimes = 1; %
        Sys = [NumContStates NumDiscStates NumOutputs
            NumInputs DirFeedthrough NumSampleTimes];
        x0 =[0 0.00001 0];
    end
% State_Equations
    function Sys = State_Equations(t,x,u,N)
        mbg=0.12597;
        R=4.172;
        km=0.00775;
        d11=0.0014636;
        d12=0.0000076;
        d21=d12;
        d22=d21;
        D=[d11 d12;d21 d22];
        Di=inv(D);
        di11=Di(1,1);
        di12=Di(1,2);
        di21=Di(2,1);
        di22=Di(2,2);
        xp(1)=x(2);
        xp(2)=-di11*mbg*sin(x(1))+(km/R)*di12*u;
        xp(3)=-di21*mbg*sin(x(1))+(km/R)*di22*u;
        Sys=[xp'];
    end
% Output
    function Sys = Output(t,x,u)
        Sys = [x];
    end
%% G22_Nonlinear_Controller_Block     OVERLOADED in the commented code blockes
    function [nlc,V,Verror] = fcn(x,d,V0)
        %#codegen
        mgl=0.12597;
        mbg=mgl;
        R=4.172;
        km=0.00775;
        Kd=20;
        d11=0.0014636;
        d12=0.0000076;
        d21=d12;
        d22=d21;
        J=(d11*d22-d12*d21)/d12;
        if x(2)>d 
            satx2=d;
        elseif x(2)<-d 
            satx2=-d;
        else
            satx2=x(2);
        end
        %-----------------energy--------------------
        V=(J/2)*x(2)^2+mbg*(1-cos(x(1)));
        %------------nonlinear control--------------
        nlc=(R/km)*Kd*satx2*(V-V0);
        %-----------energy error---------------------
        Verror=V-V0;
    end
%% G23_Linear_Controller_Block
    function lc = fcn(x,K)
        %#codegen}
        n=1;
        c=-570;
        xd=[n*pi; 0; c];
        z=x-xd;
        %--------linear control-----------
        lc =-K'*z;
end

%% G24_Controller_Commutation_Block
    function controller = fcn(nlc, lc, x)
        %#codegen n=1;
        c=-570;
        xd=[n*pi; 0; c];
        z=x-xd;
        if z(1)^2+z(2)^2<=0.01
            %-----linear control action-----------
            controller=lc;
            %-----nonlinear control action--------
        else controller=nlc;
        end
    end

%% %% G25_Numerical_Parameters
% Motor parameters 
R=4.172;
km=0.00775;
Umax=13;
% IWP Model g=9.81;
mgl=0.12597;
mbg=mgl
d11=0.0014636;
d12=0.0000076;
d21=d12;
d22=d21;
J= (d11*d22-d12*d21)/d12;
D=[d11 d12;d21 d22];
Di=inv(D);
di11=Di(1,1)
di12=Di(1,2)
di21=Di(2,1)
di22=Di(2,2)
% Linear approximate model of IWP
A=[0 1 0;di11*mbg 0 0;di21*mbg 0 0]
B=[0;di12*km/R;di22*km/R]
% Controllability determination
disp('Is system controllable?');
Pc=ctrb(A,B);
if rank(Pc) == size(Pc)
    disp('Yes.');
else
    disp('No.');
end
% Nonlinear controller
Kd=20;
V0=2*mbg
d=(Umax*km)/(R*Kd*V0)
%Linear state feedback controller at the operation point
n=1
c=-570
xd=[n*pi 0 c]
% Desired closed-loop eigenvalues
lambda1= -9.27 + 20.6i;
lambda2= -9.27 - 20.6i;
lambda3= -0.719;
Vp=[lambda1 lambda2 lambda3]
K = place(A,B,Vp)
% Verifying closed-loop eigenvalues
Vp_=eig(A-B*K)

end
