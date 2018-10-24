categories = ["Functionality", "Mechanics", "Design", "Testing", "Version Control", "Debugging"]

categories.each do |category|
  RubricCategory.create(title: category)
end

project_categories = ["Project", "Independent Challenge", "Paired Challenge", "Independent Assessment", "Paired Assessment", "CFU", "Intermission Assignment", "PD Deliverable"]

project_categories.each do |project_category|
  ProjectCategory.create(title: project_category)
end
