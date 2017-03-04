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


