
	CONSTANS:
      BEGIN OF mcs_log_data,
        object    TYPE balobj_d VALUE 'YOUR OBJECT',
        subobject TYPE balsubobj VALUE 'YOUT SUBOBJECT',
      END OF   mcs_log_data.

    DATA:
      lt_log_header TYPE balhdr_t,
      lt_log_handle TYPE bal_t_logh.

    DATA(ltr_obj) = VALUE bal_r_obj( ( sign   = if_fsbp_const_range=>sign_include
                                       option = if_fsbp_const_range=>option_equal
                                       low    = mcs_log_data-object ) ).

    DATA(ltr_subobj) = VALUE bal_r_sub( ( sign   = if_fsbp_const_range=>sign_include
                                          option = if_fsbp_const_range=>option_equal
                                          low    = mcs_log_data-subobject ) ).


    "DATA(ls_extnum) = <-- Set your data for external number   

    "Key
    DATA(ltr_extnum) = VALUE bal_r_extn( ( sign   = if_fsbp_const_range=>sign_include
                                           option = if_fsbp_const_range=>option_equal
                                           low    = ls_extnum ) ).

    DATA(ls_log_filter) = VALUE bal_s_lfil( object    = ltr_obj
                                            subobject = ltr_subobj
                                            extnumber = ltr_extnum ).

    " Search log
    CALL FUNCTION 'BAL_DB_SEARCH'
      EXPORTING
        i_client       = sy-mandt
        i_s_log_filter = ls_log_filter
      IMPORTING
        e_t_log_header = lt_log_header
      EXCEPTIONS
        OTHERS         = 3.

    CHECK sy-subrc = 0.

    " Load log in memory
    CALL FUNCTION 'BAL_DB_LOAD' 
      EXPORTING
        i_t_log_header = lt_log_header
        i_client       = sy-mandt
      EXCEPTIONS 
        OTHERS         = 4.

    " Display log
    CALL FUNCTION 'BAL_DSP_LOG_DISPLAY' 
      EXPORTING
        i_t_log_handle = lt_log_handle
      EXCEPTIONS 
        OTHERS         = 5.
