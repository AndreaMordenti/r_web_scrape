setwd("~/Desktop/R/r_web_scrape")
library(RSelenium)

library(XML)

source('functions.R')

## Set RSelenium server up
os <- Sys.info()['sysname']

cmd_string <-""

if(os == "Windows") {
  cmd_string <- "java -Dwebdriver.gecko.driver=geckodriver -jar selenium-server-standalone-3.0.1.jar -port 5558"
  shell(cmd=cmd_string,wait=FALSE)
} 

if(os == "Darwin")  {
  cmd_string <- "cd /Users/andreamordenti/Desktop/R && nohup
  java -Dwebdriver.gecko.driver=geckodriver -jar selenium-server-standalone-3.0.1.jar -port 5557 > rselenium.log &"
  ## launch the server
  system(cmd_string)
}

rsDriver(port = 4568L, browser = c("chrome"), version = "latest", chromever = "latest",
         geckover = "latest", iedrver = NULL, phantomver = "2.1.1",
         verbose = TRUE, check = TRUE)
remDr <- rsDriver(browser = "chrome")
browser <- remDr[["client"]]

browser$navigate("https://it.linkedin.com/")

webElem <- browser$findElement(using = 'id', value = 'login-email')
webElem$sendKeysToElement(list("xxx"))
webElem <- browser$findElement(using = 'id', value = 'login-password')
webElem$sendKeysToElement(list("yyy", "\uE007"))
webElem <- browser$findElement(using = 'id', value = 'login-submit')
webElem$highlightElement()
webElem$clickElement()

network_links <- browser$findElements(using = 'xpath', value = "//a[@class='nav-item__link']")

linkHref <- sapply(network_links,
                   function(x) {
                     return_vect <- vector("list")
                     if(x$getElementAttribute('data-alias') == 'relationships')
                       return_vect <- x$getElementAttribute('href')
                     })

network <- ""
for(i in 1:length(linkHref)){
  if(!is.null(linkHref[[i]])) network <- linkHref[[i]]
}

browser$navigate(network[[1]])


browser$navigate('https://www.linkedin.com/mynetwork/invite-connect/connections/')


connectionList <- browser$findElements(using = 'xpath', value = "//div[@class='mn-person-info__details']/a")

connection_links <- sapply(connectionList,
                   function(x) {
                     return_vect <- vector("list")
                       return_vect <- x$getElementAttribute('href')
                   })
connectionNames <- browser$findElements(using = 'xpath', value = "//div[@class='mn-person-info__details']/a/span")


connection_names <- sapply(connectionNames,
                          function(x) {
                            return_vect <- vector("list")
                            return_vect <- x$getElementText()
                          })
people_df <- data.frame(col1 = 'Name',col2 = 'Job Title',col3='href',stringsAsFactors = FALSE)
conn_idx <- 2
for(i in 1:length(connection_links)){
    people_df[i,1] <- connection_names[conn_idx] #name
    people_df[i,2] <- connection_names[conn_idx+2] #title
    people_df[i,3] <- connection_links[[i]] #ref
    conn_idx <- i*3
}

#first level completed

##start the exploration
for(i in 1:2){
  browser$navigate(people_df[i,3])
}
