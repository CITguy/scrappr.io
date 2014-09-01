class KO.AceEditor
  buildEditor: ->
    @editor = ace.edit(@workspace())
    @editor.setTheme("ace/theme/#{@theme()}")
    @editor.getSession().setMode("ace/mode/#{@syntax()}")
    @editor.setShowInvisibles(no)
    @editor.getSession().setUseSoftTabs(yes)
    @editor.setShowInvisibles(false)
    @editor.getSession().setTabSize(2)
    if @hidden_field
      @editor.getSession().on "change", ()=>
        @hidden_field().val @editor.getSession().getValue()

  constructor: (data)->
    @theme = ko.observable(data.theme ? "github")
    @syntax = ko.observable(data.syntax ? "json")

    @workspace = ko.observable($(data.workspace_id ? "")[0])
    if data.hidden_id
      @hidden_field = ko.observable($(data.hidden_id ? ""))

    @buildEditor()

    ########################################
    ## Subscriptions
    @syntax.subscribe (new_val)=>
      @editor.getSession().setMode("ace/mode/#{new_val}")

    # NOTE: May not work as expected
    @theme.subscribe (new_val)=>
      @editor.setTheme("ace/theme/#{new_val}")
