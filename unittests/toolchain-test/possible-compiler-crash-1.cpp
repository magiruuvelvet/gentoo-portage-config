struct meta_string {
  consteval meta_string(){}
  consteval meta_string(const meta_string& data1,const meta_string& data2){}
};

void crashed_tests() {
  constexpr meta_string str_by_subobjects{
       meta_string{},
       meta_string{}};
}
