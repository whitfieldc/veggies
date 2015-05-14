class ControllerHelper
  class << self

    def all_projects(user)
      @all_projects = Project.where(owner_id: user.id)
      output = @all_projects.each.map do |project|
        {
          "title" => project.title,
          "owner_id" => project.owner_id,
          "owner" => project.owner.email
        }
      end
      output.to_json
    end

    def tasks_by_project(project_id)
      @task_set = Task.where(project_id: project_id)
      if @task_set
        output = @task_set.each.map do |task|
          {
            "title" => @task.title,
            "description" => @task.description,
            "stage" => @task.stage
          }
        end
        output.to_json
      else
        status 404
      end
    end

    def create_project(args)
      project_info = JSON.parse(args)
      @project = Project.new(
        title: project_info["title"],
        owner_id: current_user
        )
      if @project.save
        @project.to_json
      else
        false
      end
    end

    def create_task(args)
      task_info = JSON.parse(args)
      @task = Task.new(
      title: task_info["title"],
      description: task_info["description"],
      stage: task_info["stage"],
      project_id: task_info["project_id"]
        )
      if @task.save
        @task
        status 200
      else
        status 400
      end
    end




  end
end
