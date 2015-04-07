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


  check_and_write <- function(path, lines){
    if(file.info(path)$size == 0 || use_the_force){
      loader <- file(path)
      writeLines(lines, con = loader)
    } else{
      warning(paste(path, "in target project was not empty, pinky tried to overwrite it but we stopped him"))
    }
  }

  check_and_write(paste0(path, "/includes/loader.R"),
                  c("## LOAD LIBRARIES", 'source("includes/libraries.R")', 
                    "## LOAD USER FUNCTIONS", 'source("includes/functions.R")', 
                    "## LOAD DATA", 'source("includes/data.R")')
                  )

  check_and_write(paste0(path, "/includes/libraries.R"),
                  c("library(pinky)")
                  )

  check_and_write(paste0(path, "/tools/generate_data_snapshot.R"),
                    c("## LOADER", 'DONT_USE_SNAPSHOT <- ', 'source("includes/loader.R")', 
                      "## SAVE DATA SNAPSHOT", 'save.image("snapshot.Rdata")')
                    )

  check_and_write(paste0(path, "/.gitignore"),
                    c("packrat/lib*/", "packrat/src/", "*.Rdata")
                    )

  packrat::init(project = path)
}
