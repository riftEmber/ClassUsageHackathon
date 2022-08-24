module ExpressionTree {
  enum binOp {
    Add,
    Sub,
    Mult
  }

  class Exp {
    proc eval() : int {
      halt("Expression subclasses must override eval");
      // return -1;
    }
    iter preorder() : string {
      halt("expressions must override preorder traversal iterator");
    }
  }

  class VarExp : Exp {
    var value : int;

    proc init(value : int) { this.value = value; }

    override proc eval() : int { return value; }
    override iter preorder() : string {
      yield(value: string);
    }
  }

  class BinExp : Exp {
    var leftChild : owned Exp;
    var rightChild : owned Exp;
    var op : binOp;

    proc init(in left : owned Exp, in right : owned Exp, op: binOp) {
      leftChild = left;
      rightChild = right;
      this.op = op;
    }

    override proc eval() : int {
      select op {
        when binOp.Add do
          return leftChild.eval() + rightChild.eval();
        when binOp.Sub do
          return leftChild.eval() - rightChild.eval();
        when binOp.Mult do
          return leftChild.eval() * rightChild.eval();
      }
      halt("Unsupported binary operator '" + op: string + "' encountered");
    }

    override iter preorder() : string {
      yield "(" + op:string + " ";
      for i in leftChild.preorder() {yield i;}
      yield " ";
      for i in rightChild.preorder() {yield i;}
      yield ")";
    }
  }

  class AddExp : BinExp {
    proc init(in left : owned Exp, in right : owned Exp) {
      super.init(left, right, binOp.Add);
    }
  }

  class SubExp : BinExp {
    proc init(in left : owned Exp, in right : owned Exp) {
      super.init(left, right, binOp.Sub);
    }
  }

  class MultExp : BinExp {
    proc init(in left : owned Exp, in right : owned Exp) {
      super.init(left, right, binOp.Mult);
    }
  }

  proc main() {
    var tree = new AddExp(new MultExp(new VarExp(2), new VarExp(3)),
                          new SubExp(new VarExp(5), new VarExp(3)));

    var result = tree.eval();
    writeln("Evaluation result: ", result);

    writeln("Preorder traversal of expression tree:");
    for node in tree.preorder() {
      write(node);
    }
    writeln();
  }
}
