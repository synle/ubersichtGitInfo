FOLDER_TO_TRACKS = [
  '~/git/github-improved',
  '~/git/ubuntu-setup',
]

# where is your node binary path
TEMP_PATH_FILE = '/tmp/11';
cmdToSend = [];

for folder, i in FOLDER_TO_TRACKS
  cmdToSend.push( """cd #{folder}; echo ${PWD} >> #{TEMP_PATH_FILE}; git branch | grep '*' >> #{TEMP_PATH_FILE}""");
console.log('cmdToSend', cmdToSend)
cmdToSend = cmdToSend.join(';')

folderToTrack: FOLDER_TO_TRACKS
command: "echo '' > #{TEMP_PATH_FILE}; #{cmdToSend}; sed -e 's/* //g' #{TEMP_PATH_FILE}"
 #
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
  tokens = output.trim().split('\n')
  branches = [];
  dirs = [];


  # find the branch dir
  for token, i in tokens
    if i % 2 is 1
      branches.push token
    else
      dirs.push token



  bodyDomEl = $(domEl).find(".body").empty()
  for branch, i in branches
    folderName = dirs[i]
    folderName = folderName.substr( folderName.lastIndexOf( '/' ) + 1).trim()
    folderBranch = branch.trim()

    bodyDomEl.append("""
      <div class="row">
        <span class='folder'>#{folderName}</span>
        <span class='branch'>#{folderBranch}</span>
      </div>
    """)
