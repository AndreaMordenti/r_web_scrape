setwd("~/Desktop/R")

library(RSelenium)

source('RSeleniumServer.R')


browser <- remoteDriver(port = 5557)

browser$open()
browser$navigate("https://www.facebook.com")

webElem <- browser$findElement(using = 'name', value = 'email')
webElem$highlightElement()
webElem$sendKeysToElement(list("pinkopallo87@gmail.com"))
webElem <- browser$findElement(using = 'name', value = 'pass')
webElem$sendKeysToElement(list("xxxx", "\uE007"))

#elem <- browser$findElement(using = 'css selector', 'body > object')
#for(c in 1:50){
#  elem$clickElement()
#  Sys.sleep(2)
#}

browser$close()

browser$closeServer()
