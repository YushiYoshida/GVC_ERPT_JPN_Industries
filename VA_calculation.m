% Matlab code for joint work (Fabien Rondeau and Yushi Yoshida, 2022)
% The first code is modified in October, 2022 to handle other importing
% countries.
% This code constructs a large matrix of VA from individual files which
% contain VA from a exporting country to Japan(or any other importer). 
%Note that VA_matrix.mat contains value added by all source countries.
% Modified (June 2023) to add Mexico

clear
%clc
nctry=84;nyear=24;nind=70;
s_year=0;s_ind=0;s_ctry=0;
nob=141120;
% select importer(This version only for Japan, you need the data source for other countires.)
imp_num=16; %JPN 16, do not change this number 
% for just reference...FRA 10, GBR 33,CHN 5, DEU 11, USA 34,THA 32, POL 23,BRA 3, CAN 4, KOR 17,ITA 15, MEX 35

l_year={'1995','1996','1997','1998','1999','2000','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018'};
%l_year={1995,1996,1997,1998	1999	2000	2001	2002	2003	2004	2005	2006	2007	2008	2009	2010	2011	2012	2013	2014	2015	2016	2017	2018};
l_ind={'D01T02','D01T03','D03','D05T06','D05T09','D05T39','D07T08','D09','D10T12','D10T33','D13T15','D16','D16T18','D17T18','D19','D19T23','D20','D20T21','D21','D22','D23','D24','D24T25','D25','D26','D26T27','D27','D28','D29','D29T30','D30','D31T33','D35','D35T39','D36T39','D41T43','D41T98','D45T47','D45T56','D45T82','D45T98','D49','D49T53','D50','D51','D52','D53','D55T56','D58T60','D58T63','D58T82','D61','D62T63','D64T66','D68','D69T75','D69T82','D77T82','D84','D84T88','D84T98','D85','D86T88','D90T93','D90T96','D90T98','D94T96','D97T98','DINFO','DTOTAL'
};
l_ctry={'MAR','APEC','ARG','ASEAN','AUS','AUT','BEL','BGR','BRA','BRN','CAN','CHE','CHL','CHN','COL','CRI','CYP','CZE','DEU','DNK','EA19','EASIA','ESP','EST','EU13','EU15','EU27_2020','EU28','FIN','FRA','G20','GBR','GRC','HKG','HRV','HUN','IDN','IND','IRL','ISL','ISR','ITA','JPN','KAZ','KHM','KOR','LAO','LTU','LUX','LVA','MEX','MLT','MMR','MYS','NLD','NONOECD','NOR','NZL','OECD','PER','PHL','POL','PRT','ROU','ROW','RUS','SAU','SGP','SVK','SVN','SWE','THA','TUN','TUR','TWN','USA','VNM','WLD','ZAF','ZASI','ZEUR','ZNAM','ZOTH','ZSCA'
};
l_exporter=["AUT", "BEL","BRA", "CAN","CHN", "CZE", "DNK","EST","FIN","FRA","DEU", "GRC", "HUN","IRL", "ITA", "JPN","KOR","LVA", "LTU", "LUX","NLD","NOR","POL","PRT", "SGP","SVK","VNM", "SVN", "ESP","SWE", "CHE","THA","GBR", "USA", "MEX","WLD"];
l_exporter=string(l_exporter);
l_year=str2double(l_year);
l_ind=string(l_ind);
l_ctry=string(l_ctry);
VA=zeros(36,nyear,nind,nctry);
%% Load and set up data
importer=l_exporter(imp_num);
%T=readtable('data\df_France.xlsx','ReadRowNames',true);
for ex=1:36 %number of countries (with world) is 36
clear T;
    %skip importing country
    if ex==imp_num
    continue
    end

s_exporter=l_exporter(ex);
% for France imports
file_name="data("+importer+")\"+s_exporter+"_"+importer+".xlsx";

%file_name="data\Data_byExporter\"+s_exporter+".xlsx";
%T=readtable('data(GBR)\GVCIM.xlsx','Sheet',s_exporter,'ReadRowNames',true);
T=readtable(file_name,'ReadRowNames',true);

%file_name="data(GBR)\GVCIM_GBR.xlsx";
%T=readtable(file_name,'Sheet',s_exporter,'ReadRowNames',true);

T.ObsValue=str2double(T.ObsValue);
T.Time = str2double(T.Time);
T.XIND=string(T.XIND);
T.SCOU=string(T.SCOU);

%% Aggregate & obtain VAX, VAM, VAT for a given exporting country
   
    for i=1:nob
        %for j=1:nyear
        j=1;
        while T.Time(i)~=l_year(j)
        j=j+1;
        end
        s_year=j;

        k=1;
        while T.XIND(i)~=l_ind(k)
        k=k+1;
        end
        s_ind=k;

        l=1;
        while T.SCOU(i)~=l_ctry(l)
        l=l+1;
        end
        s_ctry=l;

        %for k=1:nind
        %    if T.XIND(i)==l_ind(k)
        %    s_ind=k;
        %    end
        %end
        %for l=1:nctry
        %    if T.SCOU(i)==l_ctry(l)
        %    s_ctry=l;
        %    end
        %end
    VA(ex,s_year,s_ind,s_ctry)=VA(ex,s_year,s_ind,s_ctry)+T.ObsValue(i);
    end
end
%% Saving the results
save VA_matrix.mat