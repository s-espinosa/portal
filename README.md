# Portal

This is a work in progress.

## Starting the Server

This application uses [Turing Census](https://github.com/turingschool-projects/omniauth-census) for authentication. Census requires ssl. A certificate has been created in the `.ssl` directory of this project to allow you to serve the project locally. In order to use this certificate run the following command:

```
rails s -b 'ssl://localhost:3000?key=.ssl/localhost.key&cert=.ssl/localhost.crt'
```

You will likely get a notification saying that your connection is not private. If you are using Chrome it might look something like this:

![Not Private](./images/not_private.png)

Click on `Advanced` and then on the link that says `Proceed to localhost (unsafe)`.

## Roadmap

* Create projects (complete - though user will likely need to be torn out and reworked)
* Allow users to log in using Census
* Rework projects
    * How are users stored? What all is stored about them? What do we look up on Census?
    * Do we have a users table? Then do we have a Census User that is initialized based on some combination of what's in our users table and information from Census?
* Create rubric categories
    * Believe instructors should have ability to create a new rubric category.
* Create rubrics
    * Join between projects and rubric categories.
    * Also have a field for description on this table.
    * While many projects might share a rubric category, the particular description for that category may change from project to project.
    * For example, both Black Thursday and Rails Engine might have a "Mechanics" section, but what is expected from students in each project might be very different. A student wouldn't be expected to use AR in Black Thursday, but they would in Rails Engine. We can designate these specific expectations in the description field on the rubrics table.
* Create assignments table
    * join between users and projects
* Create a scores table
    * join between users and rubrics.
    * Each project should have multiple entries.
    * Maybe these get created when an assignment gets created.
    * Find all of the rubric entries related to a particular project and create a row on scores with that `rubric_id` and the `user_id` of the student being assigned the project.
    * Also has a numeric score (1, 2, 3, 4)
    * Also has notes.
