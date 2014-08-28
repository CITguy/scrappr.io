#= require highlightjs/highlight.pack
#= require_self

# Config, etc.
console.log("Languages:", hljs.listLanguages())
hljs.configure
  tabReplace: "  "  #2 spaces
  languages: [
    "javascript"
    "xml"
    "http"
    "css"
    "json"
    "scss"
  ]
hljs.initHighlightingOnLoad()
