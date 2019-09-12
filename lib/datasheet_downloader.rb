class DatasheetDownloader
  def self.start
    new(Material.with_manufacturer).start
  end

  def initialize(materials)
    @materials = materials
  end

  def start
    materials.each(&method(:process_material))
  end

  private

  attr_reader :materials

  def process_material(material)
    return if material.datasheet.exist? || material.link.nil?
    puts "Processing: #{material.name} #{material.manufacturer_name}"
    response = RestClient.get(material.link)
    content = response.headers[:content_type]

    if !content.include?("application/pdf") && !(content.include?("application/octet-stream") && response.body.include?("/PDF/Text"))
      puts "Incorrect content type #{content}"
      return
    end

    save_file(material, response)
  rescue RestClient::Exception => e
    puts "Failed downloading: #{material.name} #{material.manufacturer_name} #{e.http_code}"
  rescue => e
    puts "Failed downloading: #{material.name} #{material.manufacturer_name} #{e.message}"
  end

  def save_file(material, response)
    path = material.datasheet.file_path
    dirname = File.dirname(path)
    unless File.directory?(dirname)
      FileUtils.mkdir_p(dirname)
    end
    File.open(path, "wb") do |file|
      file.write(response.body)
    end
    puts "Downloaded: #{material.name} #{material.manufacturer_name}"
  end
end
