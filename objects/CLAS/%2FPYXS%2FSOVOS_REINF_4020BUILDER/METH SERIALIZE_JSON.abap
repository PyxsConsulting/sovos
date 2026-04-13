  METHOD serialize_json.

    DATA(lo_writer) =
      cl_sxml_string_writer=>create( type = if_sxml=>co_xt_json ).

    CALL TRANSFORMATION id
      SOURCE root = is_data
      RESULT XML lo_writer.

    rv_json = /ui2/cl_json=>serialize(
               data        = is_data
               pretty_name = /ui2/cl_json=>pretty_mode-none ).

  ENDMETHOD.