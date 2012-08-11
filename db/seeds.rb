Page::SECTIONS.each do |section|
  Page.create! :name => "main", :section => section, :title => "#{ section } page title", :content => "This is a #{ section } page."
end

Page.home.first.update_attribute :main_page, true
