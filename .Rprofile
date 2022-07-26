#########################
# Insert an ascii octopus with fun coloring on startup.
# Taken from: 
# https://gist.github.com/jamesotto852/4ec1070f3256ae32c802f66466894d47 
#########################

# This function requires the following packages:

#   - crayon
#   - glue
#   - stringr

generate_octopus <- function() {
  
  # Initialize art, split by newlines ---------------------------------------
  octopus_ascii <- "                        ___\n                     .-'   `'.\n                    /         \\\n                    |         ;\n                    |         |           ___.--,\n           _.._     |0) ~ (0) |    _.---'`__.-( (_.\n    __.--'`_.. '.__.\\    '--. \\_.-' ,.--'`     `\"\"`\n   ( ,.--'`   ',__ /./;   ;, '.__.'`    __\n   _`) )  .---.__.' / |   |\\   \\__..--\"\"  \"\"\"--.,_\n  `---' .'.''-._.-'`_./  /\\ '.  \\ _.-~~~````~~~-._`-.__.'\n        | |  .' _.-' |  |  \\  \\  '.               `~---`\n         \\ \\/ .'     \\  \\   '. '-._)\n          \\/ /        \\  \\    `=.__`~-.\n          / /\\         `) )    / / `\"\".`\\\n    , _.-'.'\\ \\        / /    ( (     / /\n     `--~`   ) )    .-'.'      '.'.  | (\n            (/`    ( (`          ) )  '-;\n             `      '-;         (-'"
  octopus_ascii <- stringr::str_split(octopus_ascii, "\\n")[[1]]
  
  
  # Adjustments to ASCII art ------------------------------------------------
  
  # wink
  if (stats::runif(1) < 1/5) {
    octopus_ascii <-
      stringr::str_replace(octopus_ascii, "(?<=\\()0", "-") |>
      stringr::str_replace("~", " ")
    
    # blink
    if (stats::runif(1) < 1/3) {
      octopus_ascii <- stringr::str_replace(octopus_ascii, "0", "-")
      
      # sleep
      if (stats::runif(1) < 1/2) {
        octopus_ascii[2] <- stringr::str_replace(octopus_ascii[2], "^                  ", "{crayon::white('              Z  Z')}")
        octopus_ascii[3] <- stringr::str_replace(octopus_ascii[3], "^                  ", "{crayon::white('             Z   Z')}")
        octopus_ascii[4] <- stringr::str_replace(octopus_ascii[4], "^                  ", "{crayon::white('            Z Z   ')}")
        octopus_ascii[5] <- stringr::str_replace(octopus_ascii[5], "^                  ", "{crayon::white('             Z  Z ')}")
      }
    }
    
  } else {
    
    # angry
    if (stats::runif(1) < 1/5) {
      octopus_ascii <-
        stringr::str_replace_all(octopus_ascii, "0", '{crayon::bold(crayon::red("0"))}') |>
        stringr::str_replace("~", "v")
    }
    
  }
  
  # glue::glue() for various expressions
  octopus_ascii <- vapply(octopus_ascii, glue::glue, FUN.VALUE = character(1))
  
  
  # Assign colors -----------------------------------------------------------
  
  color_options <- c(
    "solid",
    "stripe",
    "rainbow"
  )
  
  color_funs <- list(
    crayon::cyan,
    crayon::blue,
    crayon::magenta,
    crayon::green
  )
  
  color_funs <-switch(
    sample(color_options, 1),
    "solid" = color_funs[[sample(1:length(color_funs), 1)]],
    "stripe" = color_funs[sample(1:length(color_funs), 2)],
    "rainbow" = color_funs
  )
  
  color_ascii <- function(string) {
    
    if (length(color_funs) == 1) {
      color_fun <- color_funs
    } else {
      color_fun <- color_funs[[sample(1:length(color_funs), 1)]]
    }
    
    color_fun(string)
  }
  
  # Collapse back to vector of length 1, w/ newlines
  octopus_ascii <- lapply(octopus_ascii, color_ascii) |>
    paste(collapse = "\n")
  
  
  
  # cat, returning string invisibly -----------------------------------------
  cat(octopus_ascii)
  invisible(octopus_ascii)
  
}

# Overwrite the behavior of q() to not save workspace by default.
q <- function (save="no", ...) {
  quit(save=save, ...)
}
## Create invisible environment to hold all your custom functions
.env <- new.env()

## Single character shortcuts for summary() and head().
.env$s <- base::summary
.env$h <- utils::head

#ht==headtail, i.e., show the first and last 10 items of an object.
.env$ht <- function(d) rbind(head(d,10),tail(d,10))

## Open Finder to the current directory. Mac Only!
.env$macopen <- function(...) if(Sys.info()[1]=="Darwin") system("open .")
.env$o       <- function(...) if(Sys.info()[1]=="Darwin") system("open .")


## Attach all the variables above
attach(.env)

## Finally, a function to print out all the functions you have defined in the .Rprofile.
print.functions <- function(){
    cat("s() - shortcut for summaryn",sep="")
    cat("h() - shortcut for headn",sep="")
    cat("macopen() - open finder to current working directoryn",sep="")
}

# Clear the default R license stuff
cat("\014")

generate_octopus()

