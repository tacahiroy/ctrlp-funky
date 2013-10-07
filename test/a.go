package main

import "fmt"

type T struct {
  fld int;
}


func main() {
  fmt.Printf("Hello, World\n")
  t := T{}
  t.fun()
}

func (t T) fun() {
  fmt.Printf("%d", t.fld)
}

func (t T) fun2() int {
  return 0
}
