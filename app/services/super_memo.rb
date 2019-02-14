# Algorithm SM-2 used in the computer-based variant of the SuperMemo method and
# involving the calculation of easiness factors for particular items:
# http://www.supermemo.com/english/ol/sm2.htm

class SuperMemo
  class << self
    def algorithm(interval, repeat, efactor, attempt, distance, distance_limit)
      quality = set_quality(attempt, distance, distance_limit)
      efactor = set_efactor(efactor, quality)
      repeat = quality >= 3 ? repeat + 1 : 1
      sm_hash = set_interval(interval, repeat, efactor)
      sm_hash.merge!(quality: quality)
    end

    def set_interval(interval, repeat, efactor)
      intervals = {1 => 1, 2 => 6}
      intervals.default = (interval * efactor).round
      interval = intervals[repeat]
      { interval: interval, efactor: efactor, repeat: repeat }
    end

    def set_efactor(efactor, quality)
      efactor = efactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))
      efactor < 1.3 ? 1.3 : efactor
    end

    def set_quality(attempt, distance, distance_limit)
      if distance <= distance_limit
        qualities = {1 => 5, 2 => 4}
        qualities.default = 3
      else
        qualities = {1 => 2, 2 => 1}
        qualities.default = 0
      end
      qualities[attempt]
    end
  end
end
