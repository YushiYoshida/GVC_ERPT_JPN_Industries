# GVC_ERPT_JPN_Industries
The Matlab codes and the dataset for "Global Value Chains and Exchange Rate Pass-Through into the Import Prices of Japanese Industries," by Fabien Rondeau and Yushi Yoshida, Japan and the World Economy, 2025 forthcoming


*** 1st step: VAM and VAX calculation *************

(i) Run VA_caluculation.m

(ii) Run VAX_VAM.m


*** 2nd step: Price data construction **************

Price data construction & combining with other variables (exchange rate, VAX, VAM, ...): (you can skip this part because the price dataset is provided. The source files are not all uploaded due to the constraint of 1,000 files; see below for more detail)
ISIC_TradePrice.m ... constructs a weighted unit-value price for the industry level, combined with value-added variables, labor costs, and consumer price index. In the end, it produced the dataset in Excel format.

The other two Matlab codes are auxiliaries, only used by the main Matlab code 'ISIC_TradePrice.m' 

The problem with uploading Japanese trade data files before 2008 is not currently fixed yet (March 07, 2025); there are over 1,000 files. 


*** Data folder descriptions

"Data(JPN)"

This folder contains value-added source files for each country exporting to Japan. These files are retrieved by Fabien Rondeau's R codes. 


"Data"...
This folder contains thousands of files for HS 9-digit level Japanese import data.


"Data for regression"
