#  require knockout
#
# List of KO plugins found at https://github.com/SteveSanderson/knockout/wiki/Plugins
#
#
#http://knockoutjs.com/documentation/plugins-mapping.html
#  require ./ko.mapping
#
#https://github.com/mbest/knockout-switch-case
#  require ./ko.switch-case
#
#https://github.com/ericmbarnard/Knockout-Validation
#  require ./ko.validation
#   This looks to be only useful for form validation as it applies the error
#   directly to the observable attribute, not the entire object. Entire object
#   validation can be achieved if we weren't performing prototypal inheritance
#   in combination with CoffeeScript. For the time being, object validation
#   still needs to be done explicitly for each model/object.
#
#
#  require_self


# Use data-bind="allowBindings: false" to exclude internal elements in bindings
# Use data-bind="allowBindings: true"  to include internal elements in bindings
#     or exclude "allowBindings"
ko.bindingHandlers.allowBindings =
  init: (elem, valueAccessor)->
    # Let bindings proceed as normal *only if* my value is false
    shouldAllowBindings = ko.utils.unwrapObservable(valueAccessor())
    return { controlsDescendantBindings: !shouldAllowBindings }


ko.extenders.logChange = (target, option)->
  target.subscribe (newValue)->
    console.log("#{option}: ", newValue)
  return target
