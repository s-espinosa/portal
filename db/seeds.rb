categories = ["Functionality", "Mechanics", "Design", "Testing", "Version Control"]

categories.each do |category|
  RubricCategory.create(title: category)
end

