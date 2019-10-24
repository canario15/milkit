# frozen_string_literal: true

namespace :local do
  namespace :db do
    task abort_if_active_connections: ['db:load_config'] do
      config = ActiveRecord::Base.configurations[Rails.env]
      ActiveRecord::Base.establish_connection(
        config.merge('database' => 'postgres', 'schema_search_path' => 'public')
      )

      version = ActiveRecord::Base.connection.send(:postgresql_version)
      pid = if version >= 902_00
              'pid'
            else
              'procpid'
            end

      connections = ActiveRecord::Base.connection.select_all(
        "SELECT #{pid},usename,client_addr,application_name,backend_start
           FROM pg_stat_activity 
          WHERE pg_stat_activity.datname = '#{config['database']}'
            AND #{pid} <> #{$$}"
      )

      unless connections.empty?
        puts
        puts "There are active connections to the database '#{config['database']}':"
        puts
        puts '%-7s %-20s %-16s %-20s %s' % %w[pid usename client_addr application_name backend_start]
        connections.each do |c|
          puts '%-7s %-20s %-16s %-20s %s' % [c[pid], c['usename'], c['client_addr'], c['application_name'], c['backend_start']]
        end
        puts
        exit 1
      end

      ActiveRecord::Base.clear_all_connections!
    end
  end

end
