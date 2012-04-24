class Newsletter

  def self.all(users)
    emails = Array.new
    users.each { |u| emails << u.email }
    emails.join(", ")
  end

end
