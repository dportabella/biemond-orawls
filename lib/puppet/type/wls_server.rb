require 'easy_type'
require 'utils/wls_access'
require 'utils/settings'
require 'facter'

module Puppet
  #
  newtype(:wls_server) do
    include EasyType
    include Utils::WlsAccess

    desc "This resource allows you to manage server in an WebLogic domain."

    ensurable

    set_command(:wlst)
  
    to_get_raw_resources do
      wlst template('providers/wls_server/index.py', binding)
    end

    on_create do
      Puppet.info "create #{name} "
      template('providers/wls_server/create.py', binding)
    end

    on_modify do
      Puppet.info "modify #{name} "
      template('providers/wls_server/modify.py', binding)
    end

    on_destroy do
      Puppet.info "destroy #{name} "
      template('providers/wls_server/destroy.py', binding)
    end

    parameter :name
    property  :ssllistenport
    property  :sslenabled
    property  :listenaddress
    property  :listenport
    property  :machine
    property  :arguments
    property  :logfilename
    property  :sslhostnameverificationignored

  private 

    def listenaddress
      self[:listenaddress]
    end

    def listenport
      self[:listenport]
    end

    def ssllistenport
      self[:ssllistenport]
    end

    def sslenabled
      self[:sslenabled]
    end

    def machine
      self[:machine]
    end

    def arguments
      self[:arguments]
    end

    def logfilename
      self[:logfilename]
    end

    def sslhostnameverificationignored
      self[:sslhostnameverificationignored]
    end

  end
end
