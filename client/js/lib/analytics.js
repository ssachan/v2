// Created by Kendall Buchanan, (https://github.com/kendagriff)
// Modified by Paul English, (https://github.com/nrub)
// MIT licence
// Version 0.0.2

/*(function() {
  var _loadUrl = Backbone.History.prototype.loadUrl;

  Backbone.History.prototype.loadUrl = function(fragmentOverride) {
    var matched = _loadUrl.apply(this, arguments),
        fragment = this.fragment = this.getFragment(fragmentOverride);

    if (!/^\//.test(fragment)) fragment = '/' + fragment;
    if (window._gaq !== undefined) window._gaq.push(['_trackPageview', fragment]);

    return matched;
  };

}).call(this);
*/

(function ($, App) {
        var instance = null;

        var GoogleAnalyticsWrapper = (function () {
            function GoogleAnalytics() {
                this.init();
            }
            //Static Variable
            GoogleAnalytics.getInstance = function () {
                if (!instance) {
                    instance = new GoogleAnalytics();
                }
                return instance;
            };
            GoogleAnalytics.prototype.init = function() {                
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
            };
            return GoogleAnalytics;
        })();
        App.GA = GoogleAnalyticsWrapper.getInstance();

        return App.GA;
}).call(this);