%% A thermal trade-off between viral production and degradation drives phytoplankton-virus population dynamics
% Figure 5 -- Ecological states biogeogrpahy given SST projection at global scale.
% David Demory -- Jan 2021

clear all; close all; clc;

% add folder for m_map
folder = "../data/";
addpath(genpath(folder));

%% SST projections
% Download Temperature % https://cera-www.dkrz.de/WDCC/ui/cerasearch/q?query=*:*&page=0&hierarchy_steps_ss=GFDL_CM2.1_SRESA2_1&entry_type_s=dataset
% download: http://www.ipcc-data.org/
% http://www.ipcc-data.org/sim/gcm_monthly/SRES_AR4/index.html

file_name = '../data/GFCM21_SRA2_1_N_ts.1-1200.nc';
%get info:
%ncdisp(file_name)

% get time (years)
timep = ncread(file_name,'time');

% get SST in celcius
sstp = ncread(file_name,'ts')-273.15;

% get dates
dtp = datetime(timep*24*3600, 'ConvertFrom', 'epochtime', 'Epoch', '1960-01-01');

%% Temperature present (2010 - 2020)
% T present
% first and last months of the present period
id1p = find(dtp == '03-Jan-2010 12:00:00');
id2p = find(dtp == '01-Jan-2020 12:00:00');
% average temperature for the present period
sstmeanp = nanmean(sstp(:,:,id1p:id2p),3); % temp mean from 2010 to 2020;
% clean the data (numerical errors and land locations)
sstmeanp(sstmeanp <= -1.8) = -1.8;
sstmeanp(sstmeanp == -Inf) = NaN;
% get longitudes and latitudes
lonp = ncread(file_name,'lon');
latp = ncread(file_name,'lat');
% SST data for the present period (in double)
SSTglobp = double(sstmeanp);
% grid data and clean-up (important for the m_map package)
[LG,LT]=meshgrid(0:360,-89:89);
mapP=ones(size(LG));
mapP = griddata(lonp,latp,SSTglobp',LG,LT,'cubic');
ind=[1:331 1:60]; % Move left side to right
mapP=mapP(:,ind);
LT=LT(:,ind);
LG=LG(:,ind);
LG(LG>1)=LG(LG>1)-360; %...and subtract 360 to some longitudes

%% Plots

% color
Cabs = [1 1 1];                % abscence
Cpres = [[248,118,109]/255;
    [83,180,0]/255]
Tplysis=[23.1,15.1,21.2,13.9];



% presence
hfig = figure('color','white','position',[0 0 1000 4000]);

% Loop over the pairs
for s = 1:4;

    if s == 1
        a= readtable('../data/matlab.A.csv');
        TP.lon = a.lon(a.ROC == "TP")
        TP.lat = a.lat(a.ROC == "TP")
        TN.lon = a.lon(a.ROC == "TN")
        TN.lat = a.lat(a.ROC == "TN")
        FP.lon = a.lon(a.ROC == "FP")
        FP.lat = a.lat(a.ROC == "FP")
        FN.lon = a.lon(a.ROC == "FN")
        FN.lat = a.lat(a.ROC == "FN")
        TRUE.lon = a.lon(a.Prediction == "True")
        TRUE.lat = a.lat(a.Prediction == "True")
        FALSE.lon = a.lon(a.Prediction == "False")
        FALSE.lat = a.lat(a.Prediction == "False")
    elseif s == 2
        a= readtable('../data/matlab.B.csv');
        TP.lon = a.lon(a.ROC == "TP")
        TP.lat = a.lat(a.ROC == "TP")
        TN.lon = a.lon(a.ROC == "TN")
        TN.lat = a.lat(a.ROC == "TN")
        FP.lon = a.lon(a.ROC == "FP")
        FP.lat = a.lat(a.ROC == "FP")
        FN.lon = a.lon(a.ROC == "FN")
        FN.lat = a.lat(a.ROC == "FN")
        TRUE.lon = a.lon(a.Prediction == "True")
        TRUE.lat = a.lat(a.Prediction == "True")
        FALSE.lon = a.lon(a.Prediction == "False")
        FALSE.lat = a.lat(a.Prediction == "False")
    elseif s == 3
        a= readtable('../data/matlab.C.csv');
        TP.lon = a.lon(a.ROC == "TP")
        TP.lat = a.lat(a.ROC == "TP")
        TN.lon = a.lon(a.ROC == "TN")
        TN.lat = a.lat(a.ROC == "TN")
        FP.lon = a.lon(a.ROC == "FP")
        FP.lat = a.lat(a.ROC == "FP")
        FN.lon = a.lon(a.ROC == "FN")
        FN.lat = a.lat(a.ROC == "FN")
        TRUE.lon = a.lon(a.Prediction == "True")
        TRUE.lat = a.lat(a.Prediction == "True")
        FALSE.lon = a.lon(a.Prediction == "False")
        FALSE.lat = a.lat(a.Prediction == "False")
    elseif s == 4
        a= readtable('../data/matlab.Pol.csv');
        TP.lon = a.lon(a.ROC == "TP")
        TP.lat = a.lat(a.ROC == "TP")
        TN.lon = a.lon(a.ROC == "TN")
        TN.lat = a.lat(a.ROC == "TN")
        FP.lon = a.lon(a.ROC == "FP")
        FP.lat = a.lat(a.ROC == "FP")
        FN.lon = a.lon(a.ROC == "FN")
        FN.lat = a.lat(a.ROC == "FN")
        TRUE.lon = a.lon(a.Prediction == "True")
        TRUE.lat = a.lat(a.Prediction == "True")
        FALSE.lon = a.lon(a.Prediction == "False")
        FALSE.lat = a.lat(a.Prediction == "False")
    end
    % Evaluate the states
    Tp = Tplysis(s)

    % Estimate the ecological state matrix for present period
    ecoTp = mapP;
    ecoTp(mapP<Tp) = 1;  % Presence
    ecoTp(mapP>=Tp) = 0; % Abscence

    % present maps
    ax = subplot(4,1,s);
    % package m_map
    m_proj('robinson','long',[-180 179])
    m_pcolor(wrapTo180(LG),LT,ecoTp);
    colormap(ax,[Cabs;[0.75 0.75 0.75]])
    caxis([0 1])

    hold on
    m_plott(TP.lon,TP.lat,'ko','MarkerSize',8,'MarkerFaceColor','#7bc043')
    m_plott(TN.lon,TN.lat,'ko','MarkerSize',8,'MarkerFaceColor','#0392cf')
    m_plott(FP.lon,FP.lat,'ko','MarkerSize',8,'MarkerFaceColor','#f37736')
    m_plott(FN.lon,FN.lat,'ko','MarkerSize',8,'MarkerFaceColor','#ffd966')

    % world coast
    m_coast('patch',[250,240,230]/255,'edgecolor','k');
    % axis limits
    if s == 4
        m_grid('tickdir','out','LineWidth',2,'FontSize',8,'box','on','xlabeldir','end','xtick',([-180,-120,-60,0,60,120,180]))%,'xticklabel',{'180°W','120°W','60°W','0','60°E','120°E','180°E'})
    else
        m_grid('tickdir','out','LineWidth',2,'FontSize',8,'box','on','Xticklabels','');
    end

    % Turn the angles of xtick vertical
    xtickangle(45)


end

set(findall(gcf,'-property','FontSize'),'FontSize',12)

%% Save figure
set(gcf,'renderer','Painters')
print(hfig,'-dsvg','-r600','-painters','../figures/figure5_MicV_distribution_map.svg')
print(hfig,'-dpdf','-r600','-painters','../figures/figure5_MicV_distribution_map.pdf')


