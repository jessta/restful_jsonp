RESTful JSONP
============

This is a Rails plugin (Railtie) and Rack Middleware that allows your existing RESTful controllers to work over JSONP.

## Verbs

REST is designed around HTTP verbs (`GET`, `POST`, `PUT`, `DELETE`, etc), but
JSONP requests are always `GET`s. To get around this restriction, this Railtie lets you specify the
desired method in a special `_method` parameter.

For example, to make a `PUT` request to `/users/1.json`, you would make a JSONP (`GET`) request to
`/users/1.json?_method=PUT`.

## Renderer

The plugin also overrides the controller `render` method to detect an illegal JSONP status (4xx, 5xx, etc.) and respond with a 200 instead. This allows clients to access the content of the error and respond accordingly, e.g.:

    {
        "message":"Invalid Token",
        "status":401,
        "error":"Unauthorized"
    }


Usage
-----

**TODO**

How it Works
------------

The `_method` functionality is built in to Rails (via Rack), but is normally only available for
`POST` requests. This Railtie replaces the default `Rack::MethodOverride` middleware with a slightly
altered version that checks for the `_method` parameter regardless of whether it's in a `POST`
or `GET` request.

Note that this functionality is enabled for all requests, regardless of whether they are done
via JSONP or otherwise.

## Testing

    rake test

