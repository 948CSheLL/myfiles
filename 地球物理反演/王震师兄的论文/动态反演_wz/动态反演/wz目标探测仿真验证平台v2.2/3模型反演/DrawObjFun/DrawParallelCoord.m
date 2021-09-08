load data
labels = {'x', 'y', 'z', 'M1', 'M2', 'M3', 'M4', 'M4', 'M5', 'M6'};

dataVar = data(:,1:9);
dataVal = data(:,10);
nVar = size(dataVar,2);

figure color w
[low1, high1] = bounds(dataVar,1);
[low2, high2] = bounds(dataVal);

linePlot = line(1 : nVar, (dataVar - low1) ./ (high1 - low1),'color',[0.5,0.5,0.5]);