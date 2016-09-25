# Description:
#  Execute a shell command.
#
# Dependencies:
#  None
#
# Configuration
#  Change the script if you want to exeute a different command
#
# Commands:
#  hubot shell <command>
#

module.exports = (robot) ->
 robot.respond /shell (.*)$/i, (msg) ->
    command = msg.match[1]
    @exec = require('child_process').exec
    msg.send "This is the command #{command}."

    @exec command, (error, stdout, stderr) ->
      msg.send error
      msg.send stdout
      msg.send stderr

module.exports = (robot) ->
 robot.respond /jenkins2 build (.*)$/i, (msg) ->
    url = process.env.HUBOT_JENKINS_URL
    jenkinscli = process.env.HUBOT_JENKINS_CLI_PATH
    identity = process.env.HUBOT_JENKINS_IDENTITY_PATH
    job = msg.match[1]
    command = "java -jar #{jenkinscli} -s #{url} -i #{identity} build #{job} -s -v"
    @exec = require('child_process').exec

    @exec command, (error, stdout, stderr) ->
      msg.send error
      msg.send stdout
      msg.send stderr

parser  = require 'xml2json'

module.exports = (robot) ->
 robot.respond /jenkins2 desc (.*)$/i, (msg) ->
    url = process.env.HUBOT_JENKINS_URL
    jenkinscli = process.env.HUBOT_JENKINS_CLI_PATH
    identity = process.env.HUBOT_JENKINS_IDENTITY_PATH
    job = msg.match[1]
    command = "java -jar #{jenkinscli} -s #{url} -i #{identity} get-job #{job}"
    @exec = require('child_process').exec

    @exec command, (error, stdout, stderr) ->
      #msg.send error
      json = parser.toJson stdout
      content = JSON.parse(json)
      msg.send content.project.description
      msg.send stderr

