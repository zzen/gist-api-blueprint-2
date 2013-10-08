(function(global, $, undefined) {

'use strict';

// Gists API
// =========
//
// REST API for GitHub Gists. Original [here](http://developer.github.com/v3/gists/)
//
// Usage:
//
//     api = GistsAPI( /* baseUrl (optional) */ )
//     $.gist.findAll({since: timestamp})
//     $.gist.add(properties)
//     $.gist(id).find()
//     $.gist(id).update(changedProperties)
//     $.gist(id).remove
//     $.gist(id).star.add()
//     $.gist(id).star.find()
//     $.gist(id).star.remove()
//     $.gist(id).fork.add()

var findAllGists = function(options) {
  return {
    type: 'GET',
    url: '/gists',
    data: options
  }
}
var addGist = function(properties) {
  return {
    type: 'POST',
    url: '/gists',
    data: properties
  }
}
var findGist = function(id) {
  return {
    type: 'GET',
    url: '/gists/' + id
  }
}
var updateGist = function(id, properties) {
  return {
    type: 'PUT',
    url: '/gists/' + id
  }
}
var removeGist = function(id) {
  return {
    type: 'DELETE',
    url: '/gists/' + id
  }
}
var starGist = function(id) {
  return {
    type: 'PUT',
    url: '/gists/' + id + '/star'
  }
};
var unstarGist = function(id) {
  return {
    type: 'DELETE',
    url: '/gists/' + id + '/star'
  }
};
var forkGist = function(id) {
  return {
    type: 'POST',
    url: '/gists/' + id + '/forks'
  }
};

var defaultBaseUrl = 'http://docs.gistsample.apiary.io'
global.GistsAPI = function(baseUrl) {
  baseUrl = baseUrl || defaultBaseUrl;

  var api = function(id) {
    return {
      find : function() {
        var options = findGist(id);
        return request(options)
      },
      update : function(properties) {
        var options = updateGist(id, properties);
        return request(options)
      },
      remove : function() {
        var options = removeGist(id);
        return request(options)
      },
      star : function() {
        var options = starGist(id);
        return request(options)
      },
      unstar : function() {
        var options = unstarGist(id);
        return request(options)
      },
      fork : function() {
        var options = forkGist(id);
        return request(options)
      }
    }
  }

  api.findAll = function findAll(options) {
    var options = findAllGists(options);
    return request(options);
  };
  api.add = function add(properties) {
    var options = addGist(options);
    return request(options);
  }

  var request = function(options) {
    options.url = baseUrl + options.url;
    options.contentType = 'application/json';
    return $.ajax(options);
  };

  return api;
};

})(window, jQuery);