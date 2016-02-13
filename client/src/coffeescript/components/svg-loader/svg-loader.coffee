'use strict'

do (window) ->
  # class helper functions from bonzo https://github.com/ded/bonzo

  classReg = (className) ->
    new RegExp('(^|\\s+)' + className + '(\\s+|$)')

  toggleClass = (elem, c) ->
    fn = if hasClass(elem, c) then removeClass else addClass
    fn elem, c
    return

  'use strict'
  # classList support for class management
  # altho to be fair, the api sucks because it won't accept multiple classes at once
  hasClass = undefined
  addClass = undefined
  removeClass = undefined
  if 'classList' of document.documentElement

    hasClass = (elem, c) ->
      elem.classList.contains c

    addClass = (elem, c) ->
      elem.classList.add c
      return

    removeClass = (elem, c) ->
      elem.classList.remove c
      return

  else

    hasClass = (elem, c) ->
      classReg(c).test elem.className

    addClass = (elem, c) ->
      if !hasClass(elem, c)
        elem.className = elem.className + ' ' + c
      return

    removeClass = (elem, c) ->
      elem.className = elem.className.replace(classReg(c), ' ')
      return

  classie =
    hasClass: hasClass
    addClass: addClass
    removeClass: removeClass
    toggleClass: toggleClass
    has: hasClass
    add: addClass
    remove: removeClass
    toggle: toggleClass
  # transport
  if typeof define == 'function' and define.amd
    # AMD
    define classie
  else
    # browser global
    window.classie = classie
  return

Snap = require "snapsvg-cjs"

###*
# svgLoader.js v1.0.0
# http://www.codrops.com
#
# Licensed under the MIT license.
# http://www.opensource.org/licenses/mit-license.php
#
# Copyright 2014, Codrops
# http://www.codrops.com
###

do (window) ->

  extend = (a, b) ->
    for key of b
      if b.hasOwnProperty(key)
        a[key] = b[key]
    a

  SVGLoader = (el, options) ->
    @el = el
    @options = extend({}, @options)
    extend @options, options
    @_init()
    return

  SVGLoader::options =
    speedIn: 500
    easingIn: mina.linear

  SVGLoader::_init = ->
    s = Snap(@el.querySelector('svg'))
    @path = s.select('path')
    @initialPath = @path.attr('d')
    openingStepsStr = @el.getAttribute('data-opening')
    @openingSteps = if openingStepsStr then openingStepsStr.split(';') else ''
    @openingStepsTotal = if openingStepsStr then @openingSteps.length else 0
    if @openingStepsTotal == 0
      return
    # if data-closing is not defined then the path will animate to its original shape
    closingStepsStr = if @el.getAttribute('data-closing') then @el.getAttribute('data-closing') else @initialPath
    @closingSteps = if closingStepsStr then closingStepsStr.split(';') else ''
    @closingStepsTotal = if closingStepsStr then @closingSteps.length else 0
    @isAnimating = false
    if !@options.speedOut
      @options.speedOut = @options.speedIn
    if !@options.easingOut
      @options.easingOut = @options.easingIn
    return

  SVGLoader::show = ->
    if @isAnimating
      return false
    @isAnimating = true
    # animate svg
    self = this

    onEndAnimation = ->
      classie.addClass self.el, 'is-loading'
      return

    @_animateSVG 'in', onEndAnimation
    classie.add @el, 'show'
    return

  SVGLoader::hide = ->
    self = this
    classie.removeClass @el, 'is-loading'
    @_animateSVG 'out', ->
      # reset path
      self.path.attr 'd', self.initialPath
      classie.removeClass self.el, 'show'
      self.isAnimating = false
      return
    return

  SVGLoader::_animateSVG = (dir, callback) ->
    self = this
    pos = 0
    steps = if dir == 'out' then @closingSteps else @openingSteps
    stepsTotal = if dir == 'out' then @closingStepsTotal else @openingStepsTotal
    speed = if dir == 'out' then self.options.speedOut else self.options.speedIn
    easing = if dir == 'out' then self.options.easingOut else self.options.easingIn

    nextStep = (pos) ->
      if pos > stepsTotal - 1
        if callback and typeof callback == 'function'
          callback()
        return
      self.path.animate { 'path': steps[pos] }, speed, easing, ->
        nextStep pos
        return
      pos++
      return

    nextStep pos
    return

  # add to global namespace
  window.SVGLoader = SVGLoader
  return