NewsletterJob = Struct.new(:text) do
  def perform
    #say "performing"

    user = User.create({:name => 'Jamie', :rating1 => 1, :rating2 => 2})

    user.save
  end

  def say(text)
    Delayed::Worker.logger.add(Logger::INFO, text)
  end
end