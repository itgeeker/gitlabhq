require 'spec_helper'

describe Gitlab::Conflict::FileCollection, lib: true do
  let(:merge_request) { create(:merge_request, source_branch: 'conflict-a', target_branch: 'conflict-b') }
  let(:file_collection) { Gitlab::Conflict::FileCollection.new(merge_request) }

  describe '#files' do
    it 'returns an array of Conflict::Files' do
      expect(file_collection.files).to all(be_an_instance_of(Gitlab::Conflict::File))
    end
  end

  describe '#default_commit_message' do
    it 'matches the format of the git CLI commit message' do
      expect(file_collection.default_commit_message).to eq(<<EOM.chomp)
Merge branch 'conflict-a' into 'conflict-b'

# Conflicts:
#   files/ruby/popen.rb
#   files/ruby/regex.rb
EOM
    end
  end
end
