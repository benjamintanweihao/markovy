Markovy
=======

Me learning how to do some text generation using Markov chains. Josh Adams of Elixir Rips fame has done an episode, which ultimately piqued my interest in this. You could also check that out.

## The Algorithm

The (super simplified) algorithm involves 2 steps:

### Dictionary Generation

For every pair of words in the text (called the prefix), record the word that comes after that (called the suffix). 

### Text Generation

To generate text, set `x`, and `y` to be the first 2 words of the text:

```
loop do
  randomly choose z from one of the suffixes of the prefix x,y
  print z
  replace x,y by y,z
  repeat loop
end
```

