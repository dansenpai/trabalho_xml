xml.instruct! :xml, :version => '1.0'
xml.students do 
  @students.each do |student|
    xml.student do
      xml.name student[:name]
      xml.course student[:course]
      xml.matricula student[:matricula]
      xml.phone student[:phone]
    end
  end
end