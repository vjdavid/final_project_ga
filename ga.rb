
class GeneticAlgorithm
  def generate(chromosome)
    value = Array.new(chromosome::SIZE) { ['0', '1'].sample }

    chromosome.new(value)
  end

  def select(population)
    population.sample(2)
  end

  def crossover(selection, index, chromosome)
    cr1 = selection[0][0...index] + selection[1][index..-1]
    cr2 = selection[1][0...index] + selection[0][index..-1]

    [chromosome.new(cr1), chromosome.new(cr2)]
  end

  def run(chromosome, p_cross, p_mutation, iterations = 100)
    # poblacion inicial
    population = 100.times.map { generate(chromosome) }

    current_generation = population
    next_generation    = []

    iterations.times do
      # guardaremos el mejor resultado
      best_fit = current_generation.max_by { |ch| ch.fitness }.dup

      (population.size / 2).times do

        selection = select(current_generation)

        # utilizamos el algoritmo de cruze
        if rand < p_cross
          selection = crossover(selection, rand(0..chromosome::SIZE), chromosome)
        end

        # mutamos la seleccion
        selection[0].mutate(p_mutation)
        selection[1].mutate(p_mutation)

        next_generation << selection[0] << selection[1]
      end

      current_generation = next_generation
      next_generation    = []

      # siempre guardaremos el mejor fit
      current_generation << best_fit
    end

    # imprimiremos la mejor solucion
    best_fit = current_generation.max_by { |ch| ch.fitness }

    "#{best_fit.value} => #{best_fit.fitness}"
  end
end
