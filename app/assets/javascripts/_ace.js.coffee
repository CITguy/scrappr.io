#= require ace/ace
#= require_self

## These are needed to get around the dumb that is asset pipeline
# https://github.com/ajaxorg/ace/issues/655
ace.config.set("basePath", "/ace")
ace.config.set("modePath", "/ace/modes")
ace.config.set("themePath", "/ace/themes")
ace.config.set("workerPath", "/ace/workers")
