clc
clear
close all

%% Import Data

filename = 'Tiredatarun27 (1).dat';

data = readtable(filename);

data(1:5,:)
%% Variable Names

data.Properties.VariableNames
%% Basic Statistics

fprintf('\n===== BASIC STATISTICS =====\n\n')

fprintf('Minimum SA = %.2f deg\n',min(data.SA))
fprintf('Maximum SA = %.2f deg\n',max(data.SA))

fprintf('Minimum IA = %.2f deg\n',min(data.IA))
fprintf('Maximum IA = %.2f deg\n',max(data.IA))

fprintf('Minimum FZ = %.0f N\n',min(abs(data.FZ)))
fprintf('Maximum FZ = %.0f N\n',max(abs(data.FZ)))
%% Slip Angle vs Time

figure

plot(data.ET,data.SA)

xlabel('Time (s)')
ylabel('Slip Angle (deg)')

title('Run 27 - Slip Angle vs Time')
%% Camber vs Time

figure

plot(data.ET,data.IA)

xlabel('Time (s)')
ylabel('Camber (deg)')

title('Run 27 - Camber vs Time')

grid on
%% Load Distribution

figure

histogram(abs(data.FZ),30)

xlabel('Vertical Load FZ (N)')
ylabel('Count')

title('Run 27 - Load Distribution')

grid on
%% Check Load Bands

FZ = abs(data.FZ);

fprintf('\n===== LOAD BANDS =====\n\n')

fprintf('Mean Load = %.1f N\n',mean(FZ))
fprintf('Median Load = %.1f N\n',median(FZ))
%% Points in Each Load Band

FZ = abs(data.FZ);

load200 = sum(FZ > 150 & FZ < 250);

load450 = sum(FZ > 400 & FZ < 500);

load650 = sum(FZ > 600 & FZ < 700);

load900 = sum(FZ > 850 & FZ < 950);

load1100 = sum(FZ > 1050 & FZ < 1150);

fprintf('\n===== POINTS IN EACH LOAD BAND =====\n\n')

fprintf('200 N Band  = %d\n',load200)

fprintf('450 N Band  = %d\n',load450)

fprintf('650 N Band  = %d\n',load650)

fprintf('900 N Band  = %d\n',load900)

fprintf('1100 N Band = %d\n',load1100)
%% Tire Curve at 650 N

FZ = abs(data.FZ);

idx = FZ > 600 & FZ < 700;

SA = data.SA(idx);
FY = data.FY(idx);

figure

plot(SA,FY,'.')

xlabel('Slip Angle (deg)')
ylabel('Lateral Force FY (N)')

title('Run 27 - 650 N Load Band')

grid on
%% Peak Force Extraction

[maxFY,index] = max(abs(FY));

peakSA = SA(index);

peakFZ = FZ(idx);
peakFZ = peakFZ(index);

muPeak = maxFY/peakFZ;

fprintf('\n===== PEAK TIRE PERFORMANCE =====\n\n')

fprintf('Peak FY = %.1f N\n',maxFY)
fprintf('Peak SA = %.2f deg\n',peakSA)
fprintf('Peak FZ = %.1f N\n',peakFZ)
fprintf('Peak Mu = %.3f\n',muPeak)
%% Camber at Peak Force

IA = data.IA(idx);

peakIA = IA(index);

fprintf('Peak IA = %.2f deg\n',peakIA)
%% Peak Point Verification

figure

scatter(SA,FY,'.')

hold on

plot(peakSA,...
    FY(index),...
    'ro',...
    'MarkerSize',10,...
    'LineWidth',2)

xlabel('Slip Angle (deg)')
ylabel('Lateral Force FY (N)')

title('650 N Load Band with Peak Point')

grid on
%% Load Sensitivity

FZ = abs(data.FZ);

loadBands = [200 450 650 900 1100];

peakFY = zeros(size(loadBands));
peakFZ = zeros(size(loadBands));
peakMu = zeros(size(loadBands));
peakSA = zeros(size(loadBands));

%% Extract Peak Values From Each Band
for i = 1:length(loadBands)

    load = loadBands(i);

    idx = FZ > load-50 & FZ < load+50;

    SA_band = data.SA(idx);
    FY_band = data.FY(idx);
    FZ_band = FZ(idx);

    [maxFY,ind] = max(abs(FY_band));

    peakFY(i) = maxFY;
    peakFZ(i) = FZ_band(ind);
    peakMu(i) = maxFY/FZ_band(ind);
    peakSA(i) = SA_band(ind);

end
fprintf('\n===== LOAD SENSITIVITY RESULTS =====\n\n')

for i = 1:length(loadBands)

    fprintf('Load Band = %4d N | Peak FY = %7.1f N | Peak Mu = %.3f | Peak SA = %.2f deg\n',...
        loadBands(i),...
        peakFY(i),...
        peakMu(i),...
        peakSA(i));

end
%% Peak FY vs Load

figure

plot(peakFZ,peakFY,'o-','LineWidth',2)

xlabel('Vertical Load FZ (N)')
ylabel('Peak Lateral Force FY (N)')

title('Peak FY vs Vertical Load')

grid on
%% Peak Mu vs Vertical Load

figure

plot(peakFZ,peakMu,'o-','LineWidth',2)

xlabel('Vertical Load FZ (N)')
ylabel('Peak Friction Coefficient \mu')

title('Peak Mu vs Vertical Load')

grid on
%% Camber Sensitivity at 650 N

FZ = abs(data.FZ);

idx650 = FZ > 600 & FZ < 700;

IA = data.IA(idx650);

fprintf('\n===== CAMBER POINTS =====\n\n')

fprintf('0 deg points = %d\n',sum(abs(IA-0) < 0.25))

fprintf('2 deg points = %d\n',sum(abs(IA-2) < 0.25))

fprintf('4 deg points = %d\n',sum(abs(IA-4) < 0.25))
%% Peak Force at Each Camber

idx0 = idx650 & abs(data.IA-0) < 0.25;
idx2 = idx650 & abs(data.IA-2) < 0.25;
idx4 = idx650 & abs(data.IA-4) < 0.25;

peakFY_0 = max(abs(data.FY(idx0)));
peakFY_2 = max(abs(data.FY(idx2)));
peakFY_4 = max(abs(data.FY(idx4)));

fprintf('\n===== CAMBER SENSITIVITY =====\n\n')

fprintf('0 deg Camber Peak FY = %.1f N\n',peakFY_0)
fprintf('2 deg Camber Peak FY = %.1f N\n',peakFY_2)
fprintf('4 deg Camber Peak FY = %.1f N\n',peakFY_4)
%% Peak FY vs Camber

camber = [0 2 4];

peakFY_camber = [peakFY_0 peakFY_2 peakFY_4];

figure

plot(camber,peakFY_camber,'o-','LineWidth',2)

xlabel('Camber (deg)')
ylabel('Peak Lateral Force FY (N)')

title('Peak FY vs Camber')

grid on
%% Cornering Stiffness - 650 N

FZ = abs(data.FZ);

idx650 = FZ > 600 & FZ < 700;

SA = data.SA(idx650);
FY = data.FY(idx650);

figure

plot(SA,FY,'.')

xlabel('Slip Angle (deg)')
ylabel('Lateral Force FY (N)')

title('Cornering Stiffness Investigation - 650 N')

grid on
%% Linear Region

idxLinear = idx650 & abs(data.SA) < 2;

SA_linear = data.SA(idxLinear);
FY_linear = data.FY(idxLinear);

figure
plot(SA_linear,FY_linear,'.')

xlabel('Slip Angle (deg)')
ylabel('Lateral Force FY (N)')
title('Linear Region - 650 N')

grid on
%% Very Small Slip Angles

idxSmall = idx650 & abs(data.SA) < 1;

figure
plot(data.SA(idxSmall),data.FY(idxSmall),'.')

xlabel('Slip Angle (deg)')
ylabel('Lateral Force FY (N)')
title('Very Small Slip Angles')

grid on
%% Cornering Stiffness Calculation

idxSmall = idx650 & abs(data.SA) < 1;

SA_small = data.SA(idxSmall);
FY_small = data.FY(idxSmall);

p = polyfit(SA_small,FY_small,1);

corneringStiffness = abs(p(1));

fprintf('\n===== CORNERING STIFFNESS =====\n\n')
fprintf('Cornering Stiffness = %.1f N/deg\n',corneringStiffness)

figure

plot(SA_small,FY_small,'.')
hold on

SA_fit = linspace(min(SA_small),max(SA_small),100);

FY_fit = polyval(p,SA_fit);

plot(SA_fit,FY_fit,'r','LineWidth',2)

xlabel('Slip Angle (deg)')
ylabel('Lateral Force FY (N)')
title('Cornering Stiffness Fit - 650 N')

legend('Data','Linear Fit')

grid on
%% Cornering Stiffness vs Load

loadBands = [250 450 650 900 1100];

corneringStiffness = zeros(size(loadBands));

for i = 1:length(loadBands)

    targetLoad = loadBands(i);

    idxLoad = abs(abs(data.FZ) - targetLoad) < 50;

    idxLinear = idxLoad & abs(data.SA) < 1;

    SA_temp = data.SA(idxLinear);
    FY_temp = data.FY(idxLinear);

    p = polyfit(SA_temp,FY_temp,1);

    corneringStiffness(i) = abs(p(1));

    fprintf('Load Band = %4.0f N | Cornering Stiffness = %.1f N/deg\n',...
        targetLoad,corneringStiffness(i))

end

figure

plot(loadBands,corneringStiffness,'o-','LineWidth',2)

xlabel('Vertical Load FZ (N)')
ylabel('Cornering Stiffness (N/deg)')

title('Cornering Stiffness vs Vertical Load')

grid on
%% MZ vs Slip Angle

FZ = abs(data.FZ);

idx650 = FZ > 600 & FZ < 700;

SA = data.SA(idx650);
MZ = data.MZ(idx650);

figure

plot(SA,MZ,'.')

xlabel('Slip Angle (deg)')
ylabel('Aligning Moment MZ (Nm)')

title('MZ vs Slip Angle - 650 N')

grid on
%% Peak MZ Extraction

[maxMZ,indexMZ] = max(abs(MZ));

peakMZ = MZ(indexMZ);

peakSA_MZ = SA(indexMZ);

peakFZ_MZ = abs(data.FZ(idx650));
peakFZ_MZ = peakFZ_MZ(indexMZ);

peakIA_MZ = data.IA(idx650);
peakIA_MZ = peakIA_MZ(indexMZ);

fprintf('\n===== PEAK MZ =====\n\n')

fprintf('Peak MZ = %.2f Nm\n',peakMZ)
fprintf('Peak SA = %.2f deg\n',peakSA_MZ)
fprintf('Peak FZ = %.1f N\n',peakFZ_MZ)
fprintf('Peak IA = %.2f deg\n',peakIA_MZ)
%% Peak MZ (Useful Region)

idxUseful = idx650 & abs(data.SA) < 10;

SA_useful = data.SA(idxUseful);
MZ_useful = data.MZ(idxUseful);

[maxMZ2,ind2] = max(abs(MZ_useful));

fprintf('\n===== PEAK MZ (USEFUL REGION) =====\n\n')
fprintf('Peak MZ = %.2f Nm\n',MZ_useful(ind2))
fprintf('Peak SA = %.2f deg\n',SA_useful(ind2))