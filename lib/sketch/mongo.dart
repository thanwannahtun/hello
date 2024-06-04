/*   5/28/24 MongoDB Day - (1)

- insertOne()

To insert a single document, use the insertOne() method.

This method inserts a single object into the database.

$ db.posts.insertOne({
  title: "Post Title 1",
  body: "Body of post.",
  category: "News",
  likes: 1,
  tags: ["news", "events"],
  date: Date()
})

//Note: If you try to insert documents into a collection that does not exist,
// MongoDB will create the collection automatically.
 
# insertMany()

To insert multiple documents at once, use the insertMany() method.

This method inserts an array of objects into the database.

$ db.posts.insertMany([  
  {
    title: "Post Title 2",
    body: "Body of post.",
    category: "Event",
    likes: 2,
    tags: ["news", "events"],
    date: Date()
  },
  {
    title: "Post Title 3",
    body: "Body of post.",
    category: "Technology",
    likes: 3,
    tags: ["news", "events"],
    date: Date()
  },
  {
    title: "Post Title 4",
    body: "Body of post.",
    category: "Event",
    likes: 4,
    tags: ["news", "events"],
    date: Date()
  }
])

----------------------------

-Find Data

There are 2 methods to find and select data from a MongoDB collection, find() and findOne().

find()
To select data from a collection in MongoDB, we can use the find() method.

This method accepts a query object. If left empty, all documents will be returned.

$ db.posts.find()

# findOne()

To select only one document, we can use the findOne() method.

This method accepts a query object. If left empty, it will return the first document it finds.

Note: This method only returns the first match it finds.

$ db.posts.findOne();


Querying Data
To query, or filter, data we can include a query in our find() or findOne() methods.

Example

$ db.posts.find( {category: "News"} )

This example will only display the title and date fields in the results.

$ db.posts.find({}, {title: 1, date: 1})

----------------------------

-Update Document

To update an existing document we can use the updateOne() or updateMany() methods.

The first parameter is a query object to define which document or documents should be updated.

The second parameter is an object defining the updated data.

# updateOne()

The updateOne() method will update the first document that is found matching the provided query.

Let's see what the "like" count for the post with the title of "Post Title 1":

Example

$ db.posts.find( { title: "Post Title 1" } ) 

Now let's update the "likes" on this post to 2. To do this, we need to use the $set operator.

Example

$ db.posts.updateOne( { title: "Post Title 1" }, { $set: { likes: 2 } } ) 

# updateMany()

The updateMany() method will update all documents that match the provided query.

Example
Update likes on all documents by 1. For this we will use the $inc (increment) operator:

$ db.posts.updateMany({}, { $inc: { likes: 1 } })

----------------------------

# deleteOne

-The deleteOne() method will delete the first document that matches the query provided.

db.posts.deleteOne({ title: "Post Title 5" })


# deleteMany

-The deleteMany() method will delete all documents that match the query provided.

$ db.posts.deleteMany({ category: "Technology" })

-------------------------------



*/