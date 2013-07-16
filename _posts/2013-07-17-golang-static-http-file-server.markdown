---
layout: post
title: Static http file server in Go
---

[Go][0] is a great language for building network based applications. It comes
with some excellent tools for creating web-apps out of the box.

I often want to create a "simple http server" to serve up the current
directory, usually I reach for `python -m SimpleHTTPServer`, but in the
spirit of re-inventing the wheel I decided to see how Go could handle
this task.

It turned out to be remarkably simple. Go comes with a static file server
as part of the `net/http` package, in this example I've added a couple of flags that
allow specifying the port and the root filesystem path for the process.

```go
// httpserver.go
package main

import (
	"flag"
	"net/http"
)

var port = flag.String("port", "8080", "Define what port TCP port to bind to")
var root = flag.String("root", ".", "Define the root filesystem path")

func main() {
	panic(http.ListenAndServe(":"+*port, http.FileServer(http.Dir(*root))))
}
```

The actual meat of the program is the single line inside the main
function. `http.ListenAndServe` accepts an address to listen on as the first argument,
and an object which implements the `http.Handler` interface as the second,
in this case `http.FileServer`. If
`ListenAndServe` returns an error (most likely because another process
is using the desired port) then the process will `panic` and exit.

If you've got Go installed then this can be run directly.

```
$ go run httpserver.go
```

Or you can compile it to a standalone binary.

```
$ go build httpserver.go
$ ./httpserver
```

The file server implementation that Go provides even handles serving `index.html`
from a directory if no file is specified, and provides a directory
listing if there is no `index.html` present.

For more details check out [Go's implementation of `http.FileServer`][1].

[0]: http://golang.org/
[1]: http://golang.org/src/pkg/net/http/fs.go?s=12008:12048#L401
