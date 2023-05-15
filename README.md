# Slack to Mattermost Emoji Transfer Tool

Transfer emojies from Slack to Mattermost

## Usage

The Docker image will download all emoji's from Slack and upload them to Mattermost.

- Copy the `defaults.env` file to your local directory and edit it to include your Slack and Mattermost credentials

```bash
docker run --env-file defaults.env ghcr.io/maxwellpower/mmemoji
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

- Install App to Workspace
- Copy Auth Token


## Based on

- https://tomash.wrug.eu/blog/2022/11/06/migrating-slack-to-mattermost/
- https://github.com/maxbrunet/mmemoji