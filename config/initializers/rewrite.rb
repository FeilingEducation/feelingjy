# Redirect all http traffic to https
r301 %r{.*}, 'https://www.feelingyt.com$&', :scheme => 'http'
