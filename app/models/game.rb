class Game < ActiveRecord::Base
  # Quatre caractéristiques de base : nombre, forme, couleur et fond
  NB_CARAC = 4
  # Trois états pour chaque caractéristique :
  # 	un		rectangle	bleu		plein
  # 	deux		oval		rouge		vide
  # 	trois		losange		vert		grisé
  NB_ETAT = 3
  # Le nombre de cartes est le nombre d'état élevé à la puissance du nombre de caractéristiques
  NB_CARTE = NB_ETAT ** NB_CARAC
  # La taille du tapis non-étendu (en nombre de carte) est le nombre d'état fois le nombre de caractéristiques
  TAILLE_TAPIS = NB_ETAT * NB_CARAC
  # La taille d'une extension est le nombre d'état (enfin, empiriquement hein)
  TAILLE_EXT = NB_ETAT
  # Description de toutes les cartes du jeu, de [0, 0, 0, 0] à [2, 2, 2, 2], soit 81 cartes.
  CARDS = (0..(NB_CARTE-1)).to_a.map{|i|(0..(NB_CARAC-1)).to_a.reverse.map{|p|i/NB_ETAT**p%NB_ETAT}}

  serialize :talon
  serialize :tapis
  attr_accessor_with_default :selected_cards, []

  def initialize(params = nil)
    super
    # talon est un tableau d'index sur CARDS
    self.talon ||= (0..(NB_CARTE-1)).to_a.sort_by{rand}
    # etendu indique si le jeu a du être étendu par manque de sets
    self.etendu ||= 0
    # courante est l'index de la prochaine carte à piocher dans talon pour tapis
    self.courante ||= TAILLE_TAPIS + TAILLE_EXT*self.etendu
    # tapis est un tableau d'index sur talon
    self.tapis ||= (0..(self.courante-1)).to_a
    extend_if_needed
  end

  def extend_if_needed
    while self.courante < NB_CARTE and self.get_sets.size == 0
      self.etendu += 1
      TAILLE_EXT.times do
        self.tapis << self.courante
        self.courante += 1
      end
    end
  end

  # cards est un tableau d'index sur tapis
  def try_set(cards)
    if is_a_set?(cards.map{|c|self.talon[self.tapis[c]]})
      if self.etendu == 0 and self.courante < NB_CARTE
        cards.each do |card|
          self.tapis[card] = self.courante
          self.courante += 1
        end
      else
        self.tapis -= cards.map{|card|self.tapis[card]}
        self.etendu -= 1
      end
      extend_if_needed
      true
    else
      false
    end
  end

  # renvoi un tableau de tableaux d'index sur tapis constituant des sets
  def get_sets
    result = []
    (0..(TAILLE_TAPIS + TAILLE_EXT*self.etendu - 3)).each do |a|
      ((a + 1)..(TAILLE_TAPIS + TAILLE_EXT*self.etendu - 2)).each do |b|
        ((b + 1)..(TAILLE_TAPIS + TAILLE_EXT*self.etendu - 1)).each do |c|
          if is_a_set?([self.talon[self.tapis[a]], self.talon[self.tapis[b]], self.talon[self.tapis[c]]])
            result << [a, b, c]
          end
        end
      end
    end
    result
  end

  # cards est un tableau d'index sur CARDS
  def is_a_set?(cards)
    (0..(NB_CARAC-1)).inject(true) do |result, carac|
      nb_uniq = cards.map{|card|CARDS[card][carac]}.uniq.size
      result &&= nb_uniq == 1 || nb_uniq == NB_ETAT
    end
  end
end
