# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.feelingyt.com"

SitemapGenerator::Sitemap.create do
  add root_path, :changefreq => 'daily', :priority => 1
  InstructorInfo.find_each do |obj|
    user = obj.user_info.user
    add profile_path(user), :changefreq => 'weekly', :lastmod => user.updated_at
  end
end
