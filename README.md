# Racing Tire Characterization and Performance Modelling

## Project Overview

Tires are the only components of a vehicle that remain in direct contact with the road surface. Every force responsible for acceleration, braking, and cornering must ultimately pass through the tire contact patch, making tire behaviour one of the most important aspects of vehicle dynamics.

This project focuses on the analysis and characterization of experimental racing tire test data using MATLAB. The objective was to transform large volumes of raw tire test measurements into meaningful engineering insights and identify key tire performance characteristics relevant to vehicle dynamics and future tire model development.

## Objectives
The primary objectives of this project were:
- Understand the structure and contents of experimental tire test data
- Investigate the influence of slip angle on tire force generation
- Evaluate tire load sensitivity
- Analyze camber sensitivity and its effect on lateral grip
- Determine tire cornering stiffness
- Investigate self-aligning moment behaviour
- Extract meaningful tire performance parameters
- Develop a stronger understanding of racing tire behaviour through data analysis
- 
## Dataset
The analysis was performed using experimental racing tire test data obtained from controlled tire testing procedures.
Key parameters available in the dataset included:
- Slip Angle (SA)
- Inclination Angle / Camber (IA)
- Lateral Force (FY)
- Vertical Load (FZ)
- Longitudinal Force (FX)
- Self-Aligning Moment (MZ)
- Tire Pressure
- Wheel Speed
- Tire Surface Temperatures
- 
## Methodology
The analysis followed a structured workflow:
1. Dataset investigation and data quality assessment
2. Identification of representative operating conditions
3. Lateral force characterization
4. Peak tire performance extraction
5. Load sensitivity analysis
6. Camber sensitivity analysis
7. Cornering stiffness determination
8. Self-aligning moment analysis
9. Engineering interpretation of results
All analysis and visualization were performed using MATLAB.

## Key Investigations

### Tire Force Characterization
The relationship between lateral force and slip angle was investigated to identify the tire's force generation characteristics, including linear, nonlinear, and saturation regions.

### Load Sensitivity Analysis
The influence of vertical load on peak lateral force and friction coefficient was evaluated to understand how tire efficiency changes under increasing load.

### Camber Sensitivity Analysis
The effect of camber angle on peak lateral force generation was investigated to identify operating conditions that maximize tire performance.

### Cornering Stiffness Analysis
Cornering stiffness was determined from the linear region of the lateral force versus slip angle curve and compared across multiple load conditions.

### Self-Aligning Moment Analysis
The variation of self-aligning moment with slip angle was studied to understand steering feedback characteristics and tire behaviour near the limit of adhesion.

## Key Findings
- Tire exhibited clear nonlinear behaviour
- Peak lateral force increased with vertical load
- Friction coefficient decreased with increasing load, confirming tire load sensitivity
- Optimum tire performance occurred near moderate camber values
- Cornering stiffness increased with vertical load
- Peak self-aligning moment occurred before peak lateral force
- Maximum steering feedback occurred before maximum available grip
- 
## Tools Used
- MATLAB
- Vehicle Dynamics Principles
- Experimental Tire Data Analysis
- Data Visualization
- Engineering Interpretation
- 
## Repository Contents
```text
Report/
    Racing_Tire_Characterization_Report.pdf
MATLAB_Code/
    Tire analysis scripts
Figures/
    Generated plots and visualizations

## Future Work
This project establishes the foundation for future studies involving:
- Tire model development
- Pacejka parameter fitting
- Combined slip analysis
- Pneumatic trail investigation
- Vehicle dynamics simulation
- Lap time simulation

## Author
**Krishang Srivastava**
Mechanical Engineering Student | Formula Student Team Member
Interested in:
- Vehicle Dynamics
- Tire Modelling
- Performance Engineering
- Motorsport Engineering
