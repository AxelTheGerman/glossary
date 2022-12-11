require 'csv'
require 'fileutils'
require 'liquid'

glossary = CSV.read("data/glossary.csv", headers: true)

languages = glossary.headers.drop(2).filter { |h| h.length === 2 }

languages.each do |lang|
  FileUtils.mkdir_p("docs/#{lang}")

  glossary.each do |term|
    template = Liquid::Template.parse(File.read("templates/glossary.html"))
    data = {
      "language" => lang,
      "term" => term[lang],
      "definition" => term["#{lang}-def"]
    }
    File.write("docs/#{lang}/#{term["id"]}.html", template.render(data))
  end
end
