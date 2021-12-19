
## Inertial Wheel Pendulum


Team Members: Saif Alketbi, Ryan Persons, Jesse Rath, Noah Douglas, Marius van Zyl

Fall 2021,California State University, Chico 

YouTube Video Presentation Link: https://youtu.be/hruRpZqWCIY

# Table of Contents:
1. Introduction 
2. System Requirements
3. Modeling
4. Sensor Calibration
5. Control Design Simulations
6. Controller Implementation

## 1. Introduction
Inertia Wheel Pendulum (IWP) is a mechanism which is utilized for academic applications and research purposes. The principle of operation is a rotational electromechanical system is fixed with an inertial mass at the end of a 1 degree-of-freedom rotational pendulum. Despite one actuator, the system has in total 2 DoF (1 DoF Pendulum and 1 DoF actuator’s rotation). This type of system is known as underactuated systems. The IWP was introduced by Spong et. Al. [1].

An example of an inertia wheel pendulum 
![image](https://user-images.githubusercontent.com/96152526/146479845-6e977930-1f0d-4868-9e93-409ba5985ea2.png)


## 2. System Requirements
![MECH_482_-_Requirements__Capabilities_Database](https://user-images.githubusercontent.com/96152526/146605696-36c4782e-4f3c-4e73-8273-bd0db5c41cf1.png)


## 3. Modeling
  a. Logical_Functional Viewpoint
![image](https://user-images.githubusercontent.com/96152526/146482109-0b6269fc-8795-409f-9423-604befc2c5d7.png)
The high voltage power supply (24V)  is stepped down to a low voltage power supply (5V). The low-voltage power supply feeds the low level controller, the driver, and the motor. The motor spins the wheel which imparts a momentum on it. This creates a force that pushes the lever arm in the required direction. A sensor on the arm reads how far the pendulum is from standing straight up and sends a signal to the low level controller to adjust the input to the driver. Similarly a sensor on the wheel reads how fast and how many revolutions it needs to make to get the desired result. 

b. Operational ViewPoint
  i. Side View
  ![image](https://user-images.githubusercontent.com/96152526/146481275-525c61df-9379-4b4c-a7df-7594d7fefc74.png)
  
The pendulum is mounted to a table and allowed to hang freely. The X’ and Y’ axis rotates with the pendulum. When a force is applied to the pendulum the system senses an angle greater than 0 between the Y’ and X axis and starts to spin the motor to bring the angle closer to zero. Once it senses the angle is becoming larger, meaning the momentum is no longer large enough to overcome the weight of the pendulum, the rotation of the wheel is reversed and momentum is added in the opposite direction. Once the system senses a zero degree difference between the Y’ and X-axis the wheel is spun back and forth just enough to maintain the position of the lever arm. 

  ii. Top view
  ![image](https://user-images.githubusercontent.com/96152526/146481359-9c9f2ce8-a930-45e0-9cdd-14d069c71728.png)
  
From the top view the system components are easily identifiable. The system is allowed to rotate at the bearings holding the shaft to the chassis. The motor spins the reaction wheel such that momentum is generated. 

## 4. Sensor Calibration
Rotational sensors will have to be calibrated such that each step is a known angle. This calibration would only be done upon initial setup. Additional calibration would be done such that the vertical position of the lever arm, when the reaction wheel is hanging freely, is zero degrees.

## 5. Control Design Simulations

Below is the simulated system in the initial position with θ1 and θ2 at zero degrees.
![Bottom position with tree](https://user-images.githubusercontent.com/35742388/146656577-409ac1d9-af38-4169-a767-7743f7e0ce4a.JPG)

In the next figure, the pendulum is at the target position with θ1 at 180 degrees.
![Top position with tree](https://user-images.githubusercontent.com/35742388/146656579-0ab0dbf4-854c-422f-ba2f-7eae95169dbf.JPG)


## 6. Controller Implementation
![image](https://user-images.githubusercontent.com/96152526/146591327-452f0f36-fc7f-4eb3-aa87-26e9544dcb97.png)

## 6.1. Math model and equations
![m1](https://user-images.githubusercontent.com/35742388/146657196-e2287e2e-de5a-471a-becd-2b35437bfc27.jpg)
[2]
![m2](https://user-images.githubusercontent.com/35742388/146657199-8e932600-ded0-4f48-b5d3-26d10b3ec7b7.jpg)
[2]
![m3](https://user-images.githubusercontent.com/35742388/146657203-8befb945-e76a-4801-aec2-e2f063bcad4a.jpg)
[2]
![m4](https://user-images.githubusercontent.com/35742388/146657213-386e8c39-8cec-4234-9220-7ff1eadf9508.jpg)
[2]
![m5](https://user-images.githubusercontent.com/35742388/146657222-2d7d0644-1cc9-4985-a927-fac2fb837c52.jpg)
[2]

## 6.2. MatLab implementation
![control](https://user-images.githubusercontent.com/35742388/146657227-4601c68e-563e-457d-bcd4-89e02e1c934a.jpg)
[2]






## References

[1] M. W. Spong, P. Corke, and R. Lozano, Nonlinear control of the reaction wheel pendulum, Automatica, vol. 37, no. 11, pp. 1845–1851, 2001

[2] V. M. Hernández-Guzmán, R. Silva-Ortigoza, Automatic Control with Experiments


## Appendix A:

Simulation Code - A seen in the book [2]

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

