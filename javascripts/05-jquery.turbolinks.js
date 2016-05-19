(function() {
  var $, $document;

  $ = window.jQuery || (typeof require === "function" ? require('jquery') : void 0);

  $document = $(document);

  $.turbo = {
    version: '2.0.0.rc',
    isReady: false,
    use: function(load, fetch) {
      return $document.off('.turbo').on(load + ".turbo", this.onLoad).on(fetch + ".turbo", this.onFetch);
    },
    addCallback: function(callback) {
      $document.on('turbo:ready', callback);
      if ($.turbo.isReady) {
        return callback($);
      }
    },
    onLoad: function() {
      $.turbo.isReady = true;
      return $document.trigger('turbo:ready');
    },
    onFetch: function() {
      return $.turbo.isReady = false;
    },
    register: function() {
      $(this.onLoad);
      return $.fn.ready = this.addCallback;
    }
  };

  $.turbo.register();

  $.turbo.use('page:load', 'page:fetch');

}).call(this);
