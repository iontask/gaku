module Campusys
  module Campusys-admin
    class Engine < ::Rails::Engine
      isolate_namespace Campusys
      engine_name 'campusys'

      config.autoload_paths += %W( #{config.root}/lib )

      initializer 'campusys.paperclip' do
        Paperclip.interpolates(:placeholder) do |_attachment, style|
          ActionController::Base.helpers.asset_path("missing_#{style}.png")
        end
      end

      initializer 'campusys.ruby_template_handler' do
        ActionView::Template.register_template_handler(:rb, :source.to_proc)
      end

      initializer 'campusys.mime_types' do
        Mime::Type.register 'application/xls', :xls
      end

      config.after_initialize do
        Rails.application.routes_reloader.reload!
      end

    end
  end
end
