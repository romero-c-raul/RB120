=begin

- Alyssa has been assigned a task of modifying a class that was initially created
  to keep track of secret information. The new requirement calls for adding 
  logging, when clients of the class attempt to access the secret data. Here is 
  the class in its current form:
=end

# class SecretFile
#   attr_reader :data

#   def initialize(secret_data)
#     @data = secret_data
#   end
# end

=begin
- She needs to modify it so that any access to data must result in a log entry
  being generated. That is, any call to the class which will result in data 
  being returned must first call a logging class. The logging class has been 
  supplied to Alyssa and looks like the following:
=end

# class SecurityLogger
#   def create_log_entry
#     # ... implementation omitted ...
#   end
# end

=begin
- Hint: Assume that you can modify the initialize method in SecretFile to have 
  an instance of SecurityLogger be passed in as an additional argument. It may be
  helpful to review the lecture on collaborator objects for this practice problem.
=end

=begin
- Constructor method is given the secret data as a parameter
  - Secret data is assigned to instance variable '@data'
- Modify class so that a log entry is generated everytime the data is accessed
  - Any call to the class that results in data being returned must first call
    a logging class
  - We can modify initialize method to have an instance of security logger be
    passed in as an additional argument
=end

class SecurityLogger
  
  def create_log_entry
    # ... implementation omitted ...
  end
end

class SecretFile
  #attr_reader :data

  def initialize(secret_data, data_logger)
    @data = secret_data
    @sec_logger = data_logger # Assigned SecurityLogger instance to instance variable
  end
  
  def obtain_data
    sec_logger.create_log_entry # generates log everytime method is called
    data
  end
  
  private
  
  attr_reader :data, :logger
end

client_password = 'helloworld'

data_logger = SecurityLogger.new
sensitive_client_info = SecretFile.new(client_password, data_logger)

# Everytime the obtain_data method is called, the SecurityLogger instance that
# was passed as an argument will generate a log