# README

## Ruby version
v2.4.0

## System dependencies
No

## Configuration
no configuration

## Database creation
Create feelingjy_development, feelingjy_test and feelingjy_production in MySQL.

## Database initialization
`rails db:schema:load`

## Model design
### `users`
- Stores security information of each user. Comes from the devise user model.
All other user information is stored on other tables with the same id for the same
underlying user. Field change should require password or email verification.
- `has_one user_info`

### `user_infos`
- Basic information about a user. Information stored could be changed as long as
the user is logged-in. Shares same ID as its corresponding `user`.
- `belongs_to user`
- `has_one instructor_info`
- `has_many consult_transactions as student`
- `has_many attachments as attachable`

### `instructor_infos`
- Information only for instructors. Any user that has no transaction can register
as an instructor. `instructor_info` shares many views with `user_info`. shares
same ID as its corresponding `user`.
- `belongs_to user`
- `has_many consult_transactions as instructor`
- `has_one private_policy as instructor`

### `consult_transactions`
- Consult transactions links students (general `user_info`) with instructors.
It also other related models such as `chat` and `payment`. It has different states
for its full life-cycle.
- `belongs_to student`
- `belongs_to instructor`
- `has_one chat`
- `has_one payment`

### `chats`
- A chat contains many chat lines. Assuming not only consult transaction can have
chat lines, a chat model is created. But now a chat belongs to a transaction. It
could be redesigned to belong to a polymorphic `chattable` model.
- `belongs_to consult_transaction`
- `has_many chat_lines`

### `payments`
- Not fully implemented. The `method` field is reserved as an enum for values such
as `credit_card`, `alipay`, `wechat`, etc. `external_id` is reserved for details
on each of those methods by polymorphism.
- `belongs_to consult_transaction`

### `messages`
- A message is an off-line chat line with `attachments`. Actually the two are so
similar that we could consider unifying them. There is no `chat` analogy for
`message`, but we can definitely have one. Currently the idea is that, a student
starts contacting the instructor with message, and throughout the whole instruction.
Chat is used only when they are communication in a timed period, and chat comes
with voice chat.
- `belongs_to sender`
- `belongs_to receiver`
- `has_many attachments as attachable`

### `attachments`
- An attachment holds metadata for an uploaded file. It is associated with an
`attachable` which contains user information. Calls `authorized_by(user)` checks
the ownership of this attachment. The `file` field is filled with a file uploaded
by `carrierwave`.
- `belongs_to attachable`

### `private_policies`
- Not sure if we still need it. This table keeps private policy versions so we
have evidence in case of law suits or some other troubles.
- `belongs_to instructor`

## How to run the test suite
no test suit

## Services (job queues, cache servers, search engines, etc.)
no service

## Deployment instructions
Currently MySQL is used. Make sure MySQL uses `/var/run/mysqld/mysqld.sock` as
the socket connection. Change `/config/database.yml` or the MySQL config so Rails
can communicate with MySQL.

To have a working HTML5 audio communication, server needs to run under HTTPS,
which requires using nginx or somehing alike. Checkout [this blog](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-puma-and-nginx-on-ubuntu-14-04)
for more information.

Redis needs to run on production environment for Rails Channel, so we can have
chat room and audio communication.

Audio communication also requires a stun server for NAT discovery. More details
[here](https://www.html5rocks.com/en/tutorials/webrtc/infrastructure/#after-signaling-using-ice-to-cope-with-nats-and-firewalls).
There are many free stun servers online (for example this Google one: stun.l.google.com:19302).
Since running one is not computationally expensive, you can also install a
[turnserver](https://github.com/coturn/coturn) and run it with `-S` option.


# deployment instructions
1.  cap production deploy
2.  cap production deploy:migrating
3.  cap production deploy:restart
