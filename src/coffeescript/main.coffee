# Lovely welcome message
console.log "%c Welcome to YourWeb.Expert ", """
background: #243342;
color: #ffffcb;
font-size: 18px;
font-family: 'Helvetica Neue';
font-weight: 300;
line-height: 30px;
height: 30px;
padding: 5px
"""
console.log "%c darryl@yourweb.expert ", """
background: #243342;
color: #ffffcb;
font-size: 13px;
font-family: 'Helvetica Neue';
font-weight: 300;
line-height: 14px;
height: 30px;
padding: 5px 55px;
"""

ScrollWatcher = require "./components/scroll-watcher/scroll-watcher.coffee"
FullHeightSections = require "./components/full-height-section/full-height-section.coffee"
RateCalculator = require "./components/rate-calculator/rate-calculator.coffee"