# frozen_string_literal: true

namespace :local do
  namespace :backup do
    # execute-> bundle exec rake local:backup:production
    desc 'Backup production and restore to development'
    task production: ['production:db']

    namespace :production do
      desc 'Backup production database and restore to development'
      task db: ['local:db:abort_if_active_connections', 'db:drop', 'db:create'] do
        config = ActiveRecord::Base.configurations[Rails.env]
        prod_db = ActiveRecord::Base.configurations['production']['database']
        zip_file = "/tmp/#{prod_db}"
        back_up_folder = '~/workspace/backup_databases/'

        puts 'Backing up production database to temporary file on milkitadmin.com'
        system %Q!ssh root@milkitadmin.com "su -l postgres -c 'pg_dump -Ox #{prod_db}' > #{zip_file}"!

        puts 'Copying production database to temporary file on this machine...'
        system "scp -C root@milkitadmin.com:#{zip_file} #{zip_file}"

        puts 'Recreating local database...'
        system "cat #{zip_file} | psql #{config['database']}"
        # system "gunzip -c #{zip_file} | psql #{config['database']}"

        puts 'Copy backup file to backup local folder...'
        system "cp -b #{zip_file} #{back_up_folder}/#{prod_db}_#{Time.now.strftime("%Y-%d-%m_%H-%M")}"

        puts 'Removing temporary file...'
        File.unlink zip_file.to_s

        puts 'Running db:migration...'
        Rake::Task['db:migrate'].execute

        puts "Clearing rails' cache..."
        Rails.cache.clear
      end
    end
  end
end
