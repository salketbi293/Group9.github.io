
## Inertial Wheel Pendulum


Team Members: Saif Alketbi, Ryan Persons, Jesse Rath, Noah Douglas, Marius van Zyl

Fall 2021,California State University, Chico 

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
![image](https://user-images.githubusercontent.com/96152526/146591327-452f0f36-fc7f-4eb3-aa87-26e9544dcb97.png)

## 6. Controller Implementation


Pendulum in zero position
![Bottom position with tree](https://user-images.githubusercontent.com/35742388/146656577-409ac1d9-af38-4169-a767-7743f7e0ce4a.JPG)

Pendulum in controlled vertical position
![Top position with tree](https://user-images.githubusercontent.com/35742388/146656579-0ab0dbf4-854c-422f-ba2f-7eae95169dbf.JPG)


Appendix A:

 Simulation Code 
Your Simulink diagram or MATLAB –or other- code should be here

References

[1] M. W. Spong, P. Corke, and R. Lozano, Nonlinear control of the reaction wheel pendulum, Automatica, vol. 37, no. 11, pp. 1845–1851, 2001
