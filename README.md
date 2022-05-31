
 Hochman, G., & Zilberman, D. (2021). **[Optimal environmental taxation in response to an environmentally-unfriendly political challenger]([url](https://doi.org/10.1016/j.jeem.2020.102407))**. Journal of Environmental Economics and Management, 106, 102407.


# Code Description

## Usage

**Start a parallel pool**

This code uses parfor loops to speed up run time. You can start a parallel pool before running the code or it will do so automatically. The following command starts the parallel pool.
```
parpool
```

## Main

The [main.m file](model/main.m) optimizes the taxes and prices for a given set of parameters. A default set of parameters from the paper can be loaded with [loadParameters.m](model/loadParameters). The main code first does an initial simulation with guesses, and then uses [optimizeTaxesPrices.m](model/optimizeTaxesPrices.m) to get the optimal taxes and prices. You can specify optimization parameters, tax_1a_type and tax_2a_type, which allow you to compute the optimal prices without taxes and with mypoic tax policy. The results for each run are stored as results_row. 


## Replication

The results from the paper can be replicated using [generateResults.m](model/generateResults.m). This code uses the optimization algorithm to generate results across a range of parameters. The results are stored in results_array; a formatted version of this information is [results.xlsx](results/results.xlsx).


### Plot Region

The [plotRegion.m file](model/plotRegion.m) produces survival region by plotting a series of vertical lines close enough such that an area plot is produced. The borders of each plot are defined by the optimal decision that a firm with a given input cost *x* and pollution output *β* can make given a set of exogenous and endogenous parameters. The error tolerance parameter defines how accurate the borders are between each decision region. Increasing the number of points increases the number of these lines, but increases the time taken to plot and the figure's file size. The same applies to the number of markers and inversely to the error tolerance. The inBW parameter simply converts the colors to a black and white shade. The following table is a key for the markers used in the survival region plots. 

Marker | Description
---- | ----
• | Idle
🞶 | Produce (1), Idle (2a), Produce (2b)
x | Produce (1), Invest (2a), Produce (2b)
o | Produce (1), Produce (2)
\+ | Invest (1), Produce (2)
△ | Invest (1), Idle (2a), Produce (2b)
▽ | Produce (1), Produce (2), Idle (2b)
□ | Other
 
