User.create(email: "chuck@shitfield.com")

user = User.first

proj = Project.create(title: "P10 Project", owner_id: user.id)

tasks = [
schema = { title: "schema", description: "create schema", stage: "Testing", project_id: 1 },
migrations = { title: "migrations", description: "create migrations", stage: "Testing", project_id: 1 },
sms_api = { title: "sms_api", description: "create sms api", stage: "Icebox", project_id: 1 },
prioritization = { title: "prioritization", description: "create prioritization visualization", stage: "Icebox", project_id: 1 },
ui = { title: "ui", description: "create ui", stage: "Development", project_id: 1 },
ux = { title: "ux", description: "create ux", stage: "Development", project_id: 1 },
name = { title: "name", description: "create name", stage: "Testing", project_id: 1 },
self_doubt = { title: "self doubt", description: "create self doubt", stage: "Deployed", project_id: 1 },
chocolate = { title: "chocolate", description: "create chocolate", stage: "Deployed", project_id: 1 }
]

tasks.each do |task|
  Task.create(task)
end




