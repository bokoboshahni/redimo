# frozen_string_literal: true

# Controller for EVE SSO authentication.
class AuthenticationsController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: %i[customer associate]

  layout 'landing'

  def associate
    esi_callback
  end

  def customer
    esi_callback
  end

  def failure
    render :error
  end

  private

  def esi_callback
    user = User.from_esi(request.env['omniauth.auth'])
    if user.persisted? && allowed_alliance_ids.exclude?(user.eve_alliance_id)
      user.destroy
      render :error
    elsif user.persisted?
      sign_in_and_redirect(user, event: :authentication) if user.persisted?
    end
  end

  def allowed_alliance_ids
    Rails.application.config.x.hos.allowed_alliance_ids
  end
end
