Box.Application.addModule('interactions-info', function(context) {
  'use strict';

  var $;

  var module_el;

  function fill_information(med) {
    var $module_el = $(module_el);

    var text = '';
    if (med.interactions && med.interactions_text) {
      text = highlight_keywords(med.interactions, med.interactions_text)
    } else {
      text = 'There is no interaction information for this medicine.'
    }
    $module_el.find('#interactions-text').html(text);
  }

  function highlight_keywords(meds, text) {
    $.each(meds, function(key, med) {
      var reg = new RegExp(med.filter(Boolean).join('|'), 'gi');
      text = text.replace(reg, '<span class="' + key + ' highlight">$&</span>')
    });

    return text;
  }

  function highlight_interactions(element) {
    $('.neon').removeClass('neon');
    $('.' + element + '.highlight').each(function (index, span) {
      $(span).addClass('neon');
    })
  }

  return {
    messages: ['reload_data', 'highlight_interactions'],
    behaviors: ['navigation'],

    init: function() {
      $ = context.getGlobal('jQuery');
      module_el = context.getElement();
    },

    destroy: function() {
      module_el = null;
    },

    onmessage: function (name, data) {
      switch(name) {

        case 'reload_data':
          fill_information(data);
          break;

        case 'highlight_interactions':
          highlight_interactions(data);
          break;
      }
    }
  }
});
