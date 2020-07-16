class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
	#デバイス機能実行前にconfigure_permitted_parametersの実行をする。
	protect_from_forgery with: :exception

  protected
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  #sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :image, :introduction])
    #sign_upの際にnameのデータ操作を許。追加したカラム。
  end

  Refile.secret_key = '44a1cadb2e1af5580b9e05dd2fa2c7a04094b1614c97910eab056096c40e67f1ceec4e6496f03d7de3d503de5dfadfa41db1ff48ae537ec788164727c6b46a46'
end
