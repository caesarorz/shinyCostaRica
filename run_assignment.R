
path <- str_remove(getwd(), "/app")
path
setwd(path)

runApp("app", display.mode = "showcase")
