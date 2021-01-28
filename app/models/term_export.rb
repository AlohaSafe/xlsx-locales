# frozen_string_literal: true

class TermExport < Xport::Export
  include Xport::Axlsx

  columns do
    column(:key)
    column(:base)
    column(:translated)
  end
end
