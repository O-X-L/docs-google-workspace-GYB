from datetime import datetime

# pylint: disable=W0622

project = 'Google Workspace - Got-Your-Back Docs'
copyright = ''
author = 'https://github.com/GAM-team/got-your-back/graphs/contributors'
extensions = ['sphinx_immaterial', 'myst_parser']
templates_path = ['_templates']
exclude_patterns = []
html_theme = 'sphinx_immaterial'
html_static_path = ['_static']
master_doc = 'index'
display_version = True
sticky_navigation = True
# html_logo = 'https://files.oxl.at/img/oxl3_xst.webp'
# html_favicon = 'https://files.oxl.at/img/oxl3_sm.webp'
source_suffix = {
    '.rst': 'restructuredtext',
}
html_theme_options = {
    "site_url": "https://gyb.docs.oxl.app",
    "repo_url": "https://github.com/GAM-team/got-your-back",
    "repo_name": "GAM-team/got-your-back",
    "globaltoc_collapse": True,
    "features": [
        "navigation.expand",
        # "navigation.tabs",
        # "navigation.tabs.sticky",
        # "toc.integrate",
        "navigation.sections",
        # "navigation.instant",
        # "header.autohide",
        "navigation.top",
        "navigation.footer",
        # "navigation.tracking",
        # "search.highlight",
        "search.share",
        "search.suggest",
        "toc.follow",
        "toc.sticky",
        "content.tabs.link",
        "content.code.copy",
        "content.action.edit",
        "content.action.view",
        "content.tooltips",
        "announce.dismiss",
    ],
    "palette": [
        {
            "media": "(prefers-color-scheme: light)",
            "scheme": "default",
            "primary": "light-blue",
            "accent": "light-green",
            "toggle": {
                "icon": "material/lightbulb",
                "name": "Switch to dark-mode",
            },
        },
        {
            "media": "(prefers-color-scheme: dark)",
            "scheme": "slate",
            "primary": "deep-orange",
            "accent": "lime",
            "toggle": {
                "icon": "material/lightbulb-outline",
                "name": "Switch to light-mode",
            },
        },
    ],
    "version_dropdown": True,
    "version_info": [
        {
            "version": "https://github.com/GAM-team/got-your-back",
            "title": "Got-Your-Back on GitHub",
            "aliases": [],
        },
        {
            "version": "https://gam.docs.oxl.app",
            "title": "GAM Documentation",
            "aliases": [],
        },
    ],
    "social": [
        {
            "icon": "fontawesome/brands/github",
            "link": "https://github.com/O-X-L",
            "name": "OXL on GitHub",
        },
    ],
}
html_title = 'Got-Your-Back Docs'
html_short_title = 'Google Workspace - Got-Your-Back Documentation'
html_js_files = ['https://files.oxl.at/js/feedback.js']
html_css_files = ['css/main.css', 'https://files.oxl.at/css/feedback.css']