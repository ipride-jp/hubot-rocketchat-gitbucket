# Description:
#   gitbucket to rocketchat 
#
# Commands:
#   None

module.exports = (robot) ->
  @robot = robot
  @robot.router.post "/gitbucket-to-rocketchat/:room", (req, res) ->
    room = req.params.room
    body = req.body

    if body.payload
      #console.log body

      payload = JSON.parse body.payload
      repoUrl = payload.repository.html_url
      repoName = payload.repository.full_name
      action = payload.action
      comment = payload.comment
      issue = payload.issue
      pr = payload.pull_request
      commits = payload.commits
      sender = payload.sender
      userName = ""
      title = ""
      url = ""
      body = ""

      if action is "created"
        # Comment
        if comment
          action = "updated"
          userName = comment.user.login
          title = "##{issue.number}: #{issue.title}"
          url = comment.html_url
          body = comment.body

      else if action in ["opened", "closed", "reopened"]
        # Issue
        if issue
          userName = sender.login
          title = "##{issue.number}: #{issue.title}"
          url = issue.html_url
          body = if action is "opened" then issue.body else action

        # Pull Request
        if pr
          userName = pr.user.login
          title = "##{pr.number}: #{pr.title}"
          url = pr.html_url
          body = pr.body
      else
        #commit
        userName = commits[0].author.name
        action = "committed"
        title = commits[0].id
        url = commits[0].html_url || commits[0].url
        body = commits[0].message

      data =
        content:
          title: "[#{repoName}] #{userName} #{action} #{title}"
          title_link: "#{url}"
          color: "#e3e4e6"
        #username: "hubot"
        #channel: room
      if action in ["updated", "opened", "committed"]
        data.content.text = body
      else
        data.content.text = action

      if action in ["opened", "reopened"]
        data.content.color = "#468847"
      if action in ["closed"]
        data.content.color = "#B94A48"

      msg = 
        "attachments": [data.content]

      robot.messageRoom room, msg 

    res.end "OK"
