before do
  content_type :json
end

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
  @user = User.new(
    email: params[:email],
    )
  @user.password = params[:password]
  if @user.save
    @user.to_json(methods: [:access_token]) ###### put this in session cookie??
  else
    status 400
    "Bad User Data"
  end
end

post '/users/login' do
  @user = User.where(email: params[:email]).first
  if @user && @user.password == params[:password]
    status 200
    @user.to_json(methods: [:access_token])
  else
    status 401
    {error: "Not Authorized"}.to_json
  end
end

post '/logout' do
  logout
end


get '/projects' do
  ensure_authorized!
  current_user.projects.to_json
end

post '/projects' do
  ensure_authorized!
  @project = Project.new(
      title: params[:title],
      owner_id: current_user.id
      )
  if @project.save
    status 202
    @project.to_json
  else
    status 400
    {error: "Bad Project Info"}.to_json
  end
end

#

get '/projects/:id' do
  ensure_authorized!
  if params[:id].length < 4
    current_project = Project.find(params[:id])
    if current_project.owner_id == current_user.id
      @task_set = Task.where(project_id: params[:id])
      status 200
      @task_set.to_json
    else
      content_type :json
      halt!(401, {error:'unauthorized'}.to_json)
    end
  end
end

post '/projects/:id/tasks' do
  ensure_authorized!
  @task = Task.new(
    title: params[:title],
    stage: params[:stage],
    description: params[:description],
    project_id: params[:id]
    )
  if @task.save
    status 200
    @task.to_json
  else
    status 400
    {error: "Bad Task Info"}.to_json
  end
end

patch '/tasks/:id' do
  ensure_authorized!
  @task = Task.where(id: params[:id]).first
  @task.stage = params[:stageName]
  # @task.description ||= params[:description]
  if @task.save
    status 200
  else
    status 400
    {error: "Couldn't Update Task"}.to_json
  end
end


# post '/tasks' do
#   task_args = request.body.string

#   if ControllerHelper.create_task(task_args)
#     status 202
#   else
#     status 400
#   end
# end



