! SUMMA - Structure for Unifying Multiple Modeling Alternatives
! Copyright (C) 2014-2020 NCAR/RAL; University of Saskatchewan; University of Washington
!
! This file is part of SUMMA
!
! For more information see: http://www.ral.ucar.edu/projects/summa
!
! This program is free software: you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License
! along with this program.  If not, see <http://www.gnu.org/licenses/>.

module summa4chm_forcing
! used to read model forcing data

! safety: set private unless specified otherwise
implicit none
private
public::summa4chm_readForcing
contains

 ! used to read model forcing data
 subroutine summa4chm_readForcing(modelTimeStep, timeStruct, forcStruct, err, message)
 ! ---------------------------------------------------------------------------------------
 ! * desired modules
 ! ---------------------------------------------------------------------------------------
 ! data types
 USE nrtype                                                  ! variable types, etc.
 ! subroutines and functions
 USE read_force4chm_module,only:read_force4chm               ! module to read model forcing data
 USE time_utils_module,only:elapsedSec                       ! calculate the elapsed time
 USE data_types,only:var_i,var_d
 ! indices in forcing file
 USE globalData,only:iFile                                   ! index of current forcing file from forcing file list
 USE globalData,only:forcingStep                             ! index of current time step in current forcing file
 USE globalData,only:forcNcid                                ! netcdf id for current netcdf forcing file
 ! timing variables
 USE globalData,only:startRead,endRead                       ! date/time for the start and end of reading forcing data
 USE globalData,only:elapsedRead                             ! elapsed time to read forcing data
 ! ---------------------------------------------------------------------------------------
 ! * variables
 ! ---------------------------------------------------------------------------------------
 implicit none
 ! dummy variables
 integer(i4b),intent(in)               :: modelTimeStep      ! time step index
 type(var_i),intent(out)               :: timeStruct                 !  model time data
 type(var_d),intent(out)               :: forcStruct                 !  model forcing data
 integer(i4b),intent(out)              :: err                ! error code
 character(*),intent(out)              :: message            ! error message
 ! local variables
 character(LEN=256)                    :: cmessage           ! error message of downwind routine
 ! ----------------------------------------------------------------------------------------
 ! initialize error control
 err=0; message='summa4chm_readForcing/'

 ! initialize the start of the data read
 call date_and_time(values=startRead)
 
 print *, 'modelTimeStep = ', modelTimeStep

 ! read forcing data
 call read_force4chm(&
                 ! input
                 modelTimeStep,      & ! intent(in):    time step index
                 ! input-output
                 iFile,              & ! intent(inout): index of current forcing file in forcing file list
                 forcingStep,        & ! intent(inout): index of read position in time dimension in current netcdf file
                 forcNcid,           & ! intent(inout): netcdf file identifier for the current forcing file
                 ! output
                 timeStruct%var,     & ! intent(out):   time data structure (integer)
                 forcStruct,         & ! intent(out):   forcing data structure (double precision)
                 err, cmessage)        ! intent(out):   error control
 if(err/=0)then; message=trim(message)//trim(cmessage); return; endif

 ! identify the end of the data read
 call date_and_time(values=endRead)

 ! aggregate the elapsed time for the data read
 elapsedRead = elapsedRead + elapsedSec(startRead, endRead)

 end subroutine summa4chm_readForcing

end module summa4chm_forcing
