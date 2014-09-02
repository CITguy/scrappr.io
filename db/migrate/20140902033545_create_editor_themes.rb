class CreateEditorThemes < ActiveRecord::Migration
  class EditorTheme < ActiveRecord::Base; end

  def change
    create_table :editor_themes do |t|
      t.string  :name,        null: false
      t.string  :ilk,         null: false, default: "light"
      t.boolean :is_enabled,  null: false, default: true
      t.string  :ace_id,      null: false

      t.timestamps
    end

    reversible do |dir|
      dir.down do
        # drop table does what we want
      end#down
      dir.up do
        EditorTheme.create([
          { ilk: "light", is_enabled: true, ace_id: "textmate", name: "TextMate"},
          { ilk: "light", is_enabled: true, ace_id: "chrome", name: "Chrome"},
          { ilk: "light", is_enabled: true, ace_id: "clouds", name: "Clouds"},
          { ilk: "light", is_enabled: true, ace_id: "crimson_editor", name: "Crimson Editor"},
          { ilk: "light", is_enabled: true, ace_id: "dawn", name: "Dawn"},
          { ilk: "light", is_enabled: true, ace_id: "dreamweaver", name: "Dreamweaver"},
          { ilk: "light", is_enabled: true, ace_id: "eclipse", name: "Eclipse"},
          { ilk: "light", is_enabled: true, ace_id: "github", name: "Github"},
          { ilk: "light", is_enabled: true, ace_id: "solarized_light", name: "Solarized Light"},
          { ilk: "light", is_enabled: true, ace_id: "xcode", name: "XCode"},
          { ilk: "light", is_enabled: true, ace_id: "kuroir", name: "Kuroir"},
          { ilk: "light", is_enabled: true, ace_id: "katzenmilch", name: "KatzenMilch"},
          { ilk: "dark",  is_enabled: true, ace_id: "ambiance", name: "Ambiance"},
          { ilk: "dark",  is_enabled: true, ace_id: "chaos", name: "Chaos"},
          { ilk: "dark",  is_enabled: true, ace_id: "clouds_midnight", name: "Clouds Midnight"},
          { ilk: "dark",  is_enabled: true, ace_id: "cobalt", name: "Cobalt"},
          { ilk: "dark",  is_enabled: true, ace_id: "idle_fingers", name: "idle Fingers"},
          { ilk: "dark",  is_enabled: true, ace_id: "kr_theme", name: "krTheme"},
          { ilk: "dark",  is_enabled: true, ace_id: "merbivore", name: "Merbivore"},
          { ilk: "dark",  is_enabled: true, ace_id: "merbivore_soft", name: "Merbivore Soft"},
          { ilk: "dark",  is_enabled: true, ace_id: "mono_industrial", name: "Mono Industrial"},
          { ilk: "dark",  is_enabled: true, ace_id: "pastel_on_dark", name: "Pastel on Dark"},
          { ilk: "dark",  is_enabled: true, ace_id: "terminal", name: "Terminal"},
          { ilk: "dark",  is_enabled: true, ace_id: "tomorrow_night", name: "Tomorrow Night"},
          { ilk: "dark",  is_enabled: true, ace_id: "tomorrow_night_blue", name: "Tomorrow Night Blue"},
          { ilk: "dark",  is_enabled: true, ace_id: "tomorrow_night_bright", name: "Tomorrow Night Bright"},
          { ilk: "dark",  is_enabled: true, ace_id: "tomorrow_night_eighties", name: "Tomorrow Night 80s"},
          { ilk: "dark",  is_enabled: true, ace_id: "twilight", name: "Twilight"},
          { ilk: "dark",  is_enabled: true, ace_id: "vibrant_ink", name: "Vibrant Ink"}
        ])
      end#up
    end
  end#change
end
