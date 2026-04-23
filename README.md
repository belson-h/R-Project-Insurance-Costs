# R-Project-Insurance-Costs

**Case:** Insurance Costs - Analysis of Factors Related to Costs

In this project I act as an analyst at an insurance company. The company has historical data on customers and costs, and wants to better understand whether pricing seems to follow reasonable patterns and which factors drive costs the most. They also want to investigate whether a regression model can be used to support future pricing of similar customers.

The company has collected information about customers, lifestyle factors, health-related variables, and past history. My task is to analyze the data to investigate which variables seem to be most related to insurance costs and build a regression model in R.

**The project:**

-   Examines and describes the data

-   Cleans and prepares the data

-   Produces statistical summaries and visualizations

-   Builds and interprets three regression models

-   Discusses the model's strengths, weaknesses, and limitations

## Project structure

**Data**

-   insurance_costs.csv - raw data set provided to conduct the analysis

**Scripts**

-   run_analysis.R - master scripted, runs all scripts in order

-   01_load_data.R - loads the data and provides an overview

-   02_prepare_data.R - data cleaning, transformation and new variables

-   03_descriptive_analysis.R - statistical summaries and visualizations

-   04_regression analysis.R - regression models, evaluation and comparison

**Output**

Figures generated during the analysis.

**Report**

-   insurance_costs_report.qmd - Quarto source file for the report
-   insurance_costs_report.pdf - Final rendered report

## Important libraries

The following R packages are required to run the analysis:

- `tidyverse` - data manipulation and visualization
- `patchwork` - combining multiple ggplot figures

Install all packages by running:

``` R
install.packages(c("tidyverse", "patchwork"))
```

## How to run the project

1.  Clone or download the project and open `R-Project-Insurance-Costs.Rproj` in RStudio to ensure all file paths work correctly.

2.  Make sure the required packages are installed (see above).

3.  Run `run_analysis.R` to execute all scripts in order. This will load, clean and analyze the data, and save all figures to the `output/`-folder.

4.  To render the report, open `insurance_costs_report.qmd` in RStudio and click **Render**, or run the following in the console:

    ``` R
    quarto::quarto_render("report/insurance_costs_report.qmd")
    ```

5.   Or read `insurance_costs_report.pdf` for a summarized report.

## Enviroment

-   R version 4.5.3

-   RStudio version 2026.01.1 + 403 "Apple Blossom" Release
