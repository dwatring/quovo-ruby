require 'json'
require 'uri'
require 'time'
require 'base64'
require 'forwardable'
require 'net/http'
require 'openssl'

require 'quovo/refinements/require'
require 'quovo/refinements/to_time'
require 'quovo/refinements/cast'
require 'quovo/refinements/compact'
require 'quovo/refinements/permit'
require 'quovo/refinements/sensitive'

require 'quovo/errors'

require 'quovo/scope'
require 'quovo/hook'
require 'quovo/version'
require 'quovo/config'
require 'quovo/request'
require 'quovo/token'
require 'quovo/fake'

require 'quovo/enums/account_type'
require 'quovo/enums/holding_type'
require 'quovo/enums/type_confidence'

require 'quovo/models/base'
require 'quovo/models/access_info'
require 'quovo/models/address'
require 'quovo/models/owner_detail'
require 'quovo/models/auth'
require 'quovo/models/account'
require 'quovo/models/choice'
require 'quovo/models/connection'
require 'quovo/models/holding'
require 'quovo/models/image'
require 'quovo/models/institution'
require 'quovo/models/institution_detail'
require 'quovo/models/challenge'
require 'quovo/models/progress'
require 'quovo/models/sync'
require 'quovo/models/user'
require 'quovo/models/transaction'
require 'quovo/models/webhook'
require 'quovo/models/extra'

require 'quovo/api/base'
require 'quovo/api/accounts'
require 'quovo/api/challenges'
require 'quovo/api/connections'
require 'quovo/api/extras'
require 'quovo/api/holdings'
require 'quovo/api/institutions'
require 'quovo/api/users'
require 'quovo/api/history'
require 'quovo/api/webhooks'
require 'quovo/api'

module Quovo
  extend Quovo::Config.configurator
  extend Quovo::Scope
  extend Quovo::Hook
  extend Quovo::Api
  extend Quovo::Fake

  def self.inspect
    config.inspect
  end

  def self.enable_logging
    Quovo.hook do |path, method, params, status_code, response, elapsed_time, scope|
      if Quovo.config.debug
        log = [
          '',
          'Quovo Action:',
          "path: #{path}",
          "method: #{method}",
          "params: #{params.inspect}",
          "status_code: #{status_code}",
          "response: #{response.inspect}",
          "elapsed_time: #{elapsed_time}s",
          "scope: #{scope.inspect}",
          ''
        ]
        puts log.join("\n    ")
      end
    end
  end

  enable_logging
end
