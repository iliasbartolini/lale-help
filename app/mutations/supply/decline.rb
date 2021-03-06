class Supply::Decline < Mutations::Command
  required do
    model :user
    model :supply
  end

  def execute
    assignment = Supply::Role.send('supply.volunteer').find_by(supply: supply, user: user)

    return unless assignment.present?

    assignment.destroy
    Task::Comments::Base.run(task: supply, message: 'user_unassigned', user: user)

    assignment
  end
end
