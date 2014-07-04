namespace :radiant do
  namespace :extensions do
    namespace :jasmine do
      desc "Runs the migration of the extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          Rake::Task['db:schema:dump'].invoke
        else
          Rake::Task['db:schema:dump'].invoke
        end
      end


      desc "Copies public assets of the extension to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from JasmineExtension"
        Dir[JasmineExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(JasmineExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          puts "file = #{file}"
          cp file, RAILS_ROOT + path, :verbose => false
        end
      end
    end
  end
end
