# encoding: utf-8
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

require 'spec_helper'

describe OmniAuth::Strategies::Chef do
  subject do
    OmniAuth::Strategies::Chef.new({})
  end

  context 'options' do
    describe 'option :endpoint' do
      context 'default: https://api.opscode.piab' do
        it do
          expect(subject.options.endpoint).to eq('https://api.opscode.piab')
        end
      end
    end

    describe 'option :fields' do
      context 'default: [:name, :password]' do
        it { expect(subject.options.fields).to eq([:name, :password]) }
      end
    end

    describe 'option :headers' do
      context 'default: { }' do
        it { expect(subject.options.headers).to eq({ }) }
      end
    end

    describe 'option :organization' do
      context 'default: nil' do
        it { expect(subject.options.organization).to eq(nil) }
      end
    end

    describe 'option :resource' do
      context 'default: authenticate_user' do
        it { expect(subject.options.resource).to eq('authenticate_user') }
      end
    end

    describe 'option :source' do
      context 'default: web' do
        it { expect(subject.options.source).to eq('web') }
      end
    end

    describe 'option :superuser' do
      context 'default: pivotal' do
        it { expect(subject.options.superuser).to eq('pivotal') }
      end
    end

    describe 'option :key_path' do
      context 'default: ../../../../config/webui_priv.pem' do
        it do
          default_key_path = '../../../../config/webui_priv.pem'

          expect(subject.options.key_path).to eq(default_key_path)
        end
      end
    end

    describe 'option :key_data' do
      context 'default: nil' do
        it do
          expect(subject.options.key_data).to eq(nil)
        end
      end
    end


    describe 'option :uid' do
      context ':name' do
        it { expect(subject.options.uid).to eq(:name) }
      end
    end
  end
end
