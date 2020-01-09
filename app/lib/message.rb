class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found."
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.account_created
    'Account created successfully'
  end

  def self.account_not_created
    'Account could not be created'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login to continue.'
  end

  def self.sweet_not_found
    'Could not find sweet'
  end

  def self.sweet_removed
    'Sweet removed'
  end

  def self.sweet_already_liked
    'Sweet already liked'
  end

  def self.sweet_already_unliked
    'Sweet already unliked'
  end

  def self.user_already_following
    'User already following'
  end

  def self.user_not_following
    'User not following'
  end

end
