require_relative 'ga'
require_relative 'chromosome'

class KnapsackChromosome < Chromosome
  CAPACITY = 20  # peso maximo
  SIZE = 7       # compartimentos de la mochila

  def fitness
    weights = [2, 3, 6, 7, 5, 9, 4]
    values  = [6, 5, 8, 9, 6, 7, 3]

    w = weights
        .map
        .with_index { |w, idx| value[idx].to_i * w }
        .inject(:+)

    v = values
        .map
        .with_index { |v, idx| value[idx].to_i * v }
        .inject(:+)

    w > CAPACITY ? 0 : v
  end
end

ga = GeneticAlgorithm.new
puts ga.run(KnapsackChromosome, 0.2, 0.01, 100)
