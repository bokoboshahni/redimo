# frozen_string_literal: true

class CalculateQuote
  # Quote calculation strategy with fixed costs.
  class Simple
    attr_reader :quote

    def initialize(quote)
      @quote = quote
    end

    def call # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      {
        ge_8jv: {
          courier: jita_to_mendori_cost + mendori_to_ge_8jv_cost,
          total: (total_sell * 1.1) + jita_to_mendori_cost + mendori_to_ge_8jv_cost
        },
        mendori: {
          courier: jita_to_mendori_cost,
          total: (total_sell * 1.1) + jita_to_mendori_cost
        },
        moro: {
          courier: jita_to_moro_cost,
          total: (total_sell * 1.1) + jita_to_moro_cost
        },
        p_zmzv: {
          courier: jita_to_amarr_cost + amarr_to_p_zmzv_cost,
          total: (total_sell * 1.1) + jita_to_amarr_cost + amarr_to_p_zmzv_cost
        },
        pzma_e: {
          courier: jita_to_mendori_cost + mendori_to_pzma_e_cost,
          total: (total_sell * 1.1) + jita_to_mendori_cost + mendori_to_pzma_e_cost
        },
        riavayed: {
          courier: jita_to_riavayed_cost,
          total: (total_sell * 1.1) + jita_to_riavayed_cost
        }
      }
    end

    def amarr_to_p_zmzv_cost
      blt_cost(3, 27.857)
    end

    def mendori_to_ge_8jv_cost
      blt_cost(3, 20.903)
    end

    def mendori_to_pzma_e_cost
      blt_cost(4, 32.465)
    end

    def jita_to_amarr_cost
      public_courier_cost(45)
    end

    def jita_to_mendori_cost
      public_courier_cost(41)
    end

    def jita_to_moro_cost
      public_courier_cost(61)
    end

    def jita_to_riavayed_cost
      public_courier_cost(40)
    end

    def public_courier_cost(jumps) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      cost_per_jump = 500_000
      base_rate = cost_per_jump * jumps

      base_collateral_pct = 0.005
      jumps.times { base_collateral_pct += 0.001 }
      base_collateral_pct = [0.01, base_collateral_pct].min

      pickup_fee = total_collateral * base_collateral_pct
      multiplier_per_jump = 1.002
      pickup_reward = pickup_fee * multiplier_per_jump**jumps

      reward = base_rate + pickup_reward
      reward = total_collateral * 0.001 * jumps if (total_collateral * 0.001 * jumps) > reward
      reward = total_collateral * 0.3 if reward >= (total_collateral * 0.5)

      ((reward / 1000) * 1000).round
    end

    def blt_cost(jumps, jump_distance)
      distance_cost = (jump_distance * 8_000_000) + ((jump_distance / 10.0) + 5_000_000)
      cyno_cost = jumps * 5_000_000
      route_cost = distance_cost + cyno_cost
      collateral_ratio = total_collateral / 3_000_000_000
      volume_ratio = total_volume / 320_000

      route_cost * [collateral_ratio, volume_ratio].max
    end

    def total_sell
      [quote.sell, 5_000_000].max
    end

    def total_collateral
      total_sell * 1.1
    end

    def total_volume
      quote.volume
    end
  end
end
