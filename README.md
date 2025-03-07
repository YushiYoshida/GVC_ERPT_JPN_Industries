# GVC_ERPT_JPN_Industries
The Matlab codes and the dataset for "Global Value Chains and Exchange Rate Pass-Through into the Import Prices of Japanese Industries," by Fabien Rondeau and Yushi Yoshida, Japan and the World Economy, 2025 forthcoming

*** Price data construction **************//
Price data construction: (you can skip this part because the price dataset is provided. The source files are not all uploaded due to the constraint of 1,000 files, see below for more detail)
ISIC_TradePrice.m ... constructs a weighted unit-value price for the industry level, combined with value-added variables, labor costs, and consumer price index. In the end, it produced the dataset in Excel format.

The other two Matlab codes are auxiliaries, only used by the main Matlab code 'ISIC_TradePrice.m' 

The problem with uploading Japanese trade data files before 2008 is not currently fixed yet (March 07, 2025); there are over 1,000 files. 

*** VAM and VAX calculation *************
(i) Run 
