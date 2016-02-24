/* your-web-expert : 2.0.0 : Wed Feb 24 2016 16:36:12 GMT+0800 (CST) */(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
"use strict";
var offlineFundamentals, version;

console.info("WORKER: executing.");

version = "v1::";

offlineFundamentals = ["", "styles/main.min.css", "scripts/main.min.js", "images/icon.png", "images/darryl-snow.jpg", "images/darryl-snow.webp", "images/fullweb-logo.svg"];

self.addEventListener("install", function(event) {
  console.info("WORKER: install event in progress.");
  return event.waitUntil(caches.open(version + "fundamentals").then(function(cache) {
    return cache.addAll(offlineFundamentals);
  })).then(function() {
    return console.info("WORKER: install completed");
  });
});

self.addEventListener("fetch", function(event) {
  var req, returnUrl, supportsWebp;
  console.info("WORKER: fetch event in progress.");
  if (event.request.method !== "GET") {
    console.info("WORKER: fetch event ignored.", event.request.method, event.request.url);
  }
  if (/\.jpg$|.png$/.test(event.request.url)) {
    supportsWebp = false;
    if (event.request.headers.has("accept")) {
      supportsWebp = event.request.headers.get("accept").includes("webp");
    }
    console.log(supportsWebp);
    if (supportsWebp) {
      req = event.request.clone();
      returnUrl = req.url.substr(0, req.url.lastIndexOf(".")) + ".webp";
      event.respondWith(fetch(returnUrl, {
        mode: "no-cors"
      }));
    }
  }
  return event.respondWith(caches.match(event.request).then(function(cached) {
    var fetchedFromNetwork, networked, unableToResolve;
    networked = fetch(event.request).then(fetchedFromNetwork, unableToResolve)["catch"](unableToResolve);
    fetchedFromNetwork = function(response) {
      var cacheCopy;
      cacheCopy = response.clone();
      console.info("WORKER: fetch response from network.", event.request.url);
      caches.open(version + "pages").then(function(cache) {
        return cache.put(event.request, cacheCopy);
      }).then(function() {
        return console.info("WORKER: fetch response stored in cache.", event.request.url);
      });
      return response;
    };
    unableToResolve = function() {
      console.info("WORKER: fetch request failed in both cache and network.");
      return new Response("<h1>Service Unavailable</h1>", {
        status: 503,
        statusText: "Service Unavailable",
        headers: new Headers({
          "Content-Type": "text/html"
        })
      });
    };
    if (cached) {
      return console.info("WORKER: fetch event (cached)", event.request.url);
    } else {
      return console.info("WORKER: fetch event (networked)", event.request.url);
    }
  }));
});

self.addEventListener("activate", function(event) {
  console.info("WORKER: activate event in progress.");
  return event.waitUntil(caches.keys().then(function(keys) {
    return Promise.all(keys.filter(function(key) {
      return !key.startsWith(version);
    })).map(function(key) {
      return caches["delete"](key);
    });
  })).then(function() {
    return console.info("WORKER: activate completed.");
  });
});


},{}]},{},[1])
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbIm5vZGVfbW9kdWxlcy9icm93c2VyLXBhY2svX3ByZWx1ZGUuanMiLCIvVXNlcnMvZGFycnlsL0RvY3VtZW50cy9naXQveW91cndlYi5leHBlcnQvY2xpZW50L3NyYy9jb2ZmZWVzY3JpcHQvc2VydmljZS13b3JrZXIuY29mZmVlIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBQUFBO0FDQUE7QUFBQSxJQUFBOztBQUNBLE9BQU8sQ0FBQyxJQUFSLENBQWEsb0JBQWI7O0FBRUEsT0FBQSxHQUFVOztBQUVWLG1CQUFBLEdBQXNCLENBQ3JCLEVBRHFCLEVBRXJCLHFCQUZxQixFQUdyQixxQkFIcUIsRUFJckIsaUJBSnFCLEVBS3JCLHdCQUxxQixFQU1yQix5QkFOcUIsRUFPckIseUJBUHFCOztBQVV0QixJQUFJLENBQUMsZ0JBQUwsQ0FBc0IsU0FBdEIsRUFBaUMsU0FBQyxLQUFEO0VBRWhDLE9BQU8sQ0FBQyxJQUFSLENBQWEsb0NBQWI7U0FFQSxLQUFLLENBQUMsU0FBTixDQUFnQixNQUFNLENBQUMsSUFBUCxDQUFZLE9BQUEsR0FBVSxjQUF0QixDQUFxQyxDQUFDLElBQXRDLENBQTJDLFNBQUMsS0FBRDtXQUUxRCxLQUFLLENBQUMsTUFBTixDQUFhLG1CQUFiO0VBRjBELENBQTNDLENBQWhCLENBSUEsQ0FBQyxJQUpELENBSU0sU0FBQTtXQUVMLE9BQU8sQ0FBQyxJQUFSLENBQWEsMkJBQWI7RUFGSyxDQUpOO0FBSmdDLENBQWpDOztBQVlBLElBQUksQ0FBQyxnQkFBTCxDQUFzQixPQUF0QixFQUErQixTQUFDLEtBQUQ7QUFFOUIsTUFBQTtFQUFBLE9BQU8sQ0FBQyxJQUFSLENBQWEsa0NBQWI7RUFFQSxJQUFHLEtBQUssQ0FBQyxPQUFPLENBQUMsTUFBZCxLQUEwQixLQUE3QjtJQUVDLE9BQU8sQ0FBQyxJQUFSLENBQWEsOEJBQWIsRUFBNkMsS0FBSyxDQUFDLE9BQU8sQ0FBQyxNQUEzRCxFQUFtRSxLQUFLLENBQUMsT0FBTyxDQUFDLEdBQWpGLEVBRkQ7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LENBSUEsQ0FBQyxHQUpELENBSUssU0FBQyxHQUFEO2FBRUosTUFBTSxDQUFDLFFBQUQsQ0FBTixDQUFjLEdBQWQ7SUFGSSxDQUpMO0VBRmtDLENBQW5CLENBQWhCLENBVUEsQ0FBQyxJQVZELENBVU0sU0FBQTtXQUVMLE9BQU8sQ0FBQyxJQUFSLENBQWEsNkJBQWI7RUFGSyxDQVZOO0FBSmlDLENBQWxDIiwiZmlsZSI6ImdlbmVyYXRlZC5qcyIsInNvdXJjZVJvb3QiOiIiLCJzb3VyY2VzQ29udGVudCI6WyIoZnVuY3Rpb24gZSh0LG4scil7ZnVuY3Rpb24gcyhvLHUpe2lmKCFuW29dKXtpZighdFtvXSl7dmFyIGE9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtpZighdSYmYSlyZXR1cm4gYShvLCEwKTtpZihpKXJldHVybiBpKG8sITApO3ZhciBmPW5ldyBFcnJvcihcIkNhbm5vdCBmaW5kIG1vZHVsZSAnXCIrbytcIidcIik7dGhyb3cgZi5jb2RlPVwiTU9EVUxFX05PVF9GT1VORFwiLGZ9dmFyIGw9bltvXT17ZXhwb3J0czp7fX07dFtvXVswXS5jYWxsKGwuZXhwb3J0cyxmdW5jdGlvbihlKXt2YXIgbj10W29dWzFdW2VdO3JldHVybiBzKG4/bjplKX0sbCxsLmV4cG9ydHMsZSx0LG4scil9cmV0dXJuIG5bb10uZXhwb3J0c312YXIgaT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2Zvcih2YXIgbz0wO288ci5sZW5ndGg7bysrKXMocltvXSk7cmV0dXJuIHN9KSIsIlwidXNlIHN0cmljdFwiXG5jb25zb2xlLmluZm8gXCJXT1JLRVI6IGV4ZWN1dGluZy5cIlxuXG52ZXJzaW9uID0gXCJ2MTo6XCJcblxub2ZmbGluZUZ1bmRhbWVudGFscyA9IFtcblx0XCJcIlxuXHRcInN0eWxlcy9tYWluLm1pbi5jc3NcIlxuXHRcInNjcmlwdHMvbWFpbi5taW4uanNcIlxuXHRcImltYWdlcy9pY29uLnBuZ1wiXG5cdFwiaW1hZ2VzL2RhcnJ5bC1zbm93LmpwZ1wiXG5cdFwiaW1hZ2VzL2RhcnJ5bC1zbm93LndlYnBcIlxuXHRcImltYWdlcy9mdWxsd2ViLWxvZ28uc3ZnXCJcbl1cblxuc2VsZi5hZGRFdmVudExpc3RlbmVyIFwiaW5zdGFsbFwiLCAoZXZlbnQpIC0+XG5cblx0Y29uc29sZS5pbmZvIFwiV09SS0VSOiBpbnN0YWxsIGV2ZW50IGluIHByb2dyZXNzLlwiXG5cblx0ZXZlbnQud2FpdFVudGlsIGNhY2hlcy5vcGVuKHZlcnNpb24gKyBcImZ1bmRhbWVudGFsc1wiKS50aGVuIChjYWNoZSkgLT5cblxuXHRcdGNhY2hlLmFkZEFsbCBvZmZsaW5lRnVuZGFtZW50YWxzXG5cblx0LnRoZW4gLT5cblxuXHRcdGNvbnNvbGUuaW5mbyBcIldPUktFUjogaW5zdGFsbCBjb21wbGV0ZWRcIlxuXG5zZWxmLmFkZEV2ZW50TGlzdGVuZXIgXCJmZXRjaFwiLCAoZXZlbnQpIC0+XG5cblx0Y29uc29sZS5pbmZvIFwiV09SS0VSOiBmZXRjaCBldmVudCBpbiBwcm9ncmVzcy5cIlxuXG5cdGlmIGV2ZW50LnJlcXVlc3QubWV0aG9kIGlzbnQgXCJHRVRcIlxuXG5cdFx0Y29uc29sZS5pbmZvIFwiV09SS0VSOiBmZXRjaCBldmVudCBpZ25vcmVkLlwiLCBldmVudC5yZXF1ZXN0Lm1ldGhvZCwgZXZlbnQucmVxdWVzdC51cmxcblxuXHRpZiAvXFwuanBnJHwucG5nJC8udGVzdCBldmVudC5yZXF1ZXN0LnVybFxuXG5cdFx0c3VwcG9ydHNXZWJwID0gZmFsc2VcblxuXHRcdGlmIGV2ZW50LnJlcXVlc3QuaGVhZGVycy5oYXMgXCJhY2NlcHRcIlxuXG5cdFx0XHRzdXBwb3J0c1dlYnAgPSBldmVudC5yZXF1ZXN0LmhlYWRlcnMuZ2V0KFwiYWNjZXB0XCIpLmluY2x1ZGVzIFwid2VicFwiXG5cblx0XHRjb25zb2xlLmxvZyBzdXBwb3J0c1dlYnBcblxuXHRcdGlmIHN1cHBvcnRzV2VicFxuXG5cdFx0XHRyZXEgPSBldmVudC5yZXF1ZXN0LmNsb25lKClcblxuXHRcdFx0cmV0dXJuVXJsID0gcmVxLnVybC5zdWJzdHIoMCwgcmVxLnVybC5sYXN0SW5kZXhPZihcIi5cIikpICsgXCIud2VicFwiXG5cblx0XHRcdGV2ZW50LnJlc3BvbmRXaXRoIGZldGNoIHJldHVyblVybCxcblx0XHRcdFx0bW9kZTogXCJuby1jb3JzXCJcblxuXHRldmVudC5yZXNwb25kV2l0aCBjYWNoZXMubWF0Y2goZXZlbnQucmVxdWVzdCkudGhlbiAoY2FjaGVkKSAtPlxuXG5cdFx0bmV0d29ya2VkID0gZmV0Y2goZXZlbnQucmVxdWVzdCkudGhlbihmZXRjaGVkRnJvbU5ldHdvcmssIHVuYWJsZVRvUmVzb2x2ZSkuY2F0Y2godW5hYmxlVG9SZXNvbHZlKVxuXG5cdFx0ZmV0Y2hlZEZyb21OZXR3b3JrID0gKHJlc3BvbnNlKSAtPlxuXG5cdFx0XHRjYWNoZUNvcHkgPSByZXNwb25zZS5jbG9uZSgpXG5cblx0XHRcdGNvbnNvbGUuaW5mbyBcIldPUktFUjogZmV0Y2ggcmVzcG9uc2UgZnJvbSBuZXR3b3JrLlwiLCBldmVudC5yZXF1ZXN0LnVybFxuXG5cdFx0XHRjYWNoZXMub3Blbih2ZXJzaW9uICsgXCJwYWdlc1wiKS50aGVuIChjYWNoZSkgLT5cblxuXHRcdFx0XHRjYWNoZS5wdXQgZXZlbnQucmVxdWVzdCwgY2FjaGVDb3B5XG5cblx0XHRcdC50aGVuIC0+XG5cblx0XHRcdFx0Y29uc29sZS5pbmZvIFwiV09SS0VSOiBmZXRjaCByZXNwb25zZSBzdG9yZWQgaW4gY2FjaGUuXCIsIGV2ZW50LnJlcXVlc3QudXJsXG5cblx0XHRcdHJlc3BvbnNlXG5cblx0XHR1bmFibGVUb1Jlc29sdmUgPSAtPlxuXG5cdFx0XHRjb25zb2xlLmluZm8gXCJXT1JLRVI6IGZldGNoIHJlcXVlc3QgZmFpbGVkIGluIGJvdGggY2FjaGUgYW5kIG5ldHdvcmsuXCJcblxuXHRcdFx0bmV3IFJlc3BvbnNlKFwiPGgxPlNlcnZpY2UgVW5hdmFpbGFibGU8L2gxPlwiLFxuXHRcdFx0XHRzdGF0dXM6IDUwM1xuXHRcdFx0XHRzdGF0dXNUZXh0OiBcIlNlcnZpY2UgVW5hdmFpbGFibGVcIlxuXHRcdFx0XHRoZWFkZXJzOiBuZXcgSGVhZGVycyBcIkNvbnRlbnQtVHlwZVwiOiBcInRleHQvaHRtbFwiKVxuXG5cdFx0aWYgY2FjaGVkXG5cblx0XHRcdGNvbnNvbGUuaW5mbyBcIldPUktFUjogZmV0Y2ggZXZlbnQgKGNhY2hlZClcIiwgZXZlbnQucmVxdWVzdC51cmxcblxuXHRcdGVsc2VcblxuXHRcdFx0Y29uc29sZS5pbmZvIFwiV09SS0VSOiBmZXRjaCBldmVudCAobmV0d29ya2VkKVwiLCBldmVudC5yZXF1ZXN0LnVybFxuXG5zZWxmLmFkZEV2ZW50TGlzdGVuZXIgXCJhY3RpdmF0ZVwiLCAoZXZlbnQpIC0+XG5cblx0Y29uc29sZS5pbmZvIFwiV09SS0VSOiBhY3RpdmF0ZSBldmVudCBpbiBwcm9ncmVzcy5cIlxuXG5cdGV2ZW50LndhaXRVbnRpbCBjYWNoZXMua2V5cygpLnRoZW4gKGtleXMpIC0+XG5cblx0XHRQcm9taXNlLmFsbCBrZXlzLmZpbHRlciAoa2V5KSAtPlxuXG5cdFx0XHQha2V5LnN0YXJ0c1dpdGgodmVyc2lvbilcblxuXHRcdC5tYXAgKGtleSkgLT5cblxuXHRcdFx0Y2FjaGVzLmRlbGV0ZSBrZXlcblxuXHQudGhlbiAtPlxuXG5cdFx0Y29uc29sZS5pbmZvIFwiV09SS0VSOiBhY3RpdmF0ZSBjb21wbGV0ZWQuXCIiXX0=

//# sourceMappingURL=service-worker.js.map
