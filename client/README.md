# bor/client

## Modular widget design
When creating new widgets, there are multiple things to consider to make sure 
your widgets can be reused easily. I am a follower of the [Unix philosophy](https://en.wikipedia.org/wiki/Unix_philosophy), 
which aims for minimalist and modular software development. For the most part, if a widget *can be modular*, it should be.
However, if a nested child widget tree needs to directly alter the parent widgets state, it has a particular use case, and 
therefore, should not be a separate widget, and all logic should remain as a child of the parent widget.