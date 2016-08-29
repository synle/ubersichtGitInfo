FOLDER_TO_TRACKS = [
  '~/git/github-improved',
  '~/git/ubuntu-setup',
]

# where is your node binary path
NODE_BINARY_PATH = '~/.nvm/versions/node/v6.3.0/bin/node' #"/usr/local/bin/node"

folderArgToSend = FOLDER_TO_TRACKS.join ' '

folderToTrack: FOLDER_TO_TRACKS
command: "cd ~/git/github-improved; git branch > /tmp/11"

refreshFrequency: 2000

style: """
  bottom 310px
  left 15px


  // Statistics text settings
  color #fff
  font-family Helvetica Neue
  background rgba(#000, .7)
  padding 10px
  border-radius 5px
  width 250px


  .header
    text-transform uppercase
    font-size 10px


  .folder
    text-transform uppercase
    font-weight bold
    color #28bacb
    font-size 10px

  .branch
    text-transform uppercase
    padding-left 5px
    font-size 10px
"""


render: -> """
  <div>
    <div class="header">Git Info</div>
    <div class="body"></div>
  </div>
"""

update: (output, domEl) ->
  branches = output.trim().split('\n').sort()

  bodyDomEl = $(domEl).find(".body").empty()
  for branch, i in branches
    splits = branch.split '|||'
    folderName = splits[0]
    folderName = folderName.substr( folderName.lastIndexOf( '/' ) + 1).trim()
    folderBranch = splits[1].trim()

    bodyDomEl.append("""
      <div class="row">
        <span class='folder'>#{folderName}</span>
        <span class='branch'>#{folderBranch}</span>
      </div>
    """)
