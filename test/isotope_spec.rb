require 'rubygems'
require File.join(File.dirname(__FILE__), '../lib/isotope')

describe Isotope do
  before :all do
    @articles = dummy_articles
    @template_file = File.join(File.dirname(__FILE__), "article.ejs")
  end
  
  it "should output a js template" do
      s = Isotope.render_template(@template_file, :id => "hello")
      
      s.should_not be_nil
      
      # white spaces are not important to equalize
      s.strip.gsub(/\s/, "").should eql('
        <script type="text/x-isotope" id="hello"><div class="article">
        <h2><%=item.title%></h2>

        <div class="content">
        <%=item.content%>
        </div>

        <ul class="tags">
        	<%item.tags.forEach(function (tag) {%>
        	<li><%=tag.name%></li>
        	<%});%>
        </ul>
        </div></script>'.strip.gsub(/\s/, "")
      )
  end

  it "should render articles" do
    evaluated_content = Isotope.render_partial(@template_file, :locals => { :item => @articles[0] })
    
    expected_content = '
      <div class="article">
        <h2>Hello!</h2>
        <div class="content">
        World!
        </div>
        <ul class="tags">
          <li>tag 1</li>
          <li>tag 2</li>
          <li>tag 3</li>
          <li>tag 4</li>
        </ul>
      </div>
    '
    # white spaces are not important to equalize
    evaluated_content.gsub(/\s/, "").should eql(expected_content.gsub(/\s/, ""))
  end
  
  it "should render an array of articles" do
    evaluated_content = Isotope.render_partial(@template_file, :collection => @articles, :delimiter => "<hr/>")

    expected_content = '
      <div class="article">
        <h2>Hello!</h2>
        <div class="content">
        World!
        </div>
        <ul class="tags">
          <li>tag 1</li>
          <li>tag 2</li>
          <li>tag 3</li>
          <li>tag 4</li>
        </ul>
      </div>
      <hr/>
      <div class="article">
        <h2>Hello 2!</h2>
        <div class="content">
        World 2!
        </div>
        <ul class="tags">
          <li>tag 5</li>
          <li>tag 6</li>
          <li>tag 7</li>
          <li>tag 8</li>
        </ul>
      </div>
    '

    evaluated_content.gsub(/\s/, "").should eql(expected_content.gsub(/\s/, ""))
  end
end

def dummy_articles
  [
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
    }
  ]
end