# == Schema Information
#
# Table name: scraps
#
#  http_method        :string(255)      default("GET"), not null
#  endpoint           :string(255)      not null
#  status_code        :integer          default(200), not null
#  content_type       :string(255)      default("application/json"), not null
#  body               :text             not null
#  is_public          :boolean          default(TRUE), not null
#  description        :text
#  language           :string(255)      default("json"), not null
#  character_encoding :string(255)      default("UTF-8"), not null
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  uid                :string(255)      not null, primary key
#

require 'liquid'
class Scrap < ActiveRecord::Base
  self.primary_key = "uid"

  HTTP_METHODS = [
    "GET", "POST", "PUT", "PATCH", "DELETE"
    #COPY HEAD OPTIONS
    #LINK UNLINK PURGE
  ].freeze

  ENCODINGS = [
    "UTF-8",
    "UTF-16",
    "ISO-8859-1"
  ].freeze

  LANGUAGES = {
    "XML" => "xml",
    "Javascript" => "javascript",
    "JSON" => "json",
    "HTML" => "html",
    "Text" => "plain_text"
  }.freeze

  validates :user,
            presence: true

  validates :http_method,
            presence: true,
            inclusion: { in: HTTP_METHODS }

  validates :endpoint,
            presence: true,
            uniqueness: {
              scope: [:user, :http_method]
            }

  validates :status_code,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 100,
              less_than: 600
            }

  validates :content_type,
            presence: true

  validates :body,
            presence: true

  validates :is_public,
            inclusion: { in: [true, false] }

  validates :character_encoding,
            inclusion: { in: ENCODINGS }

  validates :language,
            inclusion: { in: LANGUAGES.values }

  validates :uid,
            presence: true

  belongs_to :user

  before_validation :ensure_uid!

  scope :visible, ->{ where(:is_public => true) }
  scope :invisible, ->{ where(:is_public => false) }
  scope :newest, ->{ order(:created_at => :desc) }
  scope :oldest, ->{ order(:created_at => :asc) }
  scope :lively, ->{ order(:updated_at => :desc) }
  scope :stagnant, ->{ order(:updated_at => :asc) }


  # @param [Integer] lines Number of lines to truncate at
  # @return [String] rebuilt body string for condensed output
  def truncate_body(lines=10)
    body_arr = body_lines
    output = []
    output << body_arr[0...lines]
    output << "..." if (body_arr.size > lines.to_i)
    output.join("\n")
  end#truncate_body


  # @return [Array]
  def body_lines
    body.split(/\r\n|\r|\n/)
  end#body_lines


  # Get compatible hash for ActiveController::Base#render
  #
  # @param [Hash] opts
  # @option opts [Hash] :liquid
  #   A hash of liquid variable-value mappings.
  #
  # @return [Hash]
  def render_options(opts={})
    liquid_opts = opts.fetch(:liquid, {})

    {
      body: self.liquid_body(liquid_opts),
      content_type: self.content_type,
      status: self.status_code
    }
  end#render_options


  # parses @body as potential liquid template against given variables
  #
  # @return [String]
  def liquid_body(values={})
    Liquid::Template.parse(self.body).render(values)
  end#liquid_body


  # NOTE: Make sure "Content-Type" is always self.content_type
  # Get Additional HTTP Headers to tack onto the request
  # These values can override values set in #render_options.
  #
  # @return [Hash]
  def http_headers
    {
      "Access-Control-Allow-Origin" => "*",
      "Content-Type" => self.content_type
    }
  end#http_headers


  # Creates a SecureRandom UUID and sets the uid
  # @return [String]
  def generate_uid!
    self.uid = SecureRandom.uuid
  end#generate_uid!


  def ensure_uid!
    self.uid ||= generate_uid!
  end
end#Scrap
