# virtus_yard


This gem helps to generate YARD documentation for classes built using [Virtus](https://github.com/solnic/virtus). It means automatically generating documentation about attributes, their types and features inherited from Virtus like mass-assignment or coercion.

## Work in Progress

This is a very early prototype which is not yet ready to be used for any real project.

## Notice

This library uses eval with $SAFE level 3 to evaluate list of options in
`attribute` declarations.
