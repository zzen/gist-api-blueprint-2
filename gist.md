FORMAT: 1A

# Gists API
REST API for GitHub Gists. Original [here](http://developer.github.com/v3/gists/)

# Gists [/gists]
A collection of gists.

## Lists Gists [GET]
When authenticated, returns all of user's Gists. When unauthenticated, returns all public Gists.

+ Response 200 (application/json)

    + Headers
        
            Link: <https://api.github.com/resource?page=2>; rel="next", <https://api.github.com/resource?page=5>; rel="last"
            X-RateLimit-Limit: 5000
            X-RateLimit-Remaining: 4999

    + Body
    
            [
              {
                "url": "https://api.github.com/gists/1c34d10b7f3cf2de3be2",
                "id": "1",
                "description": "description of gist",
                "public": true,
                "user": {
                  "login": "octocat",
                  "id": 1,
                  "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                  "gravatar_id": "somehexcode",
                  "url": "https://api.github.com/users/octocat"
                },
                "files": {
                  "ring.erl": {
                    "size": 932,
                    "filename": "ring.erl",
                    "raw_url": "https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"
                  }
                },
                "comments": 0,
                "comments_url": "https://api.github.com/gists/a339d35685cd11a4d890/comments/",
                "html_url": "https://gist.github.com/1",
                "git_pull_url": "git://gist.github.com/1.git",
                "git_push_url": "git@gist.github.com:1.git",
                "created_at": "2010-04-14T02:15:15Z"
              }
            ]

## Create a Gist [POST]

+ Request (application/json)

    Note: Don’t name your files “gistfile” with a numerical suffix. This is the format of the automatic naming scheme that Gist uses internally.

    + Parameters
        
        + description (optional, string, `the description for this gist`)
        + public (boolean, `true`)
        + files (hash) ... Files that make up this gist. The key of which should be a *required* **string** filename and the value another *required* **hash** with parameters.
        + content (string) ... File contents.
    
    + Body

            {
              "description": "the description for this gist",
              "public": true,
              "files": {
                "file1.txt": {
                  "content": "String file contents"
                }
              }
            }

+ Response 201 (application/json)

    + Headers
    
            Location: https://api.github.com/gists/1
            X-RateLimit-Limit: 5000
            X-RateLimit-Remaining: 4999
    
    + Body

            {
              "url": "https://api.github.com/gists/1c34d10b7f3cf2de3be2",
              "id": "1",
              "description": "description of gist",
              "public": true,
              "user": {
                "login": "octocat",
                "id": 1,
                "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                "gravatar_id": "somehexcode",
                "url": "https://api.github.com/users/octocat"
              },
              "files": {
                "ring.erl": {
                  "size": 932,
                  "filename": "ring.erl",
                  "raw_url": "https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"
                }
              },
              "comments": 0,
              "comments_url": "https://api.github.com/gists/a339d35685cd11a4d890/comments/",
              "html_url": "https://gist.github.com/1",
              "git_pull_url": "git://gist.github.com/1.git",
              "git_push_url": "git@gist.github.com:1.git",
              "created_at": "2010-04-14T02:15:15Z",
              "forks": [
                {
                  "user": {
                    "login": "octocat",
                    "id": 1,
                    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                    "gravatar_id": "somehexcode",
                    "url": "https://api.github.com/users/octocat"
                  },
                  "url": "https://api.github.com/gists/2034572bc1e182050383",
                  "created_at": "2011-04-14T16:00:49Z"
                }
              ],
              "history": [
                {
                  "url": "https://api.github.com/gists/b89cbe14f348fcbaf525",
                  "version": "57a7f021a713b1c5a6a199b54cc514735d2d462f",
                  "user": {
                    "login": "octocat",
                    "id": 1,
                    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                    "gravatar_id": "somehexcode",
                    "url": "https://api.github.com/users/octocat"
                  },
                  "change_status": {
                    "deletions": 0,
                    "additions": 180,
                    "total": 180
                  },
                  "committed_at": "2010-04-14T02:15:15Z"
                }
              ]
            }


# Gist [/gists/{id}]

A single gist object

## Get a single gist [GET]

+ Response 200 (applications/json)

    + Headers
    
            X-RateLimit-Limit: 5000
            X-RateLimit-Remaining: 4999

    + Body
        
            {
              "url": "https://api.github.com/gists/1c34d10b7f3cf2de3be2",
              "id": "1",
              "description": "description of gist",
              "public": true,
              "user": {
                "login": "octocat",
                "id": 1,
                "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                "gravatar_id": "somehexcode",
                "url": "https://api.github.com/users/octocat"
              },
              "files": {
                "ring.erl": {
                  "size": 932,
                  "filename": "ring.erl",
                  "raw_url": "https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"
                }
              },
              "comments": 0,
              "comments_url": "https://api.github.com/gists/a339d35685cd11a4d890/comments/",
              "html_url": "https://gist.github.com/1",
              "git_pull_url": "git://gist.github.com/1.git",
              "git_push_url": "git@gist.github.com:1.git",
              "created_at": "2010-04-14T02:15:15Z",
              "forks": [
                {
                  "user": {
                    "login": "octocat",
                    "id": 1,
                    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                    "gravatar_id": "somehexcode",
                    "url": "https://api.github.com/users/octocat"
                  },
                  "url": "https://api.github.com/gists/2034572bc1e182050383",
                  "created_at": "2011-04-14T16:00:49Z"
                }
              ],
              "history": [
                {
                  "url": "https://api.github.com/gists/b89cbe14f348fcbaf525",
                  "version": "57a7f021a713b1c5a6a199b54cc514735d2d462f",
                  "user": {
                    "login": "octocat",
                    "id": 1,
                    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                    "gravatar_id": "somehexcode",
                    "url": "https://api.github.com/users/octocat"
                  },
                  "change_status": {
                    "deletions": 0,
                    "additions": 180,
                    "total": 180
                  },
                  "committed_at": "2010-04-14T02:15:15Z"
                }
              ]
            }

## Edit a gist [PATCH]

+ Request

    *NOTE:* All files from the previous version of the gist are carried over by default if not included in the hash. Deletes can be performed by including the filename with a null hash.
    
    + Parameters
    
        + description (optional, string)
        + files (optional, hash) ... Files that make up this gist. The key of which should be an *optional* **string** filename and the value another *optional* **hash** with parameters:
            + content (optional, string) ... Updated file contents.
            + filename (optional, string) ... New name for this file.

    
    + Body
    
            {
              "description": "the description for this gist",
              "files": {
                "file1.txt": {
                  "content": "updated file contents"
                },
                "old_name.txt": {
                  "filename": "new_name.txt",
                  "content": "modified contents"
                },
                "new_file.txt": {
                  "content": "a new file"
                },
                "delete_this_file.txt": null
              }
            }




+ Response 200 (application/json)

    + Headers
    
            X-RateLimit-Limit: 5000
            X-RateLimit-Remaining: 4999
    
    + Body

            {
              "url": "https://api.github.com/gists/1c34d10b7f3cf2de3be2",
              "id": "1",
              "description": "description of gist",
              "public": true,
              "user": {
                "login": "octocat",
                "id": 1,
                "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                "gravatar_id": "somehexcode",
                "url": "https://api.github.com/users/octocat"
              },
              "files": {
                "ring.erl": {
                  "size": 932,
                  "filename": "ring.erl",
                  "raw_url": "https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"
                }
              },
              "comments": 0,
              "comments_url": "https://api.github.com/gists/a339d35685cd11a4d890/comments/",
              "html_url": "https://gist.github.com/1",
              "git_pull_url": "git://gist.github.com/1.git",
              "git_push_url": "git@gist.github.com:1.git",
              "created_at": "2010-04-14T02:15:15Z",
              "forks": [
                {
                  "user": {
                    "login": "octocat",
                    "id": 1,
                    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                    "gravatar_id": "somehexcode",
                    "url": "https://api.github.com/users/octocat"
                  },
                  "url": "https://api.github.com/gists/2034572bc1e182050383",
                  "created_at": "2011-04-14T16:00:49Z"
                }
              ],
              "history": [
                {
                  "url": "https://api.github.com/gists/b89cbe14f348fcbaf525",
                  "version": "57a7f021a713b1c5a6a199b54cc514735d2d462f",
                  "user": {
                    "login": "octocat",
                    "id": 1,
                    "avatar_url": "https://github.com/images/error/octocat_happy.gif",
                    "gravatar_id": "somehexcode",
                    "url": "https://api.github.com/users/octocat"
                  },
                  "change_status": {
                    "deletions": 0,
                    "additions": 180,
                    "total": 180
                  },
                  "committed_at": "2010-04-14T02:15:15Z"
                }
              ]
            }
