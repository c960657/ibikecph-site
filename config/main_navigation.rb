# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
#  navigation.auto_highlight = true
  navigation.items do |primary|
    primary.item :home, 'Map', root_path
    primary.item :blog, 'Feedback', feedback_path
    primary.item :blog, 'Blog', blog_path
    primary.item :about, 'Account', account_path
  end

end