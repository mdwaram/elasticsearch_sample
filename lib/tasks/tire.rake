desc "Index Elastic Search"
namespace :tire do
  namespace :reindex do
    task all: :environment do
      aliases = Tire::Configuration.client.get(Tire::Configuration.url + '/_aliases').body
      indexes_names = MultiJson.load(aliases).keys

      indexes_names.each do |name|
        index = Tire::Index.new name
        index.delete
        index.import name.singularize.camelcase.constantize.all
        index.refresh
        puts "[INFO] #{name} re-indexed"
      end
    end
  end
end