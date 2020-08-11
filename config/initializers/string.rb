require 'iconv'

class String
  def remove_non_ascii
    self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s.gsub(/[^a-z._0-9 -]/i, "").tr(".", "_")
  end

  def remove_non_ascii_and_spaces
    remove_non_ascii.gsub(/(\s+|-)/, "_").downcase
  end

  def remove_non_ascii_and_spaces_and_number_start
    remove_non_ascii.gsub(/(\s+|-)/, "_").gsub(/(^\d+)/, "_#{$1}")
  end

  def remove_non_ascii_and_spaces_and_dashes
    remove_non_ascii.gsub(/(\s+)/, "").downcase
  end

  def remove_non_ascii_and_keep_comma
    self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s.gsub(/[^a-z._0-9 -,]/i, "")
  end

  def remove_non_ascii_and_keep_specials
    self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').downcase.to_s
  end

  def remove_non_ascii_and_keep_specials_normal_case
    self.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').to_s
  end

  def ellipsisize(len = 9)
    len = 9 unless len > 9
    gsub(%r{(...).{#{len-5},}(...)}, '\1...\2')
  end

  def is_number?
    string = self.gsub(",", "")
    string.gsub!(".", "")
    return false if self.blank?
    true if Float(string) rescue false
  end

  def is_date?
    return false if self.blank?
    true if self.to_date rescue false
  end
end
