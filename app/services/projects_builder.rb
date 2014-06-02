class ProjectsBuilder
  extend TimeHelper

  # FIXME: Why can't I invoke cdq.save directly from this class?
  # (without passing it in as an attribute)
  def self.build!(response, cdq)
    Project.destroy_all

    response.each do |raw_project|
      project = Project.create(
        name:         raw_project["name"],
        hash_id:      raw_project["hash_id"],
        semaphore_id: raw_project["id"].to_s
      )

      raw_branches = Array.new
      raw_project["branches"].each do |branch|
        raw_branches << Branch.create(
          name:          branch["branch_name"],
          result:        branch["result"],
          started_at:    time_from_string(branch["started_at"]),
          finished_at:   time_from_string(branch["finished_at"]),
          building_date: time_from_string(branch["finished_at"])
        )
      end

      project.branches = NSSet.setWithArray raw_branches

      # Get this from the master branch
      project.last_build_cache = project.last_build
    end

    cdq.save
  end
end
