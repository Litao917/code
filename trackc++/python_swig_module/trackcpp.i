%module trackcpp

%{
#include "../elements.h"
#include "../kicktable.h"
#include "../auxiliary.h"
#include "../accelerator.h"
#include "../pos.h"
#include "../tracking.h"
#include "interface.h"
#include "elementswrapper.h"
%}
%include "carrays.i"
%include "std_string.i"
%include "std_vector.i"
%include "stl.i"

namespace std {
    %template(CppStringVector) vector<string>;
    %template(CppDoubleVector) vector<double>;
    %template(CppElementVector) vector<Element>;
    %template(CppDoublePosVector) vector< Pos<double> >;
}

%inline %{
double c_array_get(double* v, int i) {
    return v[i];
}
void c_array_set(double* v, int i, double x) {
    v[i] = x;
}
%}

%include "elements.i"

%include "../kicktable.h"
%include "../auxiliary.h"
%include "../accelerator.h"
%include "../pos.h"
%include "../tracking.h"
%include "interface.h"
%include "elementswrapper.h"

%template(DoublePos) Pos<double>;
%template(double_track_elementpass) track_elementpass<double>;
