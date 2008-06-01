class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.integer   :game_id          # Partie du joueur
      t.string    :name             # Nom du joueur
      t.datetime  :last_set         # Date du dernier set réussi
      t.integer   :nb_set           # Nombre de sets réalisés
      t.integer   :nb_bad_set       # Nombre de tentatives de set ratées
      t.integer   :nb_point         # Nombre de points cumulés
      t.integer   :nb_last_point    # Nombre de points du dernier set
      t.float     :time_last_set    # Temps pour trouver le dernier set
      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
