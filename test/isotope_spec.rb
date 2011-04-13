require 'rubygems'
require 'time'
require File.join(File.dirname(__FILE__), '../lib/isotope')

puts "rewriting path constants for test..."
module Isotope
  APP_ROOT = File.expand_path("test")
  DEFAULT_CONFIG_PATH = File.join(APP_ROOT, 'config', 'isotope.yml')
end

describe Isotope do
  before :all do
    @articles = dummy_articles
    @template_file = File.join(File.dirname(__FILE__), "article.html.ejs")
  end
  
  WHITESPACE_RX = /\s/
  
  it "should output a js template" do
    s = Isotope.render_template(@template_file, :id => "hello")

    s.should_not be_nil

    # white spaces are not important to equalize
    s.strip.gsub(WHITESPACE_RX, "").should eql('
      <script type="text/x-isotope" id="hello"><div class="article">
        <h3><%=item.title%></h3>

        <div class="date"><%= formatDate(item.date) %></div>

        <div class="content">
        <%=item.content%>
        </div>

        <ul class="tags">
        	<%item.tags.forEach(function (tag) {%>
          <li><a href="/tag/<%=encodeURIComponent(tag.name)%>"><%=tag.name.parenthesize()%></a></li>
        	<%});%>
        </ul>
      </div></script>'.strip.gsub(WHITESPACE_RX, "")
    )
  end

  it "should render articles" do
    evaluated_content = Isotope.render_partial(@template_file, :locals => { :item => @articles[0] })
    
    expected_content = '
      <div class="article">
        <h3>Article #1</h3>
        <div class="date">Apr 12th, 2011</div>
        <div class="content">Article content #1</div>
        <ul class="tags">
          <li><a href="/tag/tag%201">(tag 1)</a></li>
          <li><a href="/tag/tag%202">(tag 2)</a></li>
          <li><a href="/tag/tag%203">(tag 3)</a></li>
          <li><a href="/tag/tag%204">(tag 4)</a></li>
        </ul>
      </div>
    '
    # white spaces are not important to equalize
    evaluated_content.gsub(WHITESPACE_RX, "").should eql(expected_content.gsub(WHITESPACE_RX, ""))
  end
  
  it "should render an array of articles" do
    evaluated_content = Isotope.render_partial(@template_file, :collection => @articles, :delimiter => "<hr/>")

    expected_content = '
      <div class="article">
        <h3>Article #1</h3>
        <div class="date">Apr 12th, 2011</div>
        <div class="content">Article content #1</div>
        <ul class="tags">
          <li><a href="/tag/tag%201">(tag 1)</a></li>
          <li><a href="/tag/tag%202">(tag 2)</a></li>
          <li><a href="/tag/tag%203">(tag 3)</a></li>
          <li><a href="/tag/tag%204">(tag 4)</a></li>
        </ul>
      </div>
      <hr/>
      <div class="article">
        <h3>Article #2</h3>
        <div class="date">Apr 10th, 2011</div>
        <div class="content">Article content #2</div>
        <ul class="tags">
          <li><a href="/tag/tag%205">(tag 5)</a></li>
          <li><a href="/tag/tag%206">(tag 6)</a></li>
          <li><a href="/tag/tag%207">(tag 7)</a></li>
          <li><a href="/tag/tag%208">(tag 8)</a></li>
        </ul>
      </div>
    '

    evaluated_content.gsub(WHITESPACE_RX, "").should eql(expected_content.gsub(WHITESPACE_RX, ""))
  end
end

def dummy_articles
  [
	  {
      :title => "Article #1",
      :date => Time.utc(2011, 4, 12).iso8601,
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
      :date => Time.utc(2011, 4, 10).iso8601,
      :content => "Article content #2",
      :tags => [
        { :name => "tag 5" },
        { :name => "tag 6" },
        { :name => "tag 7" },
        { :name => "tag 8" }
      ]
    }
  ]
end