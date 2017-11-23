require "dry/validation"
require "types"

module Blog
  module Admin
    module Articles
      FormSchema = Dry::Validation.Form do
        required(:title).filled(:str?)
        required(:status).filled(Types::ArticleStatus)
        optional(:published_at).maybe(:time?)

        rule(published_at_then_published: [:published_at, :status]) do |published_at, status|
          published_at.filled? > status.eql?('published')
        end
      end
    end
  end
end
