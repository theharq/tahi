class Phase < ActiveRecord::Base
  belongs_to :task_manager, inverse_of: :phases
  has_many :tasks, inverse_of: :phase
  has_many :message_tasks, -> { where(type: 'MessageTask') }, inverse_of: :phase

  has_one :paper, through: :task_manager

  after_initialize :initialize_defaults

  DEFAULT_PHASE_NAMES = [
    "Submission Data",
    "Assign Editor",
    "Assign Reviewers",
    "Get Reviews",
    "Make Decision"
  ]

  def self.default_phases
    DEFAULT_PHASE_NAMES.map.with_index { |name, pos| Phase.new name: name, position: pos }
  end

  def self.insert_or_update_positions(phase_params)
    Phase.transaction do
      if phase_params[:id]
        new_phase = Phase.find(phase_params[:id].to_i).update_attributes! phase_params
      else
        new_phase = Phase.create! phase_params
      end

      head, tail = new_phase.task_manager.phases.partition do |phase|
        phase.position >= new_phase.position
      end

      tail.each do |phase|
        phase.position = phase.position + 1
        phase.save
      end
    end

    new_phase
  end

  private

  def initialize_defaults
    return if persisted? || tasks.any?
    case name
    when 'Submission Data'
      self.tasks << UploadManuscriptTask.new
      self.tasks << AuthorsTask.new
      self.tasks << FigureTask.new
      self.tasks << DeclarationTask.new
    when 'Assign Editor'
      self.tasks << PaperAdminTask.new
      self.tasks << TechCheckTask.new
      self.tasks << PaperEditorTask.new
    when 'Assign Reviewers'
      self.tasks << PaperReviewerTask.new
    when 'Make Decision'
      self.tasks << RegisterDecisionTask.new
    end
  end
end
