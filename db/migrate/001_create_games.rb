class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.text      :talon            # Toutes les cartes du jeu, mélangées
      t.text      :tapis            # Les cartes présentes sur le tapis
      t.integer   :courante         # L'index de la prochaine carte à tirer du talon
      t.integer   :etendu           # Le tapis est-il étendu (+3 cartes) voire super-étendu (+6 cartes)
      t.datetime  :start            # Date de début de la partie
      t.datetime  :last_set         # Date du dernier set réussi
      t.integer   :nb_set           # Nombre de sets réalisés
      t.integer   :nb_bad_set       # Nombre de tentatives de set ratées
      t.integer   :nb_point         # Nombre de points cumulés
      t.integer   :nb_last_point    # Nombre de points du dernier set
      t.float     :time_last_set    # Temps pour trouver le dernier set
      t.integer   :game_over        # La partie est-elle terminée
      t.integer   :nb_set_possible  # Nombre de sets possibles
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
