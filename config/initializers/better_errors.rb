if defined? BetterErrors
  # Private subnets defined by RFC1918 as stated in https://docs.docker.com/v1.5/articles/networking/
  BetterErrors::Middleware.allow_ip! '10.0.0.0/8'
  BetterErrors::Middleware.allow_ip! '172.16.0.0/12'
  BetterErrors::Middleware.allow_ip! '192.168.0.0/16'
end
