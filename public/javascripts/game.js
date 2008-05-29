var NB_CARAC = 4;
var NB_ETAT = 3;

function select_possible_set(game_id, set){
  selected_cards = possible_sets[set];
  new Effect.Highlight($('possible_set_' + set));
  show_selected_cards();
  ((NB_CARAC + etendu) * NB_ETAT).times(function(n){
    $('tapis_card_' + n).bgColor = '#0C781A';
  })
  possible_sets[set].each(function(card){
    $('tapis_card_' + card).bgColor = '#ff9';
  })
  send_set(game_id);
}

function select_tapis_card(game_id, card){
  if(selected_cards.indexOf(card) == -1){
    if(selected_cards.length < NB_ETAT){
      selected_cards[selected_cards.length] = card;
      $('tapis_card_' + card).bgColor = '#ff9';
    }else{
      new Effect.Highlight($('tapis_card_' + card));
    }
  }else{
    selected_cards = selected_cards.without(card);
    $('tapis_card_' + card).bgColor = '#0C781A';
  }
  show_selected_cards();
  if(selected_cards.length == NB_ETAT){
    send_set(game_id);
  }
}

function send_set(game_id){
  var i = 0;
  var param = '?';
  selected_cards.each(function(card){
    if(i > 0){
      param += '&';
    }
    param += 'set[' + i + ']=' + card;
    i ++;
  });
  new Ajax.Request('/game/play/' + game_id + param);
}

function show_selected_cards(){
  (NB_ETAT).times(function(n){
    if(n < selected_cards.length){
      $('selected_card_' + n).className = $('tapis_card_' + selected_cards[n]).className;
    }else{
      $('selected_card_' + n).className = 'card_none';
    }
  });
  $('nb_selected_cards').innerHTML = selected_cards.length;
}
