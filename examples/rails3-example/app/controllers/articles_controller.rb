class ArticlesController < ApplicationController
  before_filter :find_article

  def render_server_template_in_controller
		render :text => isotope_render_partial('articles/article', :locals => { :item => @articles[0] })
  end

  def render_server_template_in_view
    
  end

  def render_client
    
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
        :title => "Article #1",
        :date => Time.utc(2011, 4, 12),
        :content => "Article content #1",
        :tags => [
          { :name => "tag 1" },
          { :name => "tag 2" },
          { :name => "tag 3" },
          { :name => "tag 4" }
        ]
      },
      {
        :title => "Article #2",
        :date => Time.utc(2011, 4, 10),
        :content => "Article content #2",
        :tags => [
          { :name => "tag 5" },
          { :name => "tag 6" },
          { :name => "tag 7" },
          { :name => "tag 8" }
        ]
      },
      {
        :title => "Article #3",
        :date => Time.utc(2011, 3, 31),
        :content => "Article content #3",
        :tags => [
          { :name => "tag 9" },
          { :name => "tag 10" },
          { :name => "tag 11" },
          { :name => "tag 12" }
        ]
      }
    ]
  end
end

