require 'rails_helper'
require 'capybara/rails'

feature 'Task lists' do

  scenario 'User can view and create task lists' do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    TaskList.create!(name: "Household Chores")

    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    expect(page).to have_content("Household Chores")

    click_on "+ Add Task List"
    fill_in "Name", with: "Some fancy task"
    click_on "Create Task list"
    expect(page).to have_content "Task List was created successfully!"
    expect(page).to have_content "Some fancy task"
  end

  scenario 'Task list must have a name when being created' do
    create_user email: "user@example.com"
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    click_on "+ Add Task List"
    click_on "Create Task list"
    expect(page).to have_content("Your task list could not be created")
  end

  scenario "User can change name of task list" do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    click_on "Edit"
    expect(page).to have_content("Edit a task list")
    fill_in "task_list[name]", with: "New task list"
    click_on "Update Task list"
    expect(page).to have_content "New task list"
    expect(page).to have_content "Task List was updated successfully!"
  end

  scenario "User can complete a task" do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    click_on "+ Add Task"
    fill_in "task[task]", with: "Clean"
    click_on 'Create Task'
    click_on 'Work List'
    expect(page).to have_content('Clean')
    click_on "Complete"
    expect(page).to have_no_content('Clean')
  end

  scenario "User can view completed tasks" do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    click_on "+ Add Task"
    fill_in "task[task]", with: "Clean"
    click_on 'Create Task'
    click_on 'Work List'
    expect(page).to have_content('Clean')
    click_on "Complete"
    expect(page).to have_no_content('Clean')
    click_on "Completed"
    expect(page).to have_content('Clean')
  end

  scenario "User can delete a task list" do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    click_on "Work List"
    click_on "Delete List"
    expect(page).to have_no_content "Work List"
  end

  scenario "If a task list has no tasks a message will be displayed" do
    create_user email: "user@example.com"
    TaskList.create!(name: "Work List")
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    expect(page).to have_content("Nothing here to see!")

    click_on "+ Add Task"
    fill_in "task[task]", with: "Clean"
    click_on 'Create Task'
    expect(page).to have_content("Work List")
    expect(page).to have_content("Clean")
    expect(page).to have_no_content("Nothing here to see!")
  end

  scenario "User can assign a task to another user when adding a new task" do
    create_user email: "user@example.com"
    User.create!(name: "Rob", email: "rob@example.com", password: "password")
    TaskList.create!(name: "Work List")
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    click_on "+ Add Task"
    fill_in "task[task]", with: "Clean"
    select 'Rob', from: 'Assigned to'
    click_on 'Create Task'
    expect(page).to have_content("Rob")
  end

  scenario "User can see a list of tasks assigned to them" do
    create_user email: "user@example.com"
    User.create!(name: "Rob", email: "rob@example.com", password: "password")
    TaskList.create!(name: "Work List")
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    click_on "+ Add Task"
    fill_in "task[task]", with: "Clean"
    select 'Rob', from: 'Assigned to'
    click_on 'Create Task'
    expect(page).to have_content("Rob")
    click_on "Logout"
    fill_in "Email", with: "rob@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    click_on "Assigned Tasks"
    expect(page).to have_content("Clean")
  end

  scenario "User can search for specific tasks" do
    create_user email: "user@example.com"
    User.create!(name: "Rob", email: "rob@example.com", password: "password")
    TaskList.create!(name: "Work List")
    visit signin_path
    click_on "Login"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "password"
    click_on "Login"
    expect(page).to have_content("Work List")
    click_on "+ Add Task"
    fill_in "task[task]", with: "Clean"
    select 'Rob', from: 'Assigned to'
    click_on 'Create Task'
    fill_in "search", with: "Clean"
    expect(page).to have_content("Clean")
  end

end