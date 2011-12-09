substitutions = {
  /bootstrapcss/ => 'css/bootstrap.min.css',
  /prettycss/ => 'css/prettify.css',
  /customcss/ => 'css/custom.css',
  /prettyjs/ => 'javascript/prettify.js',
  /posts-text/ => 'theme/posts/text.html',
  /posts-photo/ => 'theme/posts/photo.html',
  /posts-photoset/ => 'theme/posts/photoset.html',
  /posts-quote/ => 'theme/posts/quote.html',
  /posts-link/ => 'theme/posts/link.html',
  /posts-chat/ => 'theme/posts/chat.html',
  /posts-video/ => 'theme/posts/video.html',
  /posts-audio/ => 'theme/posts/audio.html',
  /pagination/ => 'theme/pagination.html',
  /footer/ => 'theme/footer.html'
}

if ARGV.include?('--bootstrap')
  `cd bootstrap && make build && cp bootstrap.min.css ../css/`
end

File.open("theme/theme.html") do |theme|
  File.open("compiled.html", "w") do |compiled|
    while line = theme.gets
      if substitution = substitutions.keys.select{|k| line =~ k}[0]
        padding = line.match(/^\s*/)[0]
        File.open(substitutions[substitution]) do |sub|
          while sub_line = sub.gets
            compiled.puts "#{padding}#{sub_line}"
          end
        end
      else
        compiled.puts line
      end
    end
  end
end

`cat compiled.html | pbcopy`
