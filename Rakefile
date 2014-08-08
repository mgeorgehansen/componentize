require "bundler/gem_tasks"

def update_file_header(file_path, header)
  license_header_regex = /\A##.*\n(?:#.*\n)+/

  formatted_header = "## #{header.split("\n").join("\n# ")}\n"
  file_content = ::File.read(file_path)
  replaced = false
  if file_content.match(license_header_regex)
    replaced = true
    file_content.gsub!(license_header_regex, formatted_header)
  else
    file_content = "#{formatted_header}\n#{file_content}"
  end
  ::File.open(file_path, 'w') do |file|
    file.write(file_content)
  end

  return replaced
end

namespace :dev do
  task :update_file_headers do
    file_header = ::File.read(::File.join('config', 'file_header.txt'))
    file_header = file_header % {authors: 'M. George Hansen', years: (2014..Time.now.year).to_a.join(', ')}

    ::Dir.glob("{lib,test}/**/*.rb").each do |file_path|
      replaced = update_file_header(file_path, file_header)
      if replaced
        puts "Replaced file header in #{file_path}"
      else
        puts "Added file header to #{file_path}"
      end
    end
  end
end
