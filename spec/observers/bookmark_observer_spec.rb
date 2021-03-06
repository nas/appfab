require 'spec_helper'

describe BookmarkObserver do
  let(:user) { User.make! }

  context 'when a user submits an idea' do
    it 'bookmarks it' do
      lambda {
        Idea.make! author:user
      }.should change { user.bookmarks.count }.by(1)
    end
  end

  context 'when a user comments on an idea' do
    it 'bookmarks it' do
      idea = Idea.make!
      lambda {
        user.comments.make!(idea:idea)
      }.should change { user.bookmarks.count }.by(1)
    end
  end

  context 'when and idea changes' do
    it 'does not bookmark it for the author' do
      idea = Idea.make!
      idea.author.bookmarks.destroy_all

      lambda {
        idea.save!
      }.should_not change { idea.author.bookmarks.count }
    end
  end
end
