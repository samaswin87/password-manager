module Importable
  extend ActiveSupport::Concern

  class_methods do
    def importable
      has_many :imports, as: :source, class_name: "FileImport", dependent: :delete_all
    end
  end

end
