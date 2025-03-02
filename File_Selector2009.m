% This code finds appropriate file for specific HS4 code after
% 2009 for imports or exports
function cod3=File_Selector2009(hs_4)

if hs_4<=599
cod3 = '001';
elseif hs_4<=1499
cod3 = '002';
elseif hs_4<=1599
cod3 = '003';
elseif hs_4<=2499
cod3 = '004';
elseif hs_4<=2799
cod3 = '005';
elseif hs_4<=3899
cod3 = '006';
elseif hs_4<=4099
cod3 = '007';
elseif hs_4<=4399
cod3 = '008';
elseif hs_4<=4699
cod3 = '009';
elseif hs_4<=4999
cod3 = '010';
elseif hs_4<=6399
cod3 = '011';
elseif hs_4<=6799
cod3 = '012';
elseif hs_4<=7099
cod3 = '013';
elseif hs_4<=7199
cod3 = '014';
elseif hs_4<=8399
cod3 = '015';
elseif hs_4<=8599
cod3 = '016';
elseif hs_4<=8999
cod3 = '017';
elseif hs_4<=9299
cod3 = '018';
elseif hs_4<=9399
cod3 = '019';
elseif hs_4<=9699
cod3 = '020';
elseif hs_4<=9799
cod3 = '021';
%elseif hs_4<=0099
%cod3 = '022';
end
end