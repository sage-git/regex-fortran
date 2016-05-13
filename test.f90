program test
  use regex_module
  implicit none
  call test1()
  write(*,*) "-----------------"
  call test2()
  write(*,*) "-----------------"
  call test3()
  write(*,*) "-----------------"
  call test4()
  stop
contains
  subroutine print_groups(t)
    type(regex), intent(in) :: t
    integer :: i
    character(len=:), allocatable :: buffer
    do i = 0, 255
      buffer = t%group(i)
      if(len_trim(buffer) > 0)then
        write(*,'(a,i3,a,a)') "group(", i, ") = ", buffer
      endif
    enddo
  end subroutine print_groups

  subroutine test1()
    type(regex) :: t
    integer :: status
    status = t%compile("abc(.*)(ghi)", extended = .true.)
    status = t%match("abcdefghi")
    call t%print_status()
    write(*,*) "matched = ",  status == 0
    call print_groups(t)
  end subroutine test1

  subroutine test2()
    type(regex) :: t
    character(len=:), allocatable :: pat, str
    t = "abcdsadfsfghi" .rem. "abc(.*)(ghi)"
    write(*,*) "matched = ", t%matched()
    call print_groups(t)
    write(*,*) " ***"
    pat = "http://www\.(.*)\.com"
    str = "http://www.google.com"
    t = str .rem. pat
    write(*,*) "matched = ", t%matched()
    call print_groups(t)
    write(*,*) " ***"
    call print_groups("abcdsadfsfghi" .rem. "abc(.*)(ghi)")
  end subroutine test2

  subroutine test3()
    type(regex) :: t
    integer :: status
    status = t%compile("abc(.*)(ghi")
    status = t%match("abcdefgi")
    call t%print_status()
    write(*,*) " ***"
    status = t%compile("abc(.*)(ghi)")
    status = t%match("abcdefgi")
    call t%print_status()
    write(*,*) " ***"
    t = "abcdsadfsfghi" .rem. "abc(.*(ghi)"
    call t%print_status()
  end subroutine test3

  subroutine test4()
    type(regex) :: t, v
    integer :: status
    status = t%compile("abc(.*)(ghi)", extended = .true.)
    status = t%match("abcdefghi")
    v = t
  end subroutine test4
end program test
