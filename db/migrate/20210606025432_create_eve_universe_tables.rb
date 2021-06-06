# Creates tables for EVE SDE/ESI universe data.
class CreateEVEUniverseTables < ActiveRecord::Migration[6.1]
  def change
    create_table :eve_ancestries do |t|
      t.integer :bloodline_id
      t.integer :charisma
      t.text :description
      t.integer :intelligence
      t.integer :memory
      t.text :name
      t.integer :perception
      t.text :short_description
      t.integer :willpower
      t.timestamps null: false

      t.index :bloodline_id
    end

    create_table :eve_asteroid_belts, id: :uuid do |t|
      t.integer :celestial_index
      t.integer :planet_id
      t.decimal :position_x
      t.decimal :position_y
      t.decimal :position_z
      t.integer :type_id
      t.timestamps null: false

      t.index :planet_id
      t.index :type_id
    end

    create_table :eve_bloodlines do |t|
      t.integer :charisma
      t.integer :corporation_id
      t.text :description
      t.integer :intelligence
      t.integer :memory
      t.text :name
      t.integer :perception
      t.integer :race
      t.integer :willpower
      t.timestamps null: false

      t.index :corporation_id
    end

    create_table :eve_categories do |t|
      t.text :name
      t.boolen :published
      t.timestamps null: false
    end

    create_table :eve_celestial_statistics, id: false do |t|
      t.integer :celestial_id
      t.boolean :fragmented
      t.boolean :locked
      t.decimal :eccentricity
      t.decimal :escape_velocity
      t.decimal :life
      t.decimal :mass_dust
      t.decimal :mass_gas
      t.decimal :orbit_period
      t.decimal :pressure
      t.decimal :radius
      t.decimal :rotation_rate
      t.text :spectral_class
      t.decimal :surface_gravity
      t.decimal :temperature
    end

    create_table :eve_constellations do |t|
      t.decimal :center_x
      t.decimal :center_y
      t.decimal :center_z
      t.decimal :max_x
      t.decimal :max_y
      t.decimal :max_z
      t.text :name, null: false
      t.decimal :min_x
      t.decimal :min_y
      t.decimal :min_z
      t.decimal :radius
      t.integer :region_id
      t.timestamps null: false

      t.index :region_id
    end

    create_table :eve_dogma_attribute_categories do |t|
      t.text :description
      t.text :name
      t.timestamps null: false
    end

    create_table :eve_dogma_attributes do |t|
      t.integer :category_id
      t.integer :charge_recharge_time_id
      t.integer :data_type
      t.decimal :default_value
      t.text :description
      t.text :display_name
      t.boolean :high_is_good
      t.integer :max_attribute_id
      t.text :name
      t.boolean :published
      t.boolean :stackable
      t.text :tooltip_description
      t.text :tooltip_title
      t.integer :unit_id
      t.timestamps null: false

      t.index :category_id
      t.idnex :charge_recharge_time_id
      t.index :unit_id
    end

    create_table :eve_dogma_effects_modifiers, id: false do |t|
      t.integer :dogma_effect_id
      t.text :domain
      t.text :func
      t.integer :modified_attribute_id
      t.integer :modifying_attribute_id
      t.integer :operation_id

      t.index :dogma_effect_id
      t.integer :modified_attribute_id
      t.integer :modifying_attribute_id
      t.integer :operation_id
    end

    create_table :eve_dogma_effects do |t|
      t.boolean :disallow_auto_repeat
      t.integer :discharge_attribute_id
      t.text :description
      t.text :display_name
      t.integer :distribution
      t.integer :duration_attribute_id
      t.text :category_id
      t.boolean :electronic_chance
      t.integer :falloff_attribute_id
      t.text :guid
      t.boolean :is_assistance
      t.boolean :is_offensive
      t.boolean :is_warp_safe
      t.text :name
      t.integer :post_expression
      t.integer :pre_expression
      t.boolean :propulsion_chance
      t.boolean :published
      t.integer :range_attribute_id
      t.boolean :range_chance
      t.integer :resistance_attribute_id
      t.integer :tracking_speed_attribute_id
      t.timestamps null: false

      t.index :category_id
      t.index :discharge_attribute_id
      t.index :duration_attribute_id
      t.index :falloff_attribute_id
      t.index :range_attribute_id
      t.index :resistance_attribute_id
      t.index :tracking_speed_attribute_id
      t.index :unit_id
    end

    create_table :eve_factions do |t|
      t.integer :corporation_id
      t.text :description
      t.integer :militia_corporation_id
      t.text :name
      t.text :short_description
      t.decimal :size_factor
      t.integer :solar_system_id
      t.boolean :unique_name
      t.timestamps null: false

      t.index :corporation_id
      t.index :militia_corporation_id
      t.index :solar_system_id
    end

    create_table :eve_faction_member_races, id: false do |t|
      t.integer :faction_id
      t.integer :race_id

      t.index :faction_id
      t.index :race_id
    end

    create_table :eve_groups do |t|
      t.boolean :anchorable
      t.boolean :anchored
      t.integer :category_id
      t.boolean :fittable_non_singleton
      t.text :name
      t.boolean :published
      t.boolean :use_base_price
      t.timestamps null: false

      t.index :category_id
    end

    create_table :eve_market_groups do |t|
      t.text :description
      t.boolean :has_types
      t.text :name
      t.integer :parent_group_id
      t.timestamps null: false

      t.index :parent_group_id
    end

    create_table :eve_meta_groups do |t|
      t.text :description
      t.text :name
      t.timestamps null: false
    end

    create_table :eve_moons do |t|
      t.integer :celestial_index
      t.integer :height_map, array: true
      t.integer :planet_id
      t.boolean :population
      t.decimal :position_x
      t.decimal :position_y
      t.decimal :position_z
      t.decimal :radius
      t.integer :shader_preset
      t.integer :type_id
      t.timestamps null: false

      t.index :planet_id
      t.index :type_id
    end

    create_table :eve_planets do |t|
      t.integer :celestial_index
      t.integer :height_map, array: true
      t.boolean :population
      t.decimal :position_x
      t.decimal :position_y
      t.decimal :position_z
      t.decimal :radius
      t.integer :shader_preset
      t.integer :solar_system_id
      t.timestamps null: false

      t.index :solar_system_id
    end

    create_table :eve_races do |t|
      t.text :description
      t.text :name
      t.integer :ship_type_id
      t.timestamps null: false

      t.index :ship_type_id
    end

    create_table :eve_race_skills, id: false do |t|
      t.integer :level
      t.integer :race_id
      t.integer :skill_id

      t.index :race_id
      t.index :skill_id
    end

    create_table :eve_regions do |t|
      t.decimal :center_x
      t.decimal :center_y
      t.decimal :center_z
      t.text :description
      t.integer :faction_id
      t.decimal :max_x
      t.decimal :max_y
      t.decimal :max_z
      t.decimal :min_x
      t.decimal :min_y
      t.decimal :min_z
      t.text :name
      t.integer :nebula_id
      t.integer :wormhole_class_id
      t.timestamps null: false

      t.index :faction_id
      t.index :nebula_id
      t.index :wormhole_class_id
    end

    create_table :eve_sde_versions do |t|
      t.text :checksum
      t.timestamps null: false

      t.index :checksum
    end

    create_table :eve_stargates do |t|
      t.integer :destination_id
      t.decimal :position_x
      t.decimal :position_y
      t.decimal :position_z
      t.integer :solar_system_id
      t.integer :type_id
      t.timestamps null: false

      t.index :destination_id
      t.index :solar_system_id
      t.index :type_id
    end

    create_table :eve_stars do |t|
      t.decimal :age
      t.decimal :life
      t.boolean :locked
      t.decimal :luminosity
      t.decimal :radius
      t.integer :solar_system_id
      t.text :spectral_class
      t.decimal :temperature
      t.integer :type_id
      t.timestamps null: false

      t.index :solar_system_id
      t.index :type_id
    end

    create_table :eve_stations do |t|
      t.integer :corporation_id
      t.integer :docking_cost_per_volume
      t.boolean :is_conquerable
      t.integer :max_ship_volume_dockable
      t.text :name
      t.integer :office_rental_cost
      t.integer :operation_id
      t.decimal :position_x
      t.decimal :position_y
      t.decimal :position_z
      t.decimal :reprocessing_efficiency
      t.integer :reprocessing_hangar_flag
      t.decimal :reprocessing_stations_take
      t.decimal :security
      t.integer :solar_system_id
      t.integer :type_id
      t.boolean :use_operation_name
      t.timestamps null: false

      t.index :corporation_id
      t.index :operation_id
      t.index :solar_system_id
      t.index :type_id
    end

    create_table :eve_station_operations do |t|
      t.integer :activity_id
      t.decimal :border
      t.decimal :corridor
      t.text :description
      t.decimal :fringe
      t.decimal :hub
      t.decimal :manufacturing_factor
      t.text :name
      t.decimal :ratio
      t.decimal :research_factor
      t.timestamps null: false

      t.index :activity_id
    end

    create_table :eve_station_operation_services, id: false do |t|
      t.integer :station_operation_id
      t.integer :station_service_id

      t.index :station_operation_id
      t.index :station_service_id
    end

    create_table :eve_station_operation_station_types, id: false do |t|
      t.integer :station_operation_id
      t.integer :station_type_id

      t.index :station_operation_id
      t.index :station_type_id
    end

    create_table :eve_station_services, id: false do |t|
      t.text :name
      t.timestamps null: false
    end

    create_table :eve_structures do |t|
      t.text :name
      t.integer :owner_id
      t.decimal :position_x
      t.decimal :position_y
      t.decimal :position_z
      t.integer :solar_system_id
      t.integer :type_id
      t.timestamps null: false

      t.index :owner_id
      t.index :solar_system_id
      t.index :type_id
    end

    create_table :eve_solar_systems do |t|
      t.boolean :border
      t.decimal :center_x
      t.decimal :center_y
      t.decimal :center_z
      t.integer :constellation_id
      t.boolean :corridor
      t.boolean :fringe
      t.boolean :hub
      t.boolean :international
      t.decimal :luminosity
      t.decimal :max_x
      t.decimal :max_y
      t.decimal :max_z
      t.decimal :min_x
      t.decimal :min_y
      t.decimal :min_z
      t.text :name
      t.decimal :radius
      t.boolean :regional
      t.decimal :security
      t.text :security_class
      t.integer :wormhole_class_id
      t.timestamps null: false

      t.index :constellation_id
      t.index :wormhole_class_id
    end

    create_table :eve_type_dogma_attributes, id: false do |t|
      t.integer :attribute_id
      t.integer :type_id
      t.decimal :value
      t.timestamps null: false

      t.index :attribute_id
      t.index :type_id
    end

    create_table :eve_type_dogma_effects, id: false do |t|
      t.integer :effect_id
      t.boolean :is_default
      t.integer :type_id
      t.timestamps null: false

      t.index :effect_id
      t.index :type_id
    end

    create_table :eve_type_traits, id: false do |t|
      t.decimal :bonus
      t.text :bonus_text
      t.integer :importance
      t.boolean :is_positive
      t.text :trait_type
      t.integer :trait_type_id
      t.integer :type_id
      t.integer :unit_id
      t.timestamps null: false

      t.index :trait_type_id
      t.index :type_id
      t.index :unit_id
    end

    create_table :eve_types do |t|
      t.decimal :base_price
      t.decimal :capacity
      t.text :description
      t.integer :group_id
      t.integer :market_group_id
      t.integer :meta_group_id
      t.decimal :mass
      t.text :name
      t.integer :portion_size
      t.boolean :published
      t.integer :race_id
      t.decimal :radius
      t.integer :variation_parent_type_id
      t.decimal :volume
      t.timestamps null: false

      t.index :group_id
      t.index :market_group_id
      t.index :meta_group_id
      t.index :race_id
      t.index :variation_parent_type_id
    end

    create_table :eve_units do |t|
      t.text :name
      t.timestamps null: false
    end
  end
end
