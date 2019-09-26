---
layout: post
tags: [programming]
---

Recently I found myself wanting to access the resque-web ui on a live
application. I had considered just running resque-web as a separate process,
but after reading [this article](http://blog.kiskolabs.com/post/776939029/rails3-resque-devise)
I realised that I could mount resque directly in the router, awesome!

However, the application doesn't use devise for authentication, so I wanted an
easy way to restrict resque-web to admins.

Using rails 3 router's [advanced constraints](http://guides.rubyonrails.org/routing.html#advanced-constraints)
you can pass a `:constraints` options with an object that responds to
`matches?` and receives the current request as an argument.

Since the current user's id is stored in the session, we can simply
retrieve the user and check if they're an admin.

{% highlight ruby %}
class AdminRestriction
  def self.matches?(request)
    user_id = request.env['rack.session'][:user_id]
    user = User.find_by_id(user_id)
    return user && user.admin?
  end
end

MyApplication::Application.routes.draw do
  mount Resque::Server => '/resque', :constraints => AdminRestriction
  # Other application routes.
end
{% endhighlight %}

The `AdminRestriction` class performs the actual checks, in the router
it is simply passed as a constraint.

First we pull the `user_id` out of the session, then we attempt to get
the user from the database. Finally we check that we've found a user and
that they are an admin.

If the user tries to access `/resque` and they are not an admin, they
simply get a 404 error.

This technique can be used with any rack application, or indeed with any
regular route, just pass a `:constraints` option (see the
[match method docs](http://api.rubyonrails.org/classes/ActionDispatch/Routing/Mapper/Base.html#method-i-match)),
and the constraints that you apply can use any part of the request to decide if
it matches. You can restrict access by ip address, or do routing based
on the request's geolocation.

The possibilities are endless.
