# Haskell WebDev Playground

Experimenting with web dev using Haskell libraries.

## Build and Run

This project is build using [Stack](https://www.haskellstack.org/).

    git clone https://github.com/m-renaud/HaskellWebDevPlayground.git
	cd HaskellWebDevPlayground/backend
	stack setup
    stack build
	stack exec server

You can then navigate to http://localhost:8081/healthz and see "OK".

## Libraries in use

- Servant: API declaration
- Wai/Warp: Underlying HTTP server (may look into using servant-snap)
- Lucid: HTML templating library

## API

`/healthz` see if the server is OK
`/user` see some names
`/user/<userId::Integer>` the name with the associated ID.
