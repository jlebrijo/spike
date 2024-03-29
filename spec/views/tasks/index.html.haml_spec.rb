require 'rails_helper'

RSpec.describe "tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.create!(
        done: false,
        title: "Title"
      ),
      Task.create!(
        done: false,
        title: "Title"
      )
    ])
  end

  it "renders a list of tasks" do
    render
    assert_select ".row .bi-square", count: 2
    assert_select ".row", text: "Title".to_s, count: 2
  end
end
