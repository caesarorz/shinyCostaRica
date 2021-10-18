
path <- str_remove(getwd(), "/app")
#path
setwd(path)
#list.files(path)

runApp("app", display.mode = "showcase")
