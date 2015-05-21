class Post < ActiveRecord::Base
  validates :title, :user, presence: true

  belongs_to :user, inverse_of: :posts
  has_many :postsubs, inverse_of: :post
  has_many :comments, inverse_of: :post

  has_many :subs, through: :postsubs

  def comments_by_parent_id
    all_comments = self.comments
    final = Hash.new {|h,k| h[k] = []}
    all_comments.each do |comment|
      final[comment.parent_id] << {id: comment.id,
                                   username: comment.user.username,
                                   parent_comment_id: comment.parent_id,
                                   content: comment.content,
                                   created_at: comment.created_at}
    end
    final
  end
end
