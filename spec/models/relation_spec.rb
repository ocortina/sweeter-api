require 'rails_helper'

RSpec.describe Relation, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  it { should belong_to(:follower) }
  it { should belong_to(:following) }
end
