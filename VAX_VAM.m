% Matlab code for joint work (Fabien Rondeau and Yushi Yoshida, 2022)
% This code extracts VAX and VAM from VA_matrix.mat
% The first part aggregates VAX and VAM over exporting countries, 9 industries 
% The last part constructs VAX and VAM for each exporter for over 50
% industries

clear
%clc
load VA_matrix.mat;
imp_num=43; % JPN(43) Do not change this number unless you have other data source.
% for refernce only, FRA(30), GBR(32),USA(76),ITA(42),DEU(19),CAN(11),THA(72),POL(62),KOR(46),BRA(9),CHN(14),MEX(51)

l_ctry={'MAR','APEC','ARG','ASEAN','AUS','AUT','BEL','BGR','BRA','BRN','CAN','CHE','CHL','CHN','COL','CRI','CYP','CZE','DEU','DNK','EA19','EASIA','ESP','EST','EU13','EU15','EU27_2020','EU28','FIN','FRA','G20','GBR','GRC','HKG','HRV','HUN','IDN','IND','IRL','ISL','ISR','ITA','JPN','KAZ','KHM','KOR','LAO','LTU','LUX','LVA','MEX','MLT','MMR','MYS','NLD','NONOECD','NOR','NZL','OECD','PER','PHL','POL','PRT','ROU','ROW','RUS','SAU','SGP','SVK','SVN','SWE','THA','TUN','TUR','TWN','USA','VNM','WLD','ZAF','ZASI','ZEUR','ZNAM','ZOTH','ZSCA'
};
l_ctry=string(l_ctry);
file1=strcat(l_ctry(imp_num),'VA_Ind_Ctry.xlsx');
file2=strcat(l_ctry(imp_num),'VA_Exp_Ind_Ctry.xlsx');
%% Prepare VAX matrices
% VA=zeros(35,nyear,nind,nctry);
VAX=zeros(nyear, nind, 3); %VAX, VAM, GrossExport
VAXpc=zeros(nyear,nind,2); %VAXpc, VAMpc

%% Aggregate over 36 exporters

for i=1:ex-1
    j=1;
    while l_ctry(j)~=l_exporter(i) 
    j=j+1;
    end
   VAX(:,:,1)=VAX(:,:,1)+squeeze(VA(i,:,:,j)); % VAX
   VAX(:,:,2)=VAX(:,:,2)+squeeze(VA(i,:,:,imp_num)); % VAM Japan is located in the 43rd in list
   VAX(:,:,3)=VAX(:,:,3)+squeeze(VA(i,:,:,78)); % World is located in the 78th in list
end 
%%
VAXpc(:,:,1)=VAX(:,:,1)./VAX(:,:,3);
VAXpc(:,:,2)=VAX(:,:,2)./VAX(:,:,3);
%% Save in Excel
VAX_1a(:,:)=squeeze(VAX(:,:,1));VAX_1=vertcat(l_ind,VAX_1a);
VAX_2a(:,:)=squeeze(VAX(:,:,2));VAX_2=vertcat(l_ind,VAX_2a);
VAX_3a(:,:)=squeeze(VAX(:,:,3));VAX_3=vertcat(l_ind,VAX_3a);
writematrix (VAX_1,file1,'sheet','VAX' );
writematrix (VAX_2,file1,'sheet','VAM' );
writematrix (VAX_3,file1,'sheet','VAWorld' );
VAXpc_1a(:,:)=squeeze(VAXpc(:,:,1));VAXpc_1=vertcat(l_ind,VAXpc_1a);
VAXpc_2a(:,:)=squeeze(VAXpc(:,:,2));VAXpc_2=vertcat(l_ind,VAXpc_2a);
writematrix (VAXpc_1,file1,'sheet','VAXpc' );
writematrix (VAXpc_2,file1,'sheet','VAMpc' );

%% *** For Each Exporter ****
% Prepare by-exporter VAX matrices

% VA=zeros(35,nyear,nind,nctry);
cVAX=zeros(36,nyear, nind, 3); %VAX, VAM, GrossExport
cVAXpc=zeros(36,nyear,nind,2); %VAXpc, VAMpc
%% Extract VAX and VAM for 35 individual exporters

for i=1:ex-1
    j=1;
    while l_ctry(j)~=l_exporter(i) 
    j=j+1;
    end
   cVAX(i,:,:,1)=VA(i,:,:,j); % VAX
   cVAX(i,:,:,2)=VA(i,:,:,imp_num); % VAM Japan is located in the 43rd in list
   cVAX(i,:,:,3)=VA(i,:,:,78); % World is located in the 78th in list
end 
%%
cVAXpc(:,:,:,1)=cVAX(:,:,:,1)./cVAX(:,:,:,3);
cVAXpc(:,:,:,2)=cVAX(:,:,:,2)./cVAX(:,:,:,3);
%% Save in Excel
%cVAX_1a(:,:,:)=squeeze(cVAX(:,:,:,1));cVAX_1=vertcat(l_ind,cVAX_1a);
%cVAX_2a(:,:,:)=squeeze(cVAX(:,:,:,2));cVAX_2=vertcat(l_ind,cVAX_2a);
%cVAX_3a(:,:,:)=squeeze(cVAX(:,:,:,3));cVAX_3=vertcat(l_ind,cVAX_3a);
%writematrix (cVAX_1,'VA_Exp_Ind_Ctry.xlsx','sheet','VAX' );
%writematrix (cVAX_2,'VA_Exp_Ind_Ctry.xlsx','sheet','VAM' );
%writematrix (cVAX_3,'VA_Exp_Ind_Ctry.xlsx','sheet','VAWorld' );
for k=1:69
cVAXpc_1a(:,:)=squeeze(cVAXpc(:,:,k,1));
cVAXpc_1=vertcat(l_exporter,transpose(cVAXpc_1a));
cVAXpc_2a(:,:)=squeeze(cVAXpc(:,:,k,2));
cVAXpc_2=vertcat(l_exporter,transpose(cVAXpc_2a));
s_name=l_ind(k);
writematrix (cVAXpc_1,file2,'sheet',strcat(s_name,'VAXpc') );
writematrix (cVAXpc_2,file2,'sheet',strcat(s_name,'VAMpc') );
end