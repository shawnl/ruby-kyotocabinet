#! /usr/bin/ruby

system("rm -rf doc")

File::open("kyotocabinet-doc.rb") { |ifile|
  File::open("kyotocabinet.rb", "w") { |ofile|
    ifile.each { |line|
      line = line.chomp
      line = line.sub(/# +@param +(\w+) +/, '# - <b>@param <i>\\1</i></b> ')
      line = line.sub(/# +@(\w+) +/, '# - <b>@\\1</b> ')
      ofile.printf("%s\n", line)
    }
  }
}

system('rdoc --title "Kyoto Cabinet" --main kyotocabinet.rb -o doc kyotocabinet.rb')

IO::popen("find doc") { |list|
  list.each { |path|
    path = path.chomp
    if path =~ /\.html$/
      File::open(path) { |ifile|
        tmppath = path + ".tmp"
        File::open(tmppath, "w") { |ofile|
          ifile.each { |line|
            line = line.chomp
            next if line =~ /\[Validate\]<\/a>/
            ofile.printf("%s\n", line)
          }
        }
        File::unlink(path)
        File::rename(tmppath, path)
      }
    end
  }
}

File::open("doc/rdoc.css", "a") { |file|
  file.printf("\n")
  file.printf("pre { background: none #ddddee; border: solid 1px #dddddd; }\n")
  file.printf(".method-description ul { margin: 0ex 0ex 1ex 2ex; padding: 0ex; }\n")
  file.printf(".method-description ul li { list-style-type: none; }\n")
}

system("rm -f kyotocabinet.rb")
