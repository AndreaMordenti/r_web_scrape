## Set RSelenium server up
system("cd /Users/andreamordenti/Desktop/R && nohup
       java -Dwebdriver.gecko.driver=geckodriver -jar selenium-server-standalone-3.0.1.jar -port 5557 > rselenium.log &")
