get '/' do
  erb :index
end

post '/tasks' do
  p params[:section]
  redirect '/'
end

get '/tasks/new' do
  erb :"partials/_new_task", locals: { section: params[:section] }
end