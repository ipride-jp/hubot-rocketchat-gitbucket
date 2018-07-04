# hubot-rocketchat-gitbucket

## Quick Install
```
git clone https://github.com/ipride-jp/hubot-rocketchat-gitbucket
cd hubot-rocketchat-gitbucket
npm install
```

Create a .env file with content:
```
export ROCKETCHAT_URL=ROCKETCHAT_SERVER
export ROCKETCHAT_USER=HUBOT_USER
export ROCKETCHAT_PASSWORD=HUBOT_PASSWORD
export ROCKETCHAT_ROOM=general
export ROCKETCHAT_USESSL=true
```

Run the bot:
```
source .env
bin/hubot
```

Add webhook in gitbucket site.
```
http://HUBOT_SERVER:8080/gitbucket-to-rocketchat/ROOM_NAME
```
