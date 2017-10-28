// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

// Default script for setting up cable (Channel) connection with Rails backend.
(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();
  console.log('=============')
  console.log({App.cable})

}).call(this);
