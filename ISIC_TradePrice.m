%For joint work (Fabien Rondeau & Yushi Yoshida, 2022 June-Sep)Revised Oct,2022
%Matlab code for constructing trade price index using HS trade data
%For each 46 TiVA industry(ISIC), thid code calculates the value-weighted
%trade price index from HS-code classified database, such as JPN Custom
%data or BACI (CEPII)
clear all
clc

oldFolder=pwd;
cd ..
addpath([oldFolder,'/data'],[oldFolder,'/data/JPNTradeDataIM'],[oldFolder,'/data/JPNTradeDataIM09-']);
cd(oldFolder);

n_year=24; % 1995-2018
n_exp=33;
%TiVA database label
l_exporter={"FRA", "USA", "AUT", "BEL", "CAN", "CZE", "DNK","EST","FIN","DEU", "GRC", "HUN","IRL", "ITA", "KOR","LVA", "LTU", "LUX","NLD","NOR","POL","PRT","SVK", "SVN", "ESP","SWE", "CHE","GBR", "USA", "BRA","CHN","SGP","THA","VNM", "WLD"};
l_exporter=string(l_exporter);
%IMF IFS label
l_er={"AUT","BEL","BRA","CAN","CHN","CZE","DNK","EST","FIN","FRA","DEU","GRC","HUN","IRL","ITA","KOR","LVA","LTU","LUX","NLD","NOR","POL","PRT","SGP","SVK","SVN","ESP","SWE","CHE","THA","GBR","USA","VNM"};
l_er=string(l_er);
%Japan Custom label
l_impP=[225 208 410 302 105 245 204 235 222 210 213 230 227 206 220 103 236 237 209 207 202 223 217 112 246 242 218 203 215 111 205 304 110];
%% Choose database
% Only TiVA single industries
    %db=0;
% All TiVA industires, aggregate and single
    db=1;
    pp=0; % =0 (all), =1 (capital products, 645), =2 (consumer products, 1336), =3 (intermediate products, 3169)
    
if db==0
    l_ind={'D01','D02','D03','D05','D06','D08','D10','D11','D12','D13','D14','D15','D16','D17','D19','D20','D21','D22','D23','D26','D27','D28','D29','D31','D35','D38','D58','D59'};
else % All TiVA industries, aggregate and single
    l_ind={'D01T02','D03','D05T06','D07T08','D10T12','D13T15','D16','D17T18','D19','D20','D21','D22','D23','D24','D25','D26','D27','D28','D29','D30','D31T33','D35','D58T60'};
    l_prod={'CAP','CONS','INT'};
    l_prod=string(l_prod);
end
l_ind=string(l_ind);
%% Read input files

if db==0
% Only TiVA single industries
    file_name1="IS2HS.csv";
    T1=readtable(file_name1,'Range','A2:D3988','ReadVariableNames', false);
else
% All TiVA industires, aggregate and single
    file_name1="IS2HSver2.csv";
    T1=readtable(file_name1,'Range','A2:F5146','ReadVariableNames', false);
    A1_0(:,1)=T1(:,1);
    A1_0=table2array(A1_0);
    A1e(:,1)=T1(:,6);
    A1e=table2array(A1e);
end

A1a(:,1)=T1(:,1+db);
A1a=table2array(A1a);
A1b(:,1)=T1(:,2+db);
A1b=table2array(A1b);
A1c(:,1)=T1(:,3+db);
A1c=table2array(A1c);
A1d(:,1)=T1(:,4+db);
A1d=table2array(A1d);
jj_max=size(A1a,1);

if db==0
    A1(:,:)=horzcat(A1a,string(A1b),string(A1c),string(A1d));
else
    A1(:,:)=horzcat(A1_0,A1a,string(A1b),string(A1c),string(A1d),A1e);
end
%% weighted average price index
pv=zeros(n_year,n_exp);tv=zeros(n_year,n_exp);
for yy=1995:1995+n_year-1 %% data year
jj=0; %% starting line
for i=6:6 %%ISIC code
    if i~=1
        jj=1;
        while A1(jj,1)~=l_ind(i)
            jj=jj+1;
        end
        jj=jj-1;
    end
j=jj+1; %% corresponding line
while A1(j,1)==l_ind(i)
hs_4=A1(j,3+db);
    hs_4=str2double(hs_4);
hs_6=A1(j,4+db);
    if strlength(hs_6)==5
    hs_6=strcat("0", hs_6);
    end
    
    if and(db==1, pp~=0) % Only for CAP,CONS,INT
        if A1(j,6)~=l_prod(pp)
            j=j+1;
            continue
        end
    end
    
% file selection    
    if yy<=2008
        cod3=File_Selector(hs_4);
        yyy=string(extractBetween(num2str(yy),3,4));
%       file_name2=strcat('C:/Yushi/GVC and ER(Rondeau, Yoshida)/data/JPNTradeDataIM/d01h',yyy,'i',cod3,'.csv');
        file_name2=strcat('d01h',yyy,'i',cod3,'.csv');
    else
        cod3=File_Selector2009(hs_4);
%        file_name2=strcat('C:/Yushi/GVC and ER(Rondeau, Yoshida)/data/JPNTradeDataIM09-/ik-100h',num2str(yy),'i',cod3,'.csv');
        file_name2=strcat('ik-100h',num2str(yy),'i',cod3,'.csv');
    end

T2=readtable(file_name2,'PreserveVariableNames',true);
B1a(:,1)=table2array(T2(:,3)); %HS code
B1b(:,1)=table2array(T2(:,4)); %country code
B1c(:,1)=table2array(T2(:,8)); %quantity
B1d(:,1)=table2array(T2(:,9)); %value
k=1;k_max=size(B1a,1);

if extractBetween(B1a(k,1),2,7)~=hs_6
    while extractBetween(B1a(k,1),2,7)~=hs_6
    k=k+1;
        if k>k_max % skip if code is missing due to code change
            k=1;
            break
        end
    end
end

while extractBetween(B1a(k,1),2,7)==hs_6
    m=1;
    while 1
        if B1b(k,1)==l_impP(m)
            break
        end
        if m==33
        break
        end
        m=m+1;
    end
    if B1c(k,1)~=0
    pv(yy-1994,m)=pv(yy-1994,m)+B1d(k,1)^2/B1c(k,1);
    tv(yy-1994,m)=tv(yy-1994,m)+B1d(k,1);
    else
    end
    k=k+1;
        if k>k_max % stop at the end of file
            k=1;
            break
        end

end % corresponding hs9


j=j+1;
clear B1a B1b B1c B1d;
    if j>jj_max
    break
    end

end % next corrsponding hs6 
jj=j;

end % next j (ISIC industry)
end % next yy (year)
wp(:,:)=pv(:,:)./tv(:,:);
%% Combining with other data

file_name3="VA_Exp_Ind_Ctry.xlsx";
file_name4="IFS(NominalER,Annual).xlsx";
file_name5="Global_ULC_by_Industry.xlsx";

T3a=readtable(file_name3,'Sheet',strcat(l_ind(i),'VAXpc'),'Range','A1:AH25','ReadVariableNames',true,'ReadRowNames',false);
T3b=readtable(file_name3,'Sheet',strcat(l_ind(i),'VAMpc'),'Range','A1:AH25','ReadVariableNames',true,'ReadRowNames',false);
T4=readtable(file_name4,'Sheet','ER(ave)','Range','C3:AJ27','ReadVariableNames', true);
T5a=readtable(file_name5,'Sheet','EXP(LC)','Range','B2:AH25');
T5b=readtable(file_name5,'Sheet','EXP(CPI)','Range','B2:AH25');

A3a=str2double(table2array(T3a)); %VAXpc
A3b=str2double(table2array(T3b)); %VAMpc
A4=table2array(T4);   %ER
A5a=table2array(T5a); %Labor cost
A5b=table2array(T5b); %CPI
%% Restructuring dataset
% Reorder Tiva Data
for i2=1:n_exp % no. of country=33
j2=1;
while l_exporter(j2)~=l_er(i2)
    j2=j2+1;
end
s_er=j2; % s_er = the location of a country in TiVA data
A3a1(:,i2)=A3a(:,s_er); %VAXpc
A3b1(:,i2)=A3b(:,s_er); %VAMpc

A4a(:,i2)=A4(:,32); %USD
A4b(:,i2)=A4(:,34); %EURO
end

%% reshaping in panel format
% same number of years & same number of countries
B1=reshape(wp(:,:),[],1); %weighted unit price
B3a=reshape(A3a1(:,:),[],1);   %VAXpc
B3b=reshape(A3b1(:,:),[],1);  %VAMpc
B4=reshape(A4(:,1:33),[],1);   %exchage rate
B4a=reshape(A4a,[],1);    % usd
B4b=reshape(A4b(:,:),[],1);  % euro
B5a=reshape(A5a(:,:),[],1);  % labor cost
B5b=reshape(A5b,[],1);    % cpi
%% Variable construction
% relabeling variable names to vectors
p=log(B1(:,1));
er=log(B4(:,1));
usd=log(B4a(:,1));
eur=log(B4b(:,1));
vax=B3a(:,1);
vam=B3b(:,1);
lc=log(B5a(:,1));
cpi=log(B5b(:,1));

% constructing exporter_ID and time_ID
for i2=1:n_exp
    for t=1:n_year
d_t((i2-1)*n_year+t,1)=t;
    end
d_id((i2-1)*n_year+1:i2*n_year,1)=i2;    
end
%% Save anuual panel data in Excel
isic=l_ind(i);
if and(db==1,pp~=0)
    prodtype=l_prod(pp);
    data_name1=strcat('GVC_ERPT_data(TiVA_',isic,prodtype,').xlsx');
elseif and(db==1,pp==0)
    data_name1=strcat('GVC_ERPT_data(TiVA_all).xlsx');
else
    data_name1=strcat('GVC_ERPT_data(TiVA_',isic,').xlsx');
end
X2=[d_id d_t p vax vam er usd eur lc cpi];
xlswrite(data_name1, X2);