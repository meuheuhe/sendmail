require 'mailgun'
class HomeController < ApplicationController
  def index
  end
   
  
  def write
    @title = params[:title]
    @email = params[:email]
    @content = params[:content]
    mg_client = Mailgun::Client.new("key-ec7bc9759074d61f0c65a5b8de646224")

message_params =  {
                   from: "example@example.com",
                   to:  @email,
                   subject: @title,
                   text:  @content
                  }

result = mg_client.send_message('sandboxd6f09c26c5c0485aad1d6261a85c63db.mailgun.org', message_params).to_h!

message_id = result['id']
message = result['message']

new_post=Post.new
new_post.title = @title
new_post.content = @content

new_post.save
  redirect_to "/list"
  end
  def list
    @list1 = Post.all
  end

end
