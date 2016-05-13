program demo
  use regex_module
  implicit none
  type(regex) :: t
  integer :: i
  t = "abcdefghijklmn" .rem. "abc(def(.*))k"
  write(*,*) t%group(0) !abcdefghijk
  write(*,*) t%group(1) !defghij
  write(*,*) t%group(2) !ghij
end program demo
