#
# Copyright:: Copyright (c) 2014 Chef Software, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef'
require 'omniauth'

module OmniAuth
  module Strategies
    class Chef
      include OmniAuth::Strategy

      option :endpoint,     'https://api.opscode.piab'
      option :fields,       [:name, :password]
      option :headers,      { }
      option :organization, nil
      option :resource,     'authenticate_user'
      option :source,       'web'
      option :superuser,    'pivotal'
      option :key_path,     '../../../../config/webui_priv.pem'
      option :uid,          :name

      def callback_phase
        @user = authenticated_user

        authenticated? ? super : fail!(:invalid_credentials)
      end

      uid do
        @user['username']
      end

      info do
        {
          email:      @user['email'],
          first_name: @user['first_name'],
          last_name:  @user['last_name'],
          name:       @user['display_name']
        }
      end

      extra do
        { raw_info: @user }
      end

      protected

      def authenticated_user
        begin
          chef.post_rest(resource, username: username, password: password)['user']
        rescue Net::HTTPServerException

        end
      end

      def authenticated?
        @user ? true : false
      end

      def chef
        ::Chef::REST.new endpoint, options.superuser, nil, parameters
      end

      def endpoint
        organization ? "#{options.endpoint}/#{organization}" : options.endpoint
      end

      def headers
        options.headers.merge({ 'x-ops-request-source' => options.source })
      end

      def key
        IO.read(File.expand_path(options.key_path, __FILE__)).strip
      end

      def organization
        options.organization
      end

      def parameters
        { headers: headers, raw_key: key }
      end

      def password
        options.password ? options.password : request[:password]
      end

      def resource
        options.resource
      end

      def username
        options.username ? options.username : request[:username]
      end
    end
  end
end
