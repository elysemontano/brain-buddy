user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@example.com").first_or_create(password: "password", password_confirmation: "password")

user1_topics = [
  {
    user_id: 1,
    name: "JavaScript Intro",
    description: "Begin your journey in JavaScript with data types, variables and built in methods"
  },
  {
    user_id: 1,
    name: "JavaScript Foundations",
    description: "Stretching your understanding of JavaScript with concepts like conditionals and arrays"
  },
]

user2_topics = [
  {
    user_id: 2,
    name: "Ruby Intro",
    description: "Begin your journey in Ruby with data types, variables and built in methods"
  },
  {
    user_id: 2,
    name: "Ruby Foundations",
    description: "Stretching your understanding of Ruby with concepts like conditionals and arrays"
  },
]

user1_topics.each do |topic|
  Topic.create(topic)
  p "created: #{topic}"
end

user2_topics.each do |topic|
  Topic.create(topic)
  p "created: #{topic}"
end

user1_cards = [
  {
    user_id: 1,
    topic_id: 1,
    question: "What are the six primitive data types?",
    answer: "Number, String, Boolean, Undefined, Null, and Symbol"
  },
  {
    user_id: 1,
    topic_id: 1,
    question: "What is a string?",
    answer: "A collection of characters wrapped with quotation marks"
  },
  {
    user_id: 1,
    topic_id: 2,
    question: "What is an array?",
    answer: "A collection of ordered data with each element representing a value and an index"
  },
  {
    user_id: 1,
    topic_id: 2,
    question: "What is zero indexing?",
    answer: "Index is a locater and in programming, the count of the locater begins at the number 0"
  },
]

user2_cards = [
  {
    user_id: 2,
    topic_id: 3,
    question: "What is OOP?",
    answer: "Object Oriented Programming is a programming paradigm that organizes data into a format that allows each instance to be an object"
  },
  {
    user_id: 2,
    topic_id: 3,
    question: "What is IRB",
    answer: "Interactive Ruby shell is a REPL environment where we can interact with Ruby code in the terminal"
  },
  {
    user_id: 2,
    topic_id: 4,
    question: "What is a Ruby block?",
    answer: "A Ruby block is an anonymous function that is passed to a method to determine an outcome"
  },
  {
    user_id: 2,
    topic_id: 4,
    question: "Every do has a(n)",
    answer: "END!"
  },
]

user1_cards.each do |card|
  Card.create(card)
  p "created: #{card}"
end

user2_cards.each do |card|
  Card.create(card)
  p "created: #{card}"
end