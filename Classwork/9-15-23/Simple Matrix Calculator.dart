import "dart:io";

class Matrix2f
{
  int dim1;
  int dim2;
  Matrix2f(this.dim1, this.dim2)
  {
    mat = List<List<double>>.generate(dim1, (i) => List<double>.generate(dim2, (index) => 0, growable: false), growable: false);
  }
  late List<List<double>> mat;
}

int main()
{
  Function GetMatrix = () 
  {
    stdout.write("enter rows: ");
    int dim1 = int.parse(stdin.readLineSync()!);
    stdout.write("enter columns: ");
    int dim2 = int.parse(stdin.readLineSync()!);

    Matrix2f m = new Matrix2f(dim1, dim2);

    for(int i = 0; i < dim1; i++)
    {
      for(int j = 0; j < dim2; j++)
      {
        stdout.write("enter number at row ${i+1}, col ${j+1}: ");
        m.mat[i][j] = double.parse(stdin.readLineSync()!);
      }
    }
    return m;
  };
  //this is not needed, but i do not know how to use anonymous and higher functions in
  //this context, i usually do it in callbacks
   Matrix2f m1 = GetMatrix();
   Matrix2f m2 = GetMatrix();

   Function mult = Multiply(m1, m2);
   Function add = Add(m1, m2);

   Matrix2f? product = mult();
   Matrix2f? sum = add();

  stdout.write("Input matrix 1: \n");
  PrintMatrix(m1);
  stdout.write("Input matrix 2: \n");
  PrintMatrix(m2);

  stdout.write("Product: \n");
  
  (product == null ? stdout.write("DOES NOT EXIST\n") : PrintMatrix(product));

  stdout.write("Sum:\n");

  (sum == null ? stdout.write("DOES NOT EXIST\n") : PrintMatrix(sum));

  return 0;
}

Function Multiply(Matrix2f m1, Matrix2f m2)
{
  return ()
  {
    if(m1.dim2 != m2.dim1)
    {
      return null;
    }

    Matrix2f product = new Matrix2f(m1.dim1, m2.dim2);

    for(int i = 0; i < product.dim1; i++)
    {
      for(int j = 0; j < product.dim2; j++)
      {
        double sum = 0.0;
        for(int k = 0; k < m1.dim2; k++)
        {
          sum += m1.mat[i][k] * m2.mat[k][j];
        }
        product.mat[i][j] = sum;
      }
    }

    return product;
  };
}

Function Add(Matrix2f m1, Matrix2f m2)
{
  return ()
  {
    if(m1.dim1 != m2.dim1 || m1.dim2 != m2.dim2)
    {
      return null;
    }


    Matrix2f sum = new Matrix2f(m1.dim1, m1.dim2);

    for(int i = 0; i < sum.dim1; i++)
    {
      for(int j = 0; j < sum.dim2; j++)
      {
        sum.mat[i][j] = m1.mat[i][j] + m2.mat[i][j];
      }
    }

    return sum; 
  };
}

void PrintMatrix(Matrix2f m)
{
  for(List<double> row in m.mat)
  {
    stdout.write("$row\n");
  }
}