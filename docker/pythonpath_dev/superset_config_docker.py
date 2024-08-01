AUTH_ROLE_PUBLIC = 'Public'
PUBLIC_ROLE_LIKE = 'Public'
FAB_API_SWAGGER_UI = False
APP_NAME = "Jabberbrain Dashboards"

# Specify the App icon
APP_ICON = "/static/jb_assets/images/jb-logo-horiz.png"
LOGO_TARGET_PATH = "/"

FEATURE_FLAGS : dict[str, bool] = {
    "DASHBOARD_RBAC": True,
    "ENABLE_TEMPLATE_PROCESSING": True, # Enables JINJA templating for SQLs
    "HORIZONTAL_FILTER_BAR": True
}

# Custom security manager
import logging
import os
from superset.custom.security import CustomSecurityManager
from superset.custom.views import CustomIndexView
from flask import g

log = logging.getLogger(__name__)

CUSTOM_SECURITY_MANAGER=CustomSecurityManager
FAB_INDEX_VIEW = f"{CustomIndexView.__module__}.{CustomIndexView.__name__}"

GOOGLE_TAG_ID = os.getenv("GOOGLE_TAG_ID") or "no_google_id"
log.info("Google tag is: ", GOOGLE_TAG_ID)

# Custom macros
def current_user_solution_uuid():
    default_uuid = "no_solution"
    if g.user and hasattr(g.user, "solution_uuid"):
        return g.user.solution_uuid or default_uuid
    
    return default_uuid

def current_user_jabberbrain_version():
    default_version = "1"
    if g.user and hasattr(g.user, "jabberbrain_version"):
        return g.user.jabberbrain_version or default_version
    
    return default_version

JINJA_CONTEXT_ADDONS = {
    'current_user_solution_uuid': current_user_solution_uuid,
    'current_user_jabberbrain_version': current_user_jabberbrain_version
}