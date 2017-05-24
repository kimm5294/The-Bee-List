Category.destroy_all
Goal.destroy_all
User.destroy_all
GoalsUser.destroy_all
Connection.destroy_all


Category.create(name:"Movies")
Category.create(name:"TV Shows")
Category.create(name:"Books")
Category.create(name:"Travel")
Category.create(name:"Restaurants")

User.create(first_name:"Matt", last_name:"Kim", username:"MKto", email:"matt@email.com", password:"password")
User.create(first_name:"Nanu", last_name:"Brar", username:"Meow", email:"nanu@email.com", password:"password")
User.create(first_name:"Kevin", last_name:"Brody", username:"Kdawgg", email:"kevin@email.com", password:"password")
User.create(first_name:"James", last_name:"Richards", username:"Jdawgg", email:"james@email.com", password:"password")
User.create(first_name:"Shane", last_name:"Murphy", username:"Shane", email:"shane@email.com", password:"password")
User.create(first_name:"Bryan", last_name:"Mateer", username:"Bryan", email:"bryan@email.com", password:"password")
User.create(first_name:"Adriel", last_name:"Sapporta", username:"Adriel", email:"adriel@email.com", password:"password")
User.create(first_name:"Carl", last_name:"Williams", username:"Carl", email:"carl@email.com", password:"password")
User.create(first_name:"Billy", last_name:"Billiamson", username:"Billy", email:"billy@email.com", password:"password")
User.create(first_name:"Cindy", last_name:"Liebenson", username:"Cindy", email:"cindy@email.com", password:"password")
User.create(first_name:"Meghan", last_name:"O'Callahan", username:"Meghan", email:"meghan@email.com", password:"password")

Connection.create(friender_id: 1, friendee_id: 2)
Connection.create(friender_id: 1, friendee_id: 3)
Connection.create(friender_id: 2, friendee_id: 3)
Connection.create(friender_id: 2, friendee_id: 4)
Connection.create(friender_id: 3, friendee_id: 4)
Connection.create(friender_id: 3, friendee_id: 5)
Connection.create(friender_id: 4, friendee_id: 5)
Connection.create(friender_id: 4, friendee_id: 6)
Connection.create(friender_id: 5, friendee_id: 6)
Connection.create(friender_id: 5, friendee_id: 7)
Connection.create(friender_id: 6, friendee_id: 7)
Connection.create(friender_id: 6, friendee_id: 8)
Connection.create(friender_id: 7, friendee_id: 8)
Connection.create(friender_id: 7, friendee_id: 9)
Connection.create(friender_id: 8, friendee_id: 9)
Connection.create(friender_id: 8, friendee_id: 10)
Connection.create(friender_id: 9, friendee_id: 10)
Connection.create(friender_id: 9, friendee_id: 1)
Connection.create(friender_id: 10, friendee_id: 1)
Connection.create(friender_id: 10, friendee_id: 2)
