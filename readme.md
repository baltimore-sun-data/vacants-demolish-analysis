# Baltimore vacant buildings to be demolished analysis

## Baltimore Sun analysis

By [Christine Zhang](mailto:czhang@baltsun.com)

The Baltimore Sun obtained a list of vacant buildings to be demolished from the Baltimore City Department of Housing and Community Development. The Sun's analysis provided information for a March 15, 2019 Baltimore Sun story titled ["Once again, Baltimore officials say they'll demolish more vacants — pledging to take down 2,000 in coming year."](https://www.baltimoresun.com/news/maryland/politics/bs-md-ci-vacant-demolition-20190214-story.html)

The Sun's findings and analysis are available in the "analysis" markdown file in this repository: [`02_analysis.md`](https://github.com/baltimore-sun-data/vacants-demolish-analysis/blob/master/02_analysis.md). The pre-processing code is in the "processing" markdown file in this repository: [`01_processing.md`](https://github.com/baltimore-sun-data/vacants-demolish-analysis/blob/master/01_processing.md). 

If you'd like to run the code yourself in R, you can download the R Markdown files [`01_processing.Rmd`](https://github.com/baltimore-sun-data/vacants-demolish-analysis/blob/master/01_processing.Rmd) and [`02_analysis.Rmd`](https://github.com/baltimore-sun-data/vacants-demolish-analysis/blob/master/02_analysis.Rmd) along with the data in the `input` folder.

The code used to create the line graph in the story of vacant buildings over time is in [`line_graph.R`](https://github.com/baltimore-sun-data/vacants-demolish-analysis/blob/master/line_graph.R).

The raw datasets are saved in the `input` folder.  The cleaned list of properties to be demolished is in the `output` folder under [`demolish_list_clean.csv`](https://github.com/baltimore-sun-data/vacants-demolish-analysis/blob/master/output/demolish_list_clean.csv). The historical data of vacants over time was provided by the Department of Housing and Community Development and is saved in [`input/vbn_count_by_date.csv`](https://github.com/baltimore-sun-data/vacants-demolish-analysis/blob/master/input/vbn_count_by_date.csv). These two files are also provided in a Google folder, available at www.baltimoresun.com/vacants-demolish-data.

https://twitter.com/baltsundata

## Community Contributions

There are many angles to explore with this data, beyond just the ones we looked into for our story. 

**Have something to contribute?** Send us a pull request or contact us on Twitter [@baltsundata](https://twitter.com/baltsundata) or via [email](mailto:czhang@baltsun.com).

You can also fork a copy of this repo to your own account.

## Licensing

All code in this repository is available under the [MIT License](https://opensource.org/licenses/MIT). The data files are available under the [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/) (CC BY 4.0) license.