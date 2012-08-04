%w/home about contact meetings/.each do |section|
  Page.create! :name => "main", :section => section, :title => "#{ section } page title", :content => "This is a #{ section } page."
end
