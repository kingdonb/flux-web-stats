#!/usr/bin/env ruby
require 'bundler'
Bundler.require

#require 'k8s-ruby'

client = K8s::Client.config(
  K8s::Config.load_file(
    File.expand_path '~/.kube/config'
  )
)

binding.pry

crd = KubeDSL.custom_resource_definition do
  metadata do
    # name must match the spec fields below, and be in the form: <plural>.<group>
    name 'dailies.fluxwebstats.fluxcd.io'
  end
  spec do
    # group name to use for REST API: /apis/<group>/<version>
    group 'fluxwebstats.fluxcd.io'
    # list of versions supported by this CustomResourceDefinition
    version(:v1alpha1) do 
      name 'v1alpha1'
      # Each version can be enabled/disabled by Served flag.
      served 'true'
      # One and only one version must be marked as the storage version.
      storage true
      schema do
        open_apiv3_schema do
          type 'object'
          properties do
            add :spec, '{"type": "object",
"properties": {
  "cronSpec"}'
#              properties do
#                cronSpec do
#                  type 'string'
#                end
#                image do
#                  type 'string'
#                end
#                replicas do
#                  type 'integer'
#                end
#              end
#            end
          end
        end
      end
    end
    # either Namespaced or Cluster
    scope 'Namespaced'
    names do
      # plural name to be used in the URL: /apis/<group>/<version>/<plural>
      plural 'dailies'
      # singular name to be used as an alias on the CLI and for display
      singular 'daily'
      # kind is normally the CamelCased singular type. Your resource manifests use this.
      kind 'Daily'
      # shortNames allow shorter string to match your resource on the CLI
      short_names ['day']
    end
  end
end

binding.pry
