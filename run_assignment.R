
path <- str_remove(getwd(), "/app")

setwd(path)

runApp("app", display.mode = "showcase")
