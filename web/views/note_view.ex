defmodule NotesPhoenix.NoteView do
  use NotesPhoenix.Web, :view

  def render("javascript.html", _assigns) do
    """
    <script type='text/javascript'>
      var Note = require('web/static/js/note');
      var note = new Note();
    </script>
    """ |> safe
  end
end
