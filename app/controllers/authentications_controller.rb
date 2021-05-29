# frozen_string_literal: true

# Controller for EVE SSO authentication.
class AuthenticationsController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: %i[customer associate]

  def associate
    esi_callback
  end

  def customer
    esi_callback
  end

  def failure
    redirect_to root_path
  end

  private

  def esi_callback
    user = User.from_esi(request.env['omniauth.auth'])
    sign_in_and_redirect(user, event: :authentication) if user.persisted?
  end
end
