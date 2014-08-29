## Tahi Card Generator

### Description

This Rails Generator helps you create a custom Task easily.

From the command line, within your Tahi project, type:

    rails generate task <task_name>

    # Always leave this blank for now
    What engine are you using? (leave blank for StandardTasks):

Then, you should see...

    create  engines/standard_tasks/app/models/standard_tasks/<task_name>_task.rb
    create  engines/standard_tasks/app/serializers/standard_tasks/<task_name>_task_serializer.rb
    create  engines/standard_tasks/app/assets/javascripts/standard_tasks/models/<task_name>_task.js
    create  engines/standard_tasks/app/assets/javascripts/standard_tasks/views/overlays/<task_name>_overlay_view.js
    create  engines/standard_tasks/app/assets/javascripts/standard_tasks/controllers/overlays/<task_name>_overlay_controller.js
    create  engines/standard_tasks/app/assets/javascripts/standard_tasks/serializers/<task_name>_task_serializer.js
    create  engines/standard_tasks/app/assets/javascripts/standard_tasks/adapters/<task_name>_task_adapter.js
    create  engines/standard_tasks/app/assets/javascripts/standard_tasks/templates/overlays/<task_name>_overlay.hbs
    insert  app/services/task_services/create_task_types.rb



## Notes

* need to be an admin to add the Task to a Card
* need to run a generator
* rake data:create_default_task_types
* go into a Journal. go to its Manuscript Manager Template then edit it.
* add your Task/Card to the MMT. save
