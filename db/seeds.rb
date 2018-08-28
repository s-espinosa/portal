categories = ["Functionality", "Mechanics", "Design", "Testing", "Version Control", "Debugging"]

categories.each do |category|
  RubricCategory.create(title: category)
end

