class Projects
  include ActiveModel::Model

  def get(headers)
    response = HTTParty.get("https://api.harvestapp.com/v2/users/me/project_assignments", headers: headers)
    {
      projects: response["project_assignments"].map {|proj|
                  [
                    proj["project"]["name"], proj["project"]["id"].to_s
                  ]
                }.sort_by {|proj| proj[0] },
      tasks:    response["project_assignments"][0]["task_assignments"].map {|ta|
                  [
                    ta["task"]["name"], ta["task"]["id"].to_s
                  ]
                }.sort_by {|proj| proj[0] }
    }
  end
end
