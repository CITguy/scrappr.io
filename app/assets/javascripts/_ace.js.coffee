#= require ./ace/ace
#= require ./ace/theme-textmate
#= require ./ace/mode-json
#= require_self

ace_theme = "ace/theme/textmate"
ace_mode = "ace/mode/json"

$(".scrap-editor-container").each ->
  item_data = $(this).data()
  hidden_field = $(item_data.hidden)

  editor = ace.edit( $(this).attr("id") )
  editor.setTheme(ace_theme)

  session = editor.getSession()
  session.setMode(ace_mode)
  session.on "change", ->
    hidden_field.val(session.getValue())


$(".scrap-viewer-container").each ->
  console.log(".scrap-viewer-container found", $(this).attr('id'))
  @scrap_viewer = ace.edit( $(this).attr('id') )
  @scrap_viewer.setTheme(ace_theme)
  @scrap_viewer.getSession().setMode(ace_mode)
  @scrap_viewer.setReadOnly(true)
