### This script downloads entity-attribute metadata from data packages in the Arctic Data Center (https://arcticdata.io/).
#   Users have two options:  

#   Option 1 allows users to obtain entity-attribute metadata from individual data packages. Users specify a data package and a CSV file
#   is output containing metadata from the data package.

#   Option 2 allows users to obtain entity-attribute metadata from multiple data packages. The second option uses as input a
#   CSV file containing package identifiers. A single CSV file is output containing metadata from each data package.

#   The CSV output from either option contains package identifiers, entity names, attribute names, attribute labels, 
#   attribute definitions, attribute units, and a date/time stamp for when the entity-attribute metadata were downloaded.



### Install packages, as needed.  
# The remotes package is installed from CRAN.  THe amoeba/eatocsv package is installed from the amoeba/eatocsv@master GitHub repo. 
# For additional information visit: https://github.com/amoeba/eatocsv/blob/master/README.md
install.packages("remotes")
remotes::install_github("amoeba/eatocsv")


### Libraries
library(dataone)
library(eatocsv)

### OPTION 1: Obtain entity-attribute metadata from a single data package in the Arctic Data Center

# This section downloads entity-attribute metadata for a specific data package in the Arctic Data Center.  After specifying the identifier, 
# entity-attribute metadata for the data package will be downloaded and output to a CSV file.

# Change the example package identifier to the intended one
identifier <- "doi:10.18739/A2469W"

# Download the XML file containing attribute-level metadata for the data package
cn <- CNode("PROD")
download_objects(cn, pids = identifier)

# Extract attribute-level metadata from the downloaded XML file
document_paths <- paste0( gsub("[:/.]", "_",identifier), ".xml")
attributes <- extract_ea(document_paths)

# Add the identifier as a prefix to the output CSV file. Substitutions made to colon, period and forward slash for file naming.  
file_prefix <- gsub("\\:","", identifier)
file_prefix <- gsub("\\.","-", file_prefix)
file_prefix <- gsub("\\/", "_",file_prefix)

# Create the CSV file containing the entity-attribute metadata.
write.csv(attributes, file = paste0(file_prefix, "_attributes.csv"), row.names = FALSE)
print(paste0(file_prefix, "_attributes.csv created"))


### OPTION 2: Obtain entity-attribute metadata from multiple data packages in the Arctic Data Center

# This section downloads entity-attribute metadata from multiple data packages in the Arctic Data Center. A CSV file containing a column
# of package identifiers is used as input.  It is assumed the input file has a column header named "identifier".
# XML files containing entity-attribute metadata for each data package are downloaded and extracted to a single CSV file.
# 
# NOTE: Ensure that the working directory contains no other CSV files aside from the one containing the identifiers and 
# no other XML files aside from the downloaded files because all XML files in the directory will be processed.

# Read in the CSV file containing the package identifiers
identifiers_file <- list.files(full.names = TRUE, pattern = "*.csv")

identifiers_df <- read.csv(identifiers_file, stringsAsFactors = FALSE)

# Download XML files for each data package
for (identifier in identifiers_df$identifier){
	
	cn <- CNode("PROD")
	download_objects(cn, pids = identifier)
}

# Extract attribute-level metadata from all downloaded xml files in the working directory
document_paths <- list.files(getwd(), full.names = TRUE, pattern = "*.xml")
attributes <- extract_ea(document_paths)

# Make the output CSV file prefix based on the input CSV file name
file_prefix <- basename(identifiers_file)
file_prefix <- gsub(".csv","", file_prefix)

# Create the CSV file containing the entity-attribute metadata
write.csv(attributes, file = paste0(file_prefix, "_attributes.csv"), row.names = FALSE)
print( paste0( file_prefix, "_attributes.csv created"))
