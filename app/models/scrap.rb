# == Schema Information
#
# Table name: scraps
#
#  id                 :integer          not null, primary key
#  http_method        :string(255)      default("GET"), not null
#  endpoint           :string(255)      not null
#  status_code        :integer          default(200), not null
#  content_type       :string(255)      default("application/json"), not null
#  body               :text             not null
#  private            :boolean          default(FALSE), not null
#  character_encoding :string(255)      default("UTF-8"), not null
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class Scrap < ActiveRecord::Base
  self.primary_key = "uid"

  ENCODINGS = [ "UTF-8", "UTF-16", "ISO-8859-1" ]

  validates :endpoint,
            presence: true,
            uniqueness: { scope: [:user] } # TODO: TEST

  # TODO: regex validation of code (cannot be more than 599 or less than 100)
  validates :status_code,
            presence: true

  validates :content_type,
            presence: true

  validates :body,
            presence: true

  validates :character_encoding,
            inclusion: { in: ENCODINGS }

  belongs_to :user

  before_create :generate_uid!

  scope :publicly_available, ->{ where(:private => false) }
  scope :recent, ->{ order(:created_at => :desc) }

  def self.from_param(slug)
    where(endpoint: slug)
  end

  # TODO: TEST
  def truncate_body(lines=10)
    body_arr = body.split("\r\n")
    output = []
    output << body_arr[0...lines]
    output << "..." if (body_arr.size > lines.to_i)
    output.join("\n")
  end#truncate_body


  # Get compatible hash for ActiveController::Base#render
  #
  # @return [Hash]
  def render_options
    {
      body: self.body,
      content_type: self.content_type,
      status: self.status_code
    }
  end#render_options


  # NOTE: Make sure "Content-Type" is always self.content_type
  # Get Additional HTTP Headers to tack onto the request
  # These values can override values set in #render_options.
  #
  # @return [Hash]
  def http_headers
    {
      "Content-Type" => self.content_type
    }
  end#http_headers

  #private
  def generate_uid!
    self.uid = SecureRandom.uuid
  end#generate_uid!
end#Scrap
