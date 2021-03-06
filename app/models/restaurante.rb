class Restaurante < ActiveRecord::Base
	has_and_belongs_to_many :prato
	has_many :qualificacoes
	has_many :comentarios, :as => :comentavel

	validates_presence_of :nome, message: "Deve ser preenchido"
	validates_presence_of :endereco, message: "Deve ser preenchido"
	validates_presence_of :especialidade, message: "Deve ser preenchido"

	validates_uniqueness_of :nome, message: "Nome ja cadastrado"
	validates_uniqueness_of :endereco, message: "Endereco ja cadastrado"

	validate :primeira_letra_maiuscula

	has_attached_file :foto, styles: { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.jpg"
	# Validate content type
  	validates_attachment_content_type :foto, :content_type => /\Aimage/
	# Validate filename
  	validates_attachment_file_name :foto, :matches => [/png\Z/, /jpe?g\Z/]
	# Explicitly do not validate
  	do_not_validate_attachment_file_type :foto

	private
		def primeira_letra_maiuscula
			errors.add(:nome,
				"Primeira letra deve ser maiuscula") unless nome =~ /[A-Z].*/
		end
end
 