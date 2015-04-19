# loauth


## Introduction

TBD


## Installation

Just add it to your ``rebar.config`` deps:

```erlang
  {deps, [
    ...
    {loauth, ".*",
      {git, "git@github.com:YOURNAME/loauth.git", "master"}}
      ]}.
```

And then do the usual:

```bash
    $ rebar get-deps
    $ rebar compile
```


## Usage

Currently, only command-line usage (``grant_type=password``) is supported.

From the REPL:

```cl
> (loauth:start)
```
```cl
(#(inets ok) #(ssl ok) #(lhttpc ok))
```
```cl
> (slurp "src/loauth.lfe")
```
```cl
#(ok loauth)
```
```cl
> (set state
    (make-loauth-data
      token-uri "https://www.inaturalist.org/oauth/token"
      client-id your-client-id
      client-secret your-client-secret))
```
```cl
#(loauth-data undefined
  "https://www.inaturalist.org/oauth/token"
  ...)
```
```cl
> (set token (loauth:get-token your-username your-password state))
```
```cl
"2a58b2761cba0823c85f62ebd34b8f80e5c55cc342d287520fc3464acaa0c0d1"
```

