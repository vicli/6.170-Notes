module NotesHelper

  def resource_name
    :note
  end
 
  def resource
    @resource ||= Note.new
  end

end
