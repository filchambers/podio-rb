module Podio
  module Contact
    include Podio::ResponseWrapper
    extend self

    def all(options={})
      options.assert_valid_keys(:key, :value, :limit, :offset, :type, :order, :name, :email, :required, :contact_type)

      list Podio.connection.get { |req|
        req.url("/contact/", options)
      }.body
    end

    def top(options={})
      options.assert_valid_keys(:limit, :type)

      list Podio.connection.get { |req|
        req.url("/contact/top/", options)
      }.body
    end

    def find(profile_id)
      member Podio.connection.get("/contact/#{profile_id}/v2").body
    end

    def find_all_for_org(org_id, options={})
      options.assert_valid_keys(:key, :value, :limit, :offset, :type, :order, :name, :email, :contact_type)
      options[:type] ||= 'full'

      list Podio.connection.get { |req|
        req.url("/contact/org/#{org_id}", options)
      }.body
    end

    def find_all_for_space(space_id, options={})
      options.assert_valid_keys(:key, :value, :limit, :offset, :type, :order, :name, :email, :contact_type, :exclude_self)
      options[:type] ||= 'full'
      options[:exclude_self] = (options[:exclude_self] == false ? "0" : "1" )

      list Podio.connection.get { |req|
        req.url("/contact/space/#{space_id}", options)
      }.body
    end

    def find_all_for_connection(connection_id, options={})
      options.assert_valid_keys(:key, :value, :limit, :offset, :type, :order, :name, :email)
      options[:type] ||= 'full'

      list Podio.connection.get { |req|
        req.url("/contact/connection/#{connection_id}", options)
      }.body      
    end

    def find_all_for_connection_type(connection_type, options={})
      options.assert_valid_keys(:key, :value, :limit, :offset, :type, :order, :name, :email)
      options[:type] ||= 'full'

      list Podio.connection.get { |req|
        req.url("/contact/connection/#{connection_type}", options)
      }.body
    end
    
    def find_for_org(org_id)
      member Podio.connection.get("/org/#{org_id}/profile").body
    end

    def find_for_user(user_id)
      member Podio.connection.get("/contact/user/#{user_id}").body
    end

    
    def totals_by_org
      Podio.connection.get("/contact/totals/").body
    end

    def totals_by_org_and_space
      Podio.connection.get("/contact/totals/v2/").body
    end

    def totals_by_space(space_id)
      Podio.connection.get("/contact/space/#{space_id}/totals/").body
    end

    def create_space_contact(space_id, attributes)
      response = Podio.connection.post do |req|
        req.url "/contact/space/#{space_id}/"
        req.body = attributes
      end

      response.body
    end
    
    def delete_contact(profile_id)
      Podio.connection.delete("/contact/#{profile_id}").body
    end

    def update_contact(profile_id, attributes)
      response = Podio.connection.put do |req|
        req.url "/contact/#{profile_id}"
        req.body = attributes
      end

      response.body
    end
    
  end

end
