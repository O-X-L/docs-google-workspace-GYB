# Got-Your-Back (for Google Workspace) Documentation - Sphinx Material-Themed

EN 🇬🇧: [gyb.docs.oxl.app](https://gyb.docs.oxl.app)

[![Docs Uptime](https://status.oxl.at/api/v1/endpoints/4--docs-mirrors_docs-mirror-gyb-for-google-workspace/uptimes/7d/badge.svg)](https://status.oxl.at/endpoints/4--docs-mirrors_docs-mirror-gyb-for-google-workspace)

This is a mirror of the [official Got-Your-Back documentation](https://github.com/GAM-team/got-your-back/wiki) so it easier accessible for new users.

## Build

Run:

```
apt install git python3-pip

# with VENV
apt install python3-virtualenv 
bash venv.sh

# WITHOUT
pip install -r requirements.txt

# USAGE: bash html.sh <BUILD-DIR> <DOMAIN> 
bash html.sh ./build/ gyb.docs.oxl.app
```
