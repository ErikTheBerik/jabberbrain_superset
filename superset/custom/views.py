from flask_appbuilder.security.views import UserDBModelView
from flask_babel import lazy_gettext

class CustomUserDBModelView(UserDBModelView):
    """
    View that adds DB specifics to User view. Override to implement your own custom view.
    Then override userdbmodelview property on SecurityManager.
    """

    show_fieldsets = UserDBModelView.show_fieldsets[:]
    show_fieldsets[0][1]['fields'].append('solution_uuid')
    show_fieldsets[0][1]['fields'].append('jabberbrain_version')

    user_show_fieldsets = UserDBModelView.user_show_fieldsets[:]
    user_show_fieldsets[0][1]['fields'].append('solution_uuid')
    user_show_fieldsets[0][1]['fields'].append('jabberbrain_version')

    add_columns = UserDBModelView.add_columns[:]
    add_columns.append('solution_uuid')
    add_columns.append('jabberbrain_version')
    
    list_columns = UserDBModelView.list_columns[:]
    list_columns.append('solution_uuid')
    list_columns.append('jabberbrain_version')

    edit_columns = UserDBModelView.edit_columns[:]
    edit_columns.append('solution_uuid')
    edit_columns.append('jabberbrain_version')