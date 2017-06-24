# Notes - RoR Testing Udemy

### Linux stuff

CLI create file and insert text.

`cat > <name of file.whatever extension>`

REF: https://www.howtogeek.com/199687/how-to-quickly-create-a-text-file-using-the-command-line-in-linux/

## Section 1 - Setup

### Create new app

Create an app without the default unit tests. This is because we want to use Rspec for unit testing.

`rails new blog_app - T`

## Git version control

Basic workflow of git and github.
- check status
- add the files and new changes to track
- commit the changes/discard the changes as well
- save yoour code to online repositories - Github.

Change user name and/or email:

`git config --global user.<name>/<email> "<username or email>"`

View what they are set up as:

`git config --list`

This is the output before creating a repo:

```
user.email=johncodeinaire@gmail.com
user.name=codeinaire
```

This is the output of the above after I created a git repo:

```
user.email=johncodeinaire@gmail.com
user.name=codeinaire
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
```

There was a bunch of stuff about an SSH key that I wasn't able to do because... I don't know why. This was in Section 1 - 7.

In Section 1 - 8 the wrong video showed up. Video 42 showed up instead of video 8.

## Section 2 - MVC

MVC structure

REF: 1

### Lecture 10

#### Testing

Testing is done to build robust code

- Unit Testing
  - models, views, routes, etc.
  - each individual component is tested one item at a time.
  - typically results in good coverage.

- Functional Tests
  - controllers.
  - testing multiple components and how they collaborate with each other.
  - multiple models in a process.

- Integration Tests
  - Integration test is when a business process is followed to completion to meet a business objective.
  - Typically involves emulating a user, for example logging in and clicking on a purchase button or links, etc.

### Lecture 11

Rspec and capybara
- Write out the scenario in a test file.
- First step: feature will fail.
- Second step: build feature unntil the test passes.

Install rspec:

- In gemfile:
 `gem 'respec', '<version number>'`

`$ rails generate rspec:install`

This generates a 'stub' for rspec. I don't know what a stub is, I'll find out later.

`bundle binstubs rspec-core`

### Lecture 13

Process for creating articles feature test and feature
- Create a branch to do the development work.
- Write a feature test.
- Build features to make test pass one by one.
- Once the feature test passes with no errors - merge branch with master branch.


#### 13.1 Workflow for creating new article

Create new article test:
- Visit root page.
- click on new article.
- fill in title.
- fill in body.
- create article.

What happens if new article created, or the 'expectations':
- Message article has been created.
- Redirect to articles path.

#### 13.2 How to run test

Run all tests in rspec:

`rspec`

run single tests:

`rspec spec/features/<name of file>.rb`

#### Text from the crash of atom

/usr/bin/atom: line 130:  5722 Segmentation fault      (core dumped) nohup "$ATOM_PATH" --executed-from="$(pwd)" --pid=$$ "$@" > "$ATOM_HOME/nohup.out" 2>&1
Failed to get crash dump id.
Report Id:

### Lecture 19

Not exactly sure what autoprefixer-rails is, but here's the github for it: https://github.com/ai/autoprefixer-rails

This is what it does:

`Autoprefixer is a tool to parse CSS and add vendor prefixes to CSS rules using values from the Can I Use. This gem provides Ruby and Ruby on Rails integration with this JavaScript tool.`

### Lecture 21 - Guard gem

We installed a bunch of different guard gems. This gem runs test automatically upon changing of any file in the program.

Starting guard:

`guard`

Will have guard running in the background monitoring any changes.

Why did he make changes to the guard file?
- Because we made custom tests and whenever anything is changed it'll check these custom files instead of the default tests or whatever the default is in the guard file.


### Lecture 25 - Data validations
