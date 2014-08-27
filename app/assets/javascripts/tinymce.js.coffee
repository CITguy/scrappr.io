# = require tinymce-jquery
# = require_self

tinyMCE.init
  selector: "textarea.tinymce_advanced"
  nonbreaking_force_tab: true
  convert_fonts_to_spans: true
  pagebreak_separator: "<!-- pagebreak -->"
  menubar: false
  height: 250
  resize: false
  toolbar1: "undo redo,|,formatselect,|,bold italic underline strikethrough,|,alignleft aligncenter alignright alignjustify,|,visualblocks preview code"
  toolbar2: "bullist numlist outdent indent,|,link unlink superscript subscript,|,table hr"
  plugins: "link,code,preview,anchor,visualblocks,nonbreaking,table"

tinyMCE.init
  selector: "textarea.tinymce"
  menubar: false
  height: 150
  resize: false
  toolbar1: "formatselect,|,bullist numlist outdent indent,|,bold italic underline,|,link unlink,|,visualblocks,preview"
  plugins: "link,preview,anchor,visualblocks,nonbreaking"
