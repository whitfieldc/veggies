class ControllerHelper
  class << self








    def all_projects
      @all_projects = Project.where(owner_id: current_user)
      output = @all_projects.each.map do |project|
        {
          "title" => project.title,
          "owner_id" => project.owner_id,
          "owner" => project.owner.email
        }
      end
      output.to_json
    end

    def single_project(target_id)
      @single_project = Project.where(id: target_id).first
      if @single_project
        output =
          {
            "title" => @single_project.title,
            "owner_id" => @single_project.owner_id,
            "owner" => @single_project.owner.email
          }
        output.to_json
      else
        status 404
      end
    end



  end
end
