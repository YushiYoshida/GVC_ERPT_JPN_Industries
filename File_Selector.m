% This code finds appropriate file for specific HS4 code between 1988 and
% 2008 for imports
function cod3=File_Selector(hs_4)

if hs_4<=599
cod3 = '001';
elseif hs_4<=1499
cod3 = '002';
elseif hs_4<= 1599
cod3 = '003';
elseif hs_4<= 2499
cod3 = '004';
elseif hs_4<= 2799
cod3 = '005';
elseif hs_4<= 3099
cod3 = '006';
elseif hs_4<= 3899
cod3 = '007';
elseif hs_4<= 4099
cod3 = '008';
elseif hs_4<= 4399
cod3 = '009';
elseif hs_4<= 4699
cod3 = '010';
elseif hs_4<= 4999
cod3 = '011';
elseif hs_4<= 5599
cod3 = '012';
elseif hs_4<= 6099
cod3 = '013';
elseif hs_4<= 6199
cod3 = '014';
elseif hs_4<= 6399
cod3 = '015';
elseif hs_4<= 6799
cod3 = '016';
elseif hs_4<= 7099
cod3 = '017';
elseif hs_4<= 7199
cod3 = '018';
elseif hs_4<= 7499
cod3 = '019';
elseif hs_4<= 8399
cod3 = '020';
elseif hs_4<= 8430
cod3 = '021';
elseif hs_4<= 8470
cod3 = '022';
elseif hs_4<= 8485
cod3 = '023';
elseif hs_4<= 8520
cod3 = '024';
elseif hs_4<= 8548
cod3 = '025';
elseif hs_4<= 8999
cod3 = '026';
elseif hs_4<= 9299
cod3 = '027';
elseif hs_4<= 9399
cod3 = '028';
elseif hs_4<= 9699
cod3 = '029';
elseif hs_4<= 9799
cod3 = '030';
end
end