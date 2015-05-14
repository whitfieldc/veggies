get '/key' do

  key = SecureRandom.hex(10).to_s
  user = User.first
  user.session_key = key
  user.save
  "Here's your key: \n#{key}"

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

post '/users' do
##### IF KEY MATCH
  new_user_data = JSON.parse(request.body.read)
  @user = User.new(new_user_data)
  if @user.save
    @user.get_key ###### put this in session cookie??
  else
    status 400
    "Bad User Data"
  end
end

post '/users/login' do
  @user = User.where(email: params[:email]).first
  @key = login(@user, params[:password])
  if @key
    status 200
    key.to_json
  else
    status 400
  end
end

post '/logout' do
  logout
end


get '/projects' do

  ControllerHelper.all_projects(user)
  # @projects = Project.where(owner_id: current_user)
end

post '/projects' do
#### create new project for user
  # @project = Project.new(title: params[:title], owner_id: current_user)
  proj_args = request.body.string
  @project = ControllerHelper.create_project(proj_args)
  if @project
    status 202
    @project
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



