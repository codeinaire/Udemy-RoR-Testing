# Notes - RoR Testing Udemy

### Linux stuff

CLI create file and insert text.

`cat > <name of file.whatever extension>`

REF: https://www.howtogeek.com/199687/how-to-quickly-create-a-text-file-using-the-command-line-in-linux/

## Create new app

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
