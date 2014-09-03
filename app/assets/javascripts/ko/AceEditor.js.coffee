class KO.AceEditor
  buildEditor: ->
    @editor = ace.edit(@workspace())
    @editor.setTheme("ace/theme/#{@theme()}")
    @status_message("Loaded Theme '#{@theme()}'")
    @editor.getSession().setMode("ace/mode/#{@syntax()}")
    @editor.setShowInvisibles(no)
    @editor.getSession().setUseSoftTabs(yes)
    @editor.getSession().setTabSize(2)
    if @hidden_field
      @editor.getSession().on "change", ()=>
        @hidden_field().val @editor.getSession().getValue()

  backgroundSaveTheme: (theme_name)->
    $.ajax
      async: yes
      url: "/api/users/#{@_user_id()}"
      type: "PATCH"
      dataType: "json"
      data:
        theme: theme_name
      success: (response)=>
        @status_message(response.message)
        console.log(response.message)
      error: (xhr, status, err)=>
        json = xhr.responseJSON
        msg = "#{json.message} - #{json.errors}"
        @status_message(msg)

  constructor: (data)->
    @theme = ko.observable(data.theme ? "github")
    @syntax = ko.observable(data.syntax ? "json")
    @_user_id = ko.observable(data.user ? null)
    @status_message = ko.observable("")

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
      @backgroundSaveTheme(new_val)

