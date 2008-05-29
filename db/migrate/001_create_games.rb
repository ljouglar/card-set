class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.text	:talon		# Toutes les cartes du jeu, mélangées
      t.text	:tapis		# Les cartes présentes sur le tapis
      t.integer	:courante 	# L'index de la prochaine carte à tirer du talon
      t.integer	:etendu 	# Le tapis est-il étendu (+3 cartes) voire super-étendu (+6 cartes)
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
