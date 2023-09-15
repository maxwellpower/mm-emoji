# Slack to Mattermost Emoji Transfer Tool

Transfer emojies from Slack to Mattermost

## Usage

The Docker image will download all emoji's from Slack and upload them to Mattermost.

- Copy the `defaults.env` file to `.env` in your local directory and edit it to include your Slack and 
Mattermost credentials

  ```bash
  cp defaults.env .env
  vi .env
  docker run -it --rm --name mm-emoji --env-file=.env ghcr.io/maxwellpower/mm-emoji
  ```

### Create Slack App

- https://api.slack.com/apps
- Use Manifest

  ```yaml
  display_information:
    name: mmemoji
  oauth_config:
    scopes:
      user:
        - emoji:read
  settings:
    org_deploy_enabled: false
    socket_mode_enabled: false
    token_rotation_enabled: false
  ```

- Navigate to "OAuth and Permissions"
- Install App to Workspace
- Copy "OAuth Tokens for Your Workspace", "User OAuth Token"

## Based on

- https://tomash.wrug.eu/blog/2022/11/06/migrating-slack-to-mattermost/
- https://github.com/maxbrunet/mmemoji
