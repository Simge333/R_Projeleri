library(usethis)
usethis::use_mit_license("Tesnim Strazimiri")
usethis::use_readme_md()
usethis::use_news_md()
usethis::use_testthat()
use_test("data-presence")
use_test("data-integrity")
use_description()
use_namespace(roxygen=TRUE)
file.create("R/data-presence.R")
file.create("R/data-integrity.R")





