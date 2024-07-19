AUTH_ROLE_PUBLIC = 'Public'
PUBLIC_ROLE_LIKE = 'Public'
FAB_API_SWAGGER_UI = False
APP_NAME = "Jabberbrain Dashboards"

# Specify the App icon
APP_ICON = "/static/jb_assets/images/jb-logo-horiz.png"

FEATURE_FLAGS : dict[str, bool] = {
    "DASHBOARD_RBAC": True,
    "ENABLE_TEMPLATE_PROCESSING": True, # Enables JINJA templating for SQLs
    "HORIZONTAL_FILTER_BAR": True
}

ENABLE_PROXY_FIX = False
WTF_CSRF_ENABLED = False
TALISMAN_ENABLED = False

# Custom security manager
import logging
from superset.custom.security import CustomSecurityManager
from flask import g
CUSTOM_SECURITY_MANAGER=CustomSecurityManager

log = logging.getLogger(__name__)

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
