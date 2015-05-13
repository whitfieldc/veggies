
get '/' do
  erb :index
end

# post '/tasks' do
#   @task = Task.new(title: params[:title], description: params[:description], stage: params[:section], project_id: 1)
#   if @task.save
#     p "great jaaab"
#   end
#   redirect '/'
# end

get '/tasks/new' do
  erb :"partials/_new_task", locals: { section: params[:section] }
end
######################################################################

post '/login' do
  @user = User.where(email: params[:email]).first
  login(@user, params[:password])
end

post '/logout' do
  logout
end




get '/projects' do
  ControllerHelper.all_projects
  # @projects = Project.where(owner_id: current_user)
end

post '/projects' do
#### create new project for user
  # @project = Project.new(title: params[:title], owner_id: current_user)
  proj_args = request.body.string
  if ControllerHelper.create_project(proj_args)
    status 202
  else
    status 400
  end
end

get 'projects/:id' do
#### present single project
# @project = Project.where(id: params[:id]).first
# p request.cookies
  ControllerHelper.single_project(params[:id])

end

post '/tasks' do
  task_args = request.body.string

  if ControllerHelper.create_task(task_args)
    status 202
  else
    status 400
  end
end



