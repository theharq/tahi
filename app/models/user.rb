class User < ActiveRecord::Base

  include UserDevise

  has_many :affiliations, inverse_of: :user
  has_many :submitted_papers, inverse_of: :user, class_name: 'Paper'
  has_many :paper_roles, inverse_of: :user
  has_many :user_roles, inverse_of: :user
  has_many :roles, through: :user_roles
  has_many :journals, ->{ uniq }, through: :roles
  has_many :flows, inverse_of: :user, dependent: :destroy
  has_many :tasks, foreign_key: 'assignee_id'
  has_many :comments, inverse_of: :commenter, foreign_key: 'commenter_id'
  has_many :message_participants, inverse_of: :participant
  has_many :comment_looks
  has_many :credentials, inverse_of: :user, dependent: :destroy
  has_many :assigned_papers, through: :paper_roles, class_name: 'Paper', source: :paper

  attr_accessor :login

  after_create :add_flows

  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 255 }
  validates :email, format: Devise.email_regexp
  validates :first_name, length: { maximum: 255 }
  validates :last_name, length: { maximum: 255 }

  mount_uploader :avatar, AvatarUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable,
         authentication_keys: [:login],
         omniauth_providers: [:orcid, :cas]

  def self.admins
    where(admin: true)
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def auto_generate_password(length=10)
    self.password = SecureRandom.urlsafe_base64(length-1)
  end

  def administered_journals
    if admin?
      Journal.all
    else
      journals.merge(Role.can_administer_journal)
    end
  end

  def accessible_paper_ids
    if admin?
      Paper.all.pluck(:id)
    else
      admin_papers = Paper.where(journal: journals.merge(Role.can_view_all_manuscript_managers))
      assigned_papers.pluck(:id) | admin_papers.pluck(:id)
    end
  end

  def self.search_users(query: nil, assigned_users_in_journal_id: nil)
    if query
      sanitized_query = connection.quote_string(query.to_s.downcase) + '%'
      User.where("lower(username) LIKE '#{sanitized_query}' OR lower(first_name) LIKE '#{sanitized_query}' OR lower(last_name) LIKE '#{sanitized_query}'")
    elsif assigned_users_in_journal_id
      User.joins(user_roles: :role).where('roles.journal_id = ?', assigned_users_in_journal_id).uniq
    end
  end

  private

  def add_flows
    [Flow.templates.values].each do |attrs|
      flows.create!(attrs)
    end
  end
end
