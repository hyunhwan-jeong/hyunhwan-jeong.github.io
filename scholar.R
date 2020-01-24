library(rcrossref)
library(tidyverse)
library(glue)

doi <- read_csv("doi.csv")

for(d in doi$doi) {
  cn_obj <- cr_cn(dois = d, "citeproc-json")
  
  title <- cn_obj$title
  journal <- cn_obj$`container-title`
  year <- cn_obj$cn_obj$`published-online`$`date-parts`[1]
  if(is.null(year)) year <- cn_obj$issued$`date-parts`[1]
  
  clean_author_list <- function(cn_obj) {
    author <- cn_obj$author %>% unite("name", c("given", "family"), sep = " ")
    author <- author$name
    mine <- author %in% c("Hyun-Hwan Jeong", "Hyun-hwan Jeong")
    author[mine] <- str_c("**", author[mine], "**")
    str_c(author, collapse = ", ")
  }
  
  author <- clean_author_list(cn_obj)
  
  cat("### {title}" %>% glue)
  cat('\n\n')
  cat('{journal}' %>% glue)
  cat('\n\n')
  cat('N/A') 
  cat('\n\n')
  cat('{year}' %>% glue) 
  cat('\n\n')
  cat('{author}' %>% glue) 
  cat('\n\n')
}
