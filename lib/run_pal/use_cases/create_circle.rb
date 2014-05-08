# module RunPal
#   class CreateCircle < UseCase

#     def run(inputs)

#       user = RunPal.db.get_user(inputs[:admin_id])
#       return failure (:user_does_not_exist) if user.nil?

#       circle = RunPal.db.get_circle(inputs[:circle_id])
#       # task = TM.db.get_task(inputs[:task_id].to_i)
#       # return failure(:task_does_not_exist) if task.nil?

#       # emp = TM.db.get_emp(inputs[:employee_id].to_i)
#       # return failure(:employee_does_not_exist) if emp.nil?

#       # proj = TM.db.get_project(task.projID)
#       # return failure(:employee_not_assigned_to_proj) if proj.emp_ids[emp.id].nil?

#       # add_employee_to_task(emp, task)

#       # # Return a success with relevant data
#       # success :task => task, :employee => emp
#     end

#     def create_circle(emp, task)
#       # NOT SHOWN: Modify task to assign to employee
#       # ...
#       TM.db.update_task(task.id, {eid: emp.id})
#       # {success?: true, task: task}
#     end

#   end
# end
