# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

scaffold <- function(path, use_the_force = F) {
  dir.create(paste0(path,"/data"))
  dir.create(paste0(path,"/includes"))
  dir.create(paste0(path,"/packrat"))
  dir.create(paste0(path,"/tools"))
  dir.create(paste0(path,"/reports"))
  dir.create(paste0(path,"/results"))

  file.create(paste0(path, "/tools/generate_data_snapshot.R"))
  file.create(paste0(path, "/includes/loader.R"))
  file.create(paste0(path, "/includes/functions.R"))
  file.create(paste0(path, "/includes/libraries.R"))
  file.create(paste0(path, "/includes/data.R"))


  loader_file <- file.info(paste0(path, "/includes/loader.R"))

  if(loader_file$size == 0 || use_the_force){
    loader <- file(paste0(path, "/includes/loader.R"))
    writeLines(c("## LOAD LIBRARIES", 'source("includes/libraries.R")', "## LOAD USER FUNCTIONS", 'source("includes/functions.R")', "## LOAD DATA", 'source("includes/data.R")'), con = loader)
  } else{
    warning("includes/loader.R in target project was not empty, pinky tried to overwrite it but we stopped him")
  }


  libraries_file <- file.info(paste0(path, "/includes/libraries.R"))

  if(libraries_file$size == 0 || use_the_force){
    libraries <- file(paste0(path, "/includes/libraries.R"))
    writeLines(c("library(pinky)"), con = libraries)
  } else{
    warning("includes/libraries.R in target project was not empty, pinky tried to overwrite it but we stopped him")
  }

  snapshot_generator_file <- file.info(paste0(path, "/tools/generate_data_snapshot.R"))
  if(snapshot_generator_file$size == 0 || use_the_force){
    generator <- file(paste0(path, "/tools/generate_data_snapshot.R"))
    writeLines(c("## LOADER", 'DONT_USE_SNAPSHOT <- ', 'source("includes/loader.R")', "## LOAD USER FUNCTIONS", 'save.image("snapshot.Rdata")'), con = generator)
  } else{
    warning("includes/generate_data_snapshot.R in target project was not empty, pinky tried to overwrite it but we stopped him")
  }

  old_folder <- getwd()
  packrat::init(project = path)
}
