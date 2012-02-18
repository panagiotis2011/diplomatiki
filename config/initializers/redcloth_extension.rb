require 'RedCloth'

module RedCloth::Formatters::HTML
  include RedCloth::Formatters::Base

  #######################################################

  # ALWAYS restart your server after changing this file #

  #######################################################

  def mytag(opts)
    Rails.logger.info "Own method mytag is active"
    "<b>#{opts[:text]}</b>"
  end
end
