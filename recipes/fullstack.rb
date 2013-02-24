node.override['orch_db']['databases'] = []
node.override['orch_web']['apps'] = []
node.override['orch_app']['apps'] = []

node['orch']['apps'].each do |app|

  db = {
    'name'     => app['name'],
    'user'     => app['user'],
    'password' => app['db_password'],
    'type'     => app['db_type']
  }

  node.override['orch_db']['databases'] << db

  web = {
    'name'      => app['name'],
    'root_path' => app['root_path'],
    'servers'   => app['servers']
  }

  node.override['orch_web']['apps'] << web

  app = {
    'name'         => app['name'],
    'user'         => app['user'],
    'ruby_version' => app['ruby_version'],
    'processes'    => app['processes'],
    'environment'  => app['environment']
  }

  node.override['orch_app']['apps'] << app
end

include_recipe "orch_db"
include_recipe "orch_web"
include_recipe "orch_app"