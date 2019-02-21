library(scholar)
library(tidyverse)
library(glue)
myid <- "v1PxeYYAAAAJ"
pubs <- get_publications(myid, flush = T) %>% arrange(-year)
save(pubs, file = "publications.rData")

