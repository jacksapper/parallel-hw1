#include <iostream>
#include "Eigen/Dense"

using namespace Eigen;
using namespace std;

const char* dgemm_desc = "Breaking da rules, Breaking da rules";

extern "C" void square_dgemm (int n, double* A, double* B, double* C);

void square_dgemm (int n, double* A, double* B, double* C)
{
	MatrixXd Ayy = Map<MatrixXd>(A,n,n);
	MatrixXd Bee = Map<MatrixXd>(B,n,n);
	MatrixXd Cee = Map<MatrixXd>(C,n,n);
	Cee += (Ayy*Bee);
}
