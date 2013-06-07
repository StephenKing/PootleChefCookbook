default['pootle']['db_user'] = 't3o_translation'
default['pootle']['db_name'] = 't3o_pootle'

# you might want to dynamically generate the password instead,
# see https://github.com/TYPO3-cookbooks/etherpad-lite/blob/master/recipes/default.rb#L108
default['pootle']['db_password'] = 'passw0rd'

default['pootle']['server_name'] = 'translation.typo3.org'
default['pootle']['docroot'] = '/var/www/vhosts/pootle.typo3.org/pootle/html/'

default['pootle']['pootle_git'] = 'git://github.com/dfeyer/TranslationTypo3Org.git'

default['pootle']['pootle_root'] = '/var/www/vhosts/pootle.typo3.org/pootle'
default['pootle']['pootle_po_root'] = '/var/lib/pootle/po'
default['pootle']['pootle_homedir'] = '/var/www/vhosts/pootle.typo3.org/home'
default['pootle']['pootle_user'] = 'pootle'
default['pootle']['pootle_group'] = 'pootle'

default['pootle']['pootle_script_git'] = 'git://git.typo3.org/Teams/Translation.git'
default['pootle']['pootle_script_root'] = '/var/www/vhosts/pootle.typo3.org/home/scripts'

default['pootle']['TER_l10n_root'] = '/var/www/vhosts/pootle.typo3.org/l10n_ter'
default['pootle']['TER_l10n_user'] = 'translat3o'
default['pootle']['TER_l10n_group'] = 'translat3o'
default['pootle']['TER_l10n_homedir'] = '/home/translat3o'

default['pootle']['DEFAULT_FROM_EMAIL'] = 'translation-team@typo3.org'
default['pootle']['CONTACT_EMAIL'] = 'translation-team@typo3.org'

# you can use localhost in typo3.org infrastructure
default['pootle']['EMAIL_HOST_USER'] = 'typo3pootle@gmail.com'
default['pootle']['EMAIL_HOST_PASSWORD'] = 'jDZ99ZxgksBYnRNXv'
default['pootle']['EMAIL_HOST'] = 'smtp.gmail.com'
default['pootle']['EMAIL_PORT'] = '587'
default['pootle']['EMAIL_USE_TLS'] = 'True'

default['pootle']['DATABASE_HOST'] = 'localhost'
default['pootle']['DATABASE_PORT'] = '3306'

override['mysql']['package'] = %w{mysql-server}
override['mysql']['client']['packages'] = %w{mysql-client libmysqlclient-dev}
