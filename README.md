# pinky
You're the Brain of the operation. You know what's going on and you know what to do. You want to do it quick. Ever needed to put your application on a bigger machine that has none of your dependencies? It's a pain in the ass if you didn't think about it before writing that huge pile of convoluted functions that definitely couldn't exist in any other way.

Well, `pinky` is here to help. It aims to introduce conventions and helper scaffolding functions to make your R applications more scalable, self-contained and ready for the reproducible data science (r)evolution we've been dreaming about since we were kids. 

**Pre-requisities**: you should have R installed and running(duh), packrat and devtools installed into global or user library.

**Installation**: `devtools::install_github('keynmol/pinky')`

# Getting started

TL;DR:

 1. Create project: `pinky::scaffold("/path/to/project/")`
 3. Put your dirty data in `/path/to/project/data/`
 4. Put your dependencies in `includes/libraries.R`
 5. Put your helper functions in `/path/to/project/includes/functions.R`
 6. Put your data cleanup procedures in `/path/to/project/includes/data.R`
 7. Generate binary clean data snapshot with `tools/generate_data_snapshot.R`
 8. Put your experiments in root folder with `source("includes/loader.R`)` at the top.
 9. Put your RMarkdown reports in `/path/to/project/includes/reports` and use `source("includes/loader.R")` there.
 9. Run `packrat::snapshot()` each time you add a new dependency
 10. Bundle application with `packrat::bundle()`
 11. (optional) run experiments files using `littler`: `r -L packrat experiment1.R`
 12. (optional) use `inject` and `funfact` to keep your data and functions immutable.
 13. Be happy.


Starting a new project? Just run 

```{r}
pinky::scaffold("/path/to/project/")
```

And it will create a following folder structure:

```
/path/to/project
    ├── data
    ├── includes
    │   ├── data.R
    │   ├── functions.R
    │   ├── libraries.R
    │   └── loader.R
    ├── packrat
    └── tools
        └── generate_data_snapshot.R
```

It will also try and run `packrat::init()` for your new project folder, which will create the folder structure and files packrat loves so much.

### includes/loader.R
An entry point and the holy grail of your self-contained reproducible environment. This is what it looks like:

```{r}
## LOAD LIBRARIES
source("include/libraries.R")
## LOAD USER FUNCTIONS
source("include/functions.R")
## LOAD DATA
source("include/data.R")
```

Include this file at the top of your file with experiments and forget about missing dependencies, functions or data variables.

### includes/libraries.R
This is where packages imports go. After scaffolding it only contains `pinky` itself:

```{r}
library(pinky)
```

Put all your library imports here you won't miss a library ever again.

### includes/data.R
This is where data gets loaded, cleaned and pre-processed. It's a long process, we know, that's why you should use optional loading([MORE ON THAT LATER WHEN I ACTUALLY IMPLEMENT IT]:

```{r}
lol(didnt(implement))
```

Have all your data living in this file and your life will be slightly betterer.

### includes/functions.R
This is the entry point to the modular structure of your application - use it to link to other files that contain functions and classes you wrote for your project.

### tools/generate_data_snapshot.R
Data loading can be quite long for big datasets, so a very simple script is provided:

```{r}
## LOADER
source("includes/loader.R")
## LOAD USER FUNCTIONS
save.image("snapshot.Rdata")
```

The idea being that data and dependencies change quite infrequently, so it's a lot easier to keep raw data untouched and dirty and all the transformations it has to undergo in the `data.R`. To avoid running those transformations everytime(they can be quite costly), `loader.R` will try to avoid running `data.R` if there's a `snapshot.Rdata` present in the root folder. Neat.

It's a good idea to store data the way it came from the source(or as close to it as possible) and keep track of all the applied transformations. Using binary snapshots helps save time on running those tranformations every single time.

# TODO
 * Actually learn about R environments and remove the "shout yourself in the balls" side effect of `inject`
 * Examples, vignettes, proper docs..
 * Better code organisation
 * Just be a better person in general.
