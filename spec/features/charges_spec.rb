require 'rails_helper'

describe "Charges" do
  let(:user) { create(:user) }

  def setup_scenario
  end

  before do
    setup_scenario
  end

  context "given I'm on '/charges/new'" do
    def setup_scenario
      super
      visit(new_charge_path)
    end

    context "and I test out payment using bongloy.js", :js do
      include Bongloy::SpecHelpers::FeatureHelpers::FormHelpers

      def submit_form
        click_button("Pay with Bongloy")
      end

      def within_payment_form(&block)
        within("form#new_charge") do
          yield
        end
      end

      def form_inputs
        {:card_number => nil, :card_expiry => nil, :card_cvc => nil}
      end

      def find_form_group(form_input)
        within_payment_form do
          page.find("##{form_input}")
        end
      end

      def fill_in_card_number(options = {})
        native_fill_in("Card Number", options)
      end

      def fill_in_card_expiry(options = {})
        native_fill_in("Expires MM/YY", options)
      end

      def fill_in_card_cvc(options = {})
        native_fill_in("Security Code / PIN", options)
      end

      def valid_expiry
        1.month.from_now.strftime("%m%y")
      end

      def fill_out_payment_form(options = {})
        expiry = options[:expiry] || valid_expiry
        within_payment_form do
          if options[:card]
            fill_in_card_number(:with => options[:card][:number])
            fill_in_card_expiry(:with => expiry)
            fill_in_card_cvc(:with => options[:card][:cvc])
          end
          submit_form
        end
      end

      context "without filling in the form" do
        def setup_scenario
          super
          fill_out_payment_form
        end

        def assert_form_errors!
          form_inputs.keys.each do |form_input_id|
            form_group = find_form_group(form_input_id)
            expect(form_group[:class]).to include("has-error")
          end
        end

        it { assert_form_errors! }
      end

      context "filling in the form using my" do
        let(:api_helpers) { Bongloy::SpecHelpers::ApiHelpers.new }

        def setup_scenario
          super
          api_helpers.stub_create_customer
          api_helpers.stub_create_charge
          fill_out_payment_form(:card => card)
        end

        context "Wing Card" do
          let(:card) { {:number => "5018188000001614", :cvc => "1234"}  }

          def assert_successful_charge!
            within_flash do
              expect(page).to have_link(ENV["BONGLOY_CHARGES_URL"])
              expect(page).to have_content(ENV["BONGLOY_TEST_ACCOUNT_EMAIL"])
              expect(page).to have_content(ENV["BONGLOY_TEST_ACCOUNT_PASSWORD"])
            end
          end

          it { assert_successful_charge! }
        end
      end
    end
  end
end
