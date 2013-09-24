package com.example.foo;

import java.lang.*;

public class a {

    private boolean pendulum;
    protected boolean pb = false;
    private static final int CONSTANT1 = 1;

    public static void main() {
      return;
    }

    public static final String to_s() {
      return "";
    }

    public a (int x, int y) {
      // constructor
    }

    public void each (long index) {
      if (index == 0) {
        return;
      }
      // this shouldn't be detected as a method
      else if (index == 1) {
        return;
      }
      else {
        return;
      }
    }

    public String toString () {
        return "A";
    }

    protected int foo() {
      return 0;
    }

    private void bar() {
      return;
    }
}
