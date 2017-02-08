class CheckoutConfiguration < ApplicationRecord
  DEFAULT_CURRENCY = "USD"
  CURRENCIES = [DEFAULT_CURRENCY]

  DEFAULT_AMOUNT_CENTS = 500

  belongs_to :user

  validates :currency, :presence => true, :inclusion => {:in => CURRENCIES}
  validates :name, :presence => true
  validates :description, :presence => true
  validates :label, :presence => true
  validates :product_description, :presence => true

  monetize :amount_cents, :with_model_currency => :currency,
                          :subunit_numericality => {
                            :greater_than_or_equal_to => 50
                          }

  before_validation :set_defaults, :on => :create
  after_validation  :copy_errors

  attr_accessor :bongloy_js_url, :checkout_js_url, :publishable_key,
                :bongloy_charges_url,
                :bongloy_test_account_email, :bongloy_test_account_password,
                :image_url, :charge_description

  delegate :first_name, :first_name?, :email, :to => :user, :prefix => true, :allow_nil => true

  def sample_expiry_date
    Time.now.strftime("%m / %y")
  end

  def charge_description
    @charge_description || "Charge from #{name}"
  end

  def image_url
    @image_url || ENV["BONGLOY_CHECKOUT_DEFAULT_IMAGE_URL"]
  end

  def publishable_key
    @publishable_key || ENV["BONGLOY_DEFAULT_PUBLISHABLE_KEY"]
  end

  def checkout_js_url
    @checkout_js_url || ENV["BONGLOY_CHECKOUT_DEFAULT_JS_URL"]
  end

  def bongloy_js_url
    @bongloy_js_url || ENV["BONGLOY_DEFAULT_JS_URL"]
  end

  def bongloy_charges_url
    @bongloy_charges_url || ENV["BONGLOY_CHARGES_URL"]
  end

  def bongloy_test_account_email
    @bongloy_test_account_email ||= ENV["BONGLOY_TEST_ACCOUNT_EMAIL"]
  end

  def bongloy_test_account_password
    @bongloy_test_account_password ||= ENV["BONGLOY_TEST_ACCOUNT_PASSWORD"]
  end

  def checkout_url_options
    {
      :amount_cents => amount_cents,
      :name => name,
      :description => description,
      :label => label
    }
  end

  def qr_code(url)
    RQRCode::QRCode.new(url)
  end

  def set_defaults
    self.name ||= (user_first_name? ? "#{user_first_name}'s Shop" : ENV["BONGLOY_CHECKOUT_DEFAULT_NAME"])
    self.description ||= ENV["BONGLOY_CHECKOUT_DEFAULT_DESCRIPTION"]
    self.product_description ||= ENV["BONGLOY_CHECKOUT_DEFAULT_PRODUCT_DESCRIPTION"]
    self.label ||= ENV["BONGLOY_CHECKOUT_DEFAULT_LABEL"]
    self.amount_cents ||= (ENV["BONGLOY_CHECKOUT_DEFAULT_AMOUNT"] || DEFAULT_AMOUNT_CENTS).to_i
    self.currency ||= ENV["BONGLOY_CHECKOUT_DEFAULT_CURRENCY"].to_s.upcase.presence || DEFAULT_CURRENCY
  end

  private

  def copy_errors
    errors[:amount_cents].each do |error|
      errors.add(:amount, error)
    end
  end
end
