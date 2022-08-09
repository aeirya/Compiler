/**
 * File: list.h
 * ------------
 * Simple list class for storing a linear collection of elements. It
 * supports operations similar in name to the CS107 CVector -- nth, insert,
 * append, remove, etc.  This class is nothing more than a very thin
 * cover of a STL deque, with some added range-checking. Given not everyone
 * is familiar with the C++ templates, this class provides a more familiar
 * interface.
 *
 * It can handle elements of any type, the typename for a List includes the
 * element type in angle brackets, e.g.  to store elements of type double,
 * you would use the type name List<double>, to store elements of type
 * Decl *, it woud be List<Decl*> and so on.
 *
 * Here is some sample code illustrating the usage of a List of integers
 *
 *   int Sum(List<int> *list) {
 *       int sum = 0;
 *       for (int i = 0; i < list->size(); i++) {
 *          int val = list->Nth(i);
 *          sum += val;
 *       }
 *       return sum;
 *    }
 */

#ifndef _H_list
#define _H_list

#include <deque>
#include "utility.h"  // for Assert()
using namespace std;

class Node;

template<class Element> class List {

 private:
    deque<Element> elems;

 public:
           // Create a new empty list
    List() {}

           // Returns count of elements currently in list
    int size() const
	{ return elems.size(); }

          // Returns element at index in list. Indexing is 0-based.
          // Raises an assert if index is out of range.
    Element get(int index) const
	{ Assert(index >= 0 && index < size());
	  return elems[index]; }

          // Inserts element at index, shuffling over others
          // Raises assert if index out of range
    void insert(const Element &elem, int index)
	{ Assert(index >= 0 && index <= size());
	  elems.insert(elems.begin() + index, elem); }

          // Adds element to list end
    void append(const Element &elem)
	{ elems.push_back(elem); }

         // Removes element at index, shuffling down others
         // Raises assert if index out of range
    void remove(int index)
	{ Assert(index >= 0 && index < size());
	  elems.erase(elems.begin() + index); }

         // Removes last element
         // Raises assert if list is empty
    void remove()
  {
    int n = size();
    Assert(n > 0);
    elems.ease(elems.begin()); }

       // These are some specific methods useful for lists of ast nodes
       // They will only work on lists of elements that respond to the
       // messages, but since C++ only instantiates the template if you use
       // you can still have Lists of ints, chars*, as long as you 
       // don't try to SetParentAll on that list.
    void SetParentAll(Node *p)
        { for (int i = 0; i < size(); i++)
             get(i)->SetParent(p); }

    typename deque<Element>::iterator begin() {
      return elems.begin();
    }

    typename deque<Element>::iterator end() {
      return elems.end();
    }
};

#endif

