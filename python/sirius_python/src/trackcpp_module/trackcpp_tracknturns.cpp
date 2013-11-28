#include "trackcpp.h"

// Exception object
extern PyObject *TrackcppError;
extern std::string TrackcppErrorMsg;

PyObject*  trackcpp_tracknturns(PyObject *self, PyObject *args) {

	PyObject *py_lattice, *py_pos, *py_nr_turns, *py_turn_by_turn, *py_trajectory;
	if (!PyArg_ParseTuple(args, "OOOOO", &py_lattice, &py_pos, &py_nr_turns, &py_turn_by_turn, &py_trajectory))
		return NULL;

	Py_INCREF(py_lattice);
	Py_INCREF(py_pos);


	int  nr_turns = PyInt_AS_LONG(py_nr_turns);
	bool turn_by_turn = PyObject_IsTrue(py_turn_by_turn);
	bool trajectory = PyObject_IsTrue(py_trajectory);



	// reads pyring particles coordinates in phase space into trackc++ vector
	std::vector<Pos<double> > orig_pos;
	if (trackcpp_read_particles(py_pos, orig_pos)) {
		Py_DECREF(py_lattice);
		Py_DECREF(py_pos);
		return NULL;
	}
	//Py_RETURN_NONE;


	// reads pyring lattice into trackc++ lattice
	std::vector<Element> lattice;
	if (trackcpp_read_lattice(py_lattice, lattice)) {
		Py_DECREF(py_lattice);
		Py_DECREF(py_pos);
		return NULL;
	}
	//Py_RETURN_NONE;

	// Does tracking
	int element_idx = -1;
	int turn_idx    = -1;
	std::vector<Pos<double> > pos;
	Status::type ret = tracknturns(lattice, orig_pos, pos, nr_turns, &turn_idx, &element_idx, turn_by_turn, trajectory);

	if (ret != Status::success) {
		if (ret == Status::passmethod_not_defined) {
			std::string pmname = pm_dict[lattice[element_idx].pass_method];
			std::ostringstream convert; convert << element_idx; std::string strnumber = convert.str();
			TrackcppErrorMsg = "Passmethod '" + pmname + "' in element #" + strnumber + " not defined";
		}
		if (ret == Status::passmethod_not_implemented) {
			std::string pmname = pm_dict[lattice[element_idx].pass_method];
			std::ostringstream convert; convert << element_idx; std::string strnumber = convert.str();
			TrackcppErrorMsg = "Passmethod '" + pmname + "' in element #" + strnumber + " not implemented";
		}
		PyErr_SetString(TrackcppError, TrackcppErrorMsg.c_str());
		Py_DECREF(py_lattice);
		Py_DECREF(py_pos);
		return NULL;
	}

	Py_DECREF(py_lattice);
	Py_DECREF(py_pos);

	PyObject *lst = PyList_New(6*pos.size());
	if (!lst) return NULL;
	for (unsigned int p = 0; p < pos.size(); p++) {
		PyObject *py_rx = PyFloat_FromDouble(pos[p].rx);
		PyObject *py_px = PyFloat_FromDouble(pos[p].px);
		PyObject *py_ry = PyFloat_FromDouble(pos[p].ry);
		PyObject *py_py = PyFloat_FromDouble(pos[p].py);
		PyObject *py_de = PyFloat_FromDouble(pos[p].de);
		PyObject *py_dl = PyFloat_FromDouble(pos[p].dl);
		if (!py_rx or !py_px or !py_ry or !py_py or !py_de or !py_dl)  {
			Py_DECREF(lst);
			return NULL;
		}
		PyList_SET_ITEM(lst, 6*p+0, py_rx);   // reference to num stolen
		PyList_SET_ITEM(lst, 6*p+1, py_px);   // reference to num stolen
		PyList_SET_ITEM(lst, 6*p+2, py_ry);   // reference to num stolen
		PyList_SET_ITEM(lst, 6*p+3, py_py);   // reference to num stolen
		PyList_SET_ITEM(lst, 6*p+4, py_de);   // reference to num stolen
		PyList_SET_ITEM(lst, 6*p+5, py_dl);   // reference to num stolen
	}

	return lst;

}