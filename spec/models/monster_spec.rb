require "rails_helper"

describe Monster do
  it "Work valid monster" do
    monster = Monster.new(name: "")
    monster.valid?
    expect(monster.errors[:name]).not_to be_empty
  end
end
describe Monster do
  it "Work valid monster 2" do
    monster = build(:monster)
    monster.valid?
    expect(monster.errors[:name]).to be_empty
  end
end
