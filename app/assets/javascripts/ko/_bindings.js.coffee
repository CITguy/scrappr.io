jQuery ($)->
  $(document).ready ()->
    $(".ko-widget").each ()->
      data = $(this).data()

      viewmodel = switch data.ko_class
        when "ace_editor"
          new KO.AceEditor(data)

      if viewmodel
        ko.applyBindings(viewmodel, this)
