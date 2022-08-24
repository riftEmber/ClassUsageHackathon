module ExpressionTree {
  class Exp {
    proc eval() : int {
      halt("Expression subclasses must override eval");
      // return -1;
    }
  }

  class VarExp : Exp {
    var value : int;

    proc init(value : int) { this.value = value; }

    override proc eval() : int { return value; }
  }

  class BinExp : Exp {
    var leftChild : owned Exp;
    var rightChild : owned Exp;

    proc init(in left : owned Exp, in right : owned Exp) {
      leftChild = left;
      rightChild = right;
    }
  }

  class AddExp : BinExp {
    proc init(in left : owned Exp, in right : owned Exp) {
      super.init(left, right);
    }
    override proc eval() : int { return leftChild.eval() + rightChild.eval(); }
  }

  class SubExp : BinExp {
    proc init(in left : owned Exp, in right : owned Exp) {
      super.init(left, right);
    }
    override proc eval() : int { return leftChild.eval() - rightChild.eval(); }
  }

  class MultExp : BinExp {
    proc init(in left : owned Exp, in right : owned Exp) {
      super.init(left, right);
    }
    override proc eval() : int { return leftChild.eval() * rightChild.eval(); }
  }

  proc main() {
    var tree = new AddExp(new MultExp(new VarExp(2), new VarExp(3)),
                          new SubExp(new VarExp(5), new VarExp(3)));

    var result = tree.eval();
    writeln("Evaluation result: ", result);
  }
}
