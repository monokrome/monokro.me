/*
marionette-appliances 0.2.0
License: MIT
*/

(function() {
  var ApplianceManager,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  ApplianceManager = (function(_super) {
    __extends(ApplianceManager, _super);

    function ApplianceManager() {
      ApplianceManager.__super__.constructor.apply(this, arguments);
      this.on('initialize:before', this.initializeAppliances);
    }

    ApplianceManager.prototype.require = function(module) {
      var err, result;
      try {
        result = require(module);
        return result;
      } catch (_error) {
        err = _error;
        return false;
      }
    };

    ApplianceManager.prototype.initializeAppliances = function() {
      var Controller, Router, appliance, appliances, controller, _i, _len;
      this.trigger('appliances:initialized:before');
      appliances = this.appliances;
      this.appliances = {};
      for (_i = 0, _len = appliances.length; _i < _len; _i++) {
        appliance = appliances[_i];
        this.appliances[appliance] = {};
        Controller = this.require("" + appliance + "/controller").Controller;
        if (Controller == null) {
          continue;
        }
        controller = new Controller({
          application: this
        });
        this.appliances[appliance].controller = controller;
        Router = this.require("" + appliance + "/router").Router;
        if (Router == null) {
          continue;
        }
        this.appliances[appliance].router = new Router({
          controller: controller
        });
      }
      return this.trigger('appliances:initialized');
    };

    return ApplianceManager;

  })(Backbone.Marionette.Application);

  Backbone.Marionette.ApplianceManager = ApplianceManager;

}).call(this);
