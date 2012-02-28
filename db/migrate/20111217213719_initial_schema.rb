class InitialSchema < ActiveRecord::Migration

  def change
    create_table      :object_mappings do |t|
      t.integer       :child_id
      t.string        :child_type
      t.integer       :parent_id
      t.string        :parent_type
      t.integer       :task_run_id
      t.timestamps
    end

    create_table      :task_runs do |t|
      t.string        :name
      t.integer       :task_object_id
      t.string        :task_object_type
      t.text          :task_options_hash
      t.text          :task_result_hash
      t.integer       :object_mapping_id
      t.integer       :organization_id
      t.integer       :physical_location_id
      t.integer       :user_id
      t.integer       :domain_id
      t.integer       :host_id
      t.integer       :net_svc_id
      t.integer       :web_app_id
      t.integer       :web_form_id
      t.integer       :image_id
      t.timestamps
    end

    create_table      :organizations do |t|
      t.integer       :metric
      t.string        :name
      t.text          :description
      t.timestamps
    end

    create_table      :physical_locations do |t|
      t.integer       :metric
      t.string        :name
      t.string        :address
      t.string        :city
      t.string        :state
      t.string        :country
      t.string        :zip
      t.string        :latitude
      t.string        :longitude
      t.integer       :organization_id
      t.integer       :user_id
      t.integer       :host_id
      t.integer       :image_id
      t.timestamps
    end

    create_table      :users do |t|
      t.integer       :metric
      t.string        :username
      t.string        :first_name
      t.string        :last_name
      t.string        :email_address
      t.integer       :organization_id
      t.timestamps
    end

    create_table      :domains do |t|
      t.integer       :metric
      t.string        :name
      t.string        :status
      t.integer       :organization_id
      t.integer       :host_id
      t.timestamps
    end

    create_table :net_blocks do |t|
      t.integer :domain_id
      t.string :range
      t.string :description
      t.timestamps
    end

    create_table      :hosts do |t|
      t.integer       :metric
      t.string        :ip_address
      t.integer       :domain_id
      t.timestamps
    end

    create_table      :search_strings do |t|
      t.integer       :metric
      t.string        :name
      t.string        :description
      t.timestamps
    end

    create_table :net_svcs do |t|
      t.string        :name
      t.integer       :metric
      t.integer       :host_id
      t.string        :fingerprint
      t.string        :proto
      t.integer       :port_num
      t.timestamps
    end

    create_table :web_apps do |t|
      t.integer       :metric
      t.integer       :net_svc_id
      t.string        :name
      t.string        :url
      t.string        :fingerprint
      t.text          :description
      t.string        :techology
      t.timestamps
    end

    create_table :web_forms do |t|
      t.integer       :metric
      t.integer       :web_app_id
      t.string        :name
      t.string        :url
      t.string        :action
      t.text          :fields
      t.timestamps
    end

    create_table :findings do |t|
      t.string        :name
      t.string        :content
      t.timestamps
    end

    create_table :images do |t|
      t.string        :local_path
      t.string        :remote_path
      t.string        :description
      t.timestamps
    end

  end
end
