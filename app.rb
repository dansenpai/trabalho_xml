#coding: utf-8
require "sinatra"
require 'sinatra/activerecord'
require 'sinatra/flash'
require_relative './models/student'
require 'nokogiri'

set bind: '0.0.0.0'
enable :static
set :public_folder,'bower_components'
enable :sessions

layout "views/layouts/application"

##### ROUTES #####
get	"/alunos.xml" do
  @students = Student.all
  if @students.size < 1
    flash[:message] = 'Não existem estudantes cadastrados'
    redirect "/" 
  end
  builder :xml
end

get "/aluno/:id.xml" do
  @students = []
  @students.push(Student.find_by_id(params[:id]))
  builder :xml
end

get "/" do
  @students = Student.all
  haml :'welcome'
end

get "/alunos/cadastro" do
  haml :'students/new'
end

post "/alunos" do
  students = []
  doc = Nokogiri::XML(File.read(params[:file][:tempfile]))
  doc.xpath('/students/student').each do |element|
    student = Student.create!(
      name: element.xpath('name').text,
      course: element.xpath('course').text,
      matricula: element.xpath('matricula').text,
      phone: element.xpath('phone').text
    )
    if student.save
      flash[:message] = "Usuário salvo"
    else
      flash[:message] = "Usuário inválido verifique seu arquivo"
      redirect "/"
    end
  end
  redirect "/"
end

delete 'aluno/:id' do |id|
  Student.delete(id)
end