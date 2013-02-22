class Article < ActiveRecord::Base
  belongs_to :author
  has_many :comments

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id, type: 'integer'
    indexes :name
    indexes :author_name
    indexes :content
    indexes :published_at, type: 'date'
    indexes :comments_count, type: 'integer'
  end

  def author_name
    author.name
  end

  def comments_count
    comments.size
  end

  def self.search(params)
    tire.search(load: true) do
      query { string params[:query] } if params[:query].present?
      filter :range, published_at: {lte: Time.zone.now}
    end
  end
end
