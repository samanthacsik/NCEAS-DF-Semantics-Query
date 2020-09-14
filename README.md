# NCEAS-DF-Semantics-Query

My first attempts at using Bryce Mecum's `eatocsv` [package](https://github.com/amoeba/eatocsv) and code modified by [Steven Chong](https://github.nceas.ucsb.edu/stevenchong/adc-controlled-voc) to extract attribute information from Arctic Data Center holdings. 

This repo is used to store practice attemps (primarily using a small subset of ADC holdings) and to figure out an effective file structure. 

For more formal analyses and progress on my semantics analysis work as a 2020 Data Science Fellow with the National Center for Ecological Analysis & Synthesis ([NCEAS](https://www.nceas.ucsb.edu/)) and the [Arctic Data Center](https://arcticdata.io/), see this [repo](https://github.com/samanthacsik/NCEAS-DF-Semantics-Project). 

### Repository Structure

```
NCEAS-DF-Semantics-Query
  |_ code
  |_ data
    |_ queries
    |_ identifiers
    |_ extracted_attributes
```

### Software

These analyses were performed in R (version ?) on the datateam server (NCEAS)

### Code 

*`ORIGINAL_download_EA_metadata_by_identifier.R`: original code by Steven Chong to extract attribute information from ADC data holdings using Bryce Mecum's `eatocsv` package using data package identifiers
*`download_EA_metadata_by_identifier.R` : my modified code that first uses a solr query to extract data package identifiers, followed by slightly modified code from the `ORIGINAL ` file (above)

### Data

* `data/queries` : contains results of solr queries used to extract data package identifiers. Stored as .csv files with the naming scheme as follows -- **PRACTICEqueryYYYY-MM-DD.csv**
* `data/identifiers/etc` : contains the results of solr queries (same as above) with along with all downloaded .xml files. These are stored in a further subdirectory, `xml`
* `data/extracted_attributes` : .csv file(s) containing data package identifiers and their  associated attributes with the naming scheme as follows -- **PRACTICEqueryYYY-MM-DD_attributes.csv**


