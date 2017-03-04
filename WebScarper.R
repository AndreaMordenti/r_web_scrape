setwd("~/Desktop/R/r_web_scrape")
library(RSelenium)

source('RSeleniumServer.R')


browser <- remoteDriver(port = 5557)

browser$open()

browser$navigate("https://it.linkedin.com/")
webElem <- browser$findElement(using = 'id', value = 'login-email')
webElem$highlightElement()








