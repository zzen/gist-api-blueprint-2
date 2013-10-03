gist-api-blueprint
==================

[Gist API](http://developer.github.com/v3/gists/) rewritten as an API Blueprint, [renered by Apiary here](http://docs.gistsample.apiary.io/).


JavaScript SDK (anticipated)
------------------------------

For the sake of simplicity, the SDK requires jQuery for the AJAX methods and promises.
All methods return a [jQuery promise](http://api.jquery.com/category/deferred-object/)

```js
// gists
$.gist.findAll({since: timestamp})
$.gist.add(properties)
$.gist(id).find()
$.gist(id).update(changedProperties)
$.gist(id).remove

// stars
$.gist(id).star.add()
$.gist(id).star.find()
$.gist(id).star.remove()

// forks
$.gist(id).fork.add()
```

Example: star all gists with *.js files

```js
$.gist.findAll()
  .then(filterGistsWithJsFiles)
  .then(favoriteGists)
  .then(function() {
    alert('you love all the JavaScriptz!')
  });

var hasJsFile = function(gist) {
  for (var filname in gist.files) {
    if(/\.js$/.test(filename)) {
      return true
    }
  }
}
var filterGistsWithJsFiles = function(gists) {
  return gists.filter(hasJsFile)
}
var favoriteGist = function(gist) {
  return $.gist(gist.id).star.add();
};
var favoriteGists = function(gists) {
  return gists.map(favoriteGist);
};
```