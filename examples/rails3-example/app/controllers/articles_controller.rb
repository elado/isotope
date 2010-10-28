require 'isotope'

class ArticlesController < ApplicationController
  before_filter :find_article

  def show_server_template_in_controller
		render :text => Isotope.render_partial(Rails.root.join('app/views/articles/article.html.ejs'), :locals => { :item => @articles[0] })
  end

  def show_server_template_in_view
    
  end

  def show_client
    
  end
  
  def article_object
    render :json => @articles[rand(@articles.length)]
  end
  
  def article_object_list
    render :json => @articles
  end
  
private

  def find_article
		@articles = [
		  {
        :title => "Hello!",
        :content => "World!",
        :tags => [
          {:name => "tag 1"},
          {:name => "tag 2"},
          {:name => "tag 3"},
          {:name => "tag 4"}
        ]
      },
      {
        :title => "Hello 2!",
        :content => "World 2!",
        :tags => [
          {:name => "tag 5"},
          {:name => "tag 6"},
          {:name => "tag 7"},
          {:name => "tag 8"}
        ]
      },
      {
        :title => "Hello 3!",
        :content => "World 3!",
        :tags => [
          {:name => "tag 9"},
          {:name => "tag 10"},
          {:name => "tag 11"},
          {:name => "tag 12"}
        ]
      }
    ]
  end
end

