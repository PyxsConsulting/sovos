  PROTECTED SECTION.

    METHODS: create_message_log
      IMPORTING
        !severity TYPE if_bali_item_setter=>ty_severity
        !text     TYPE if_bali_free_text_setter=>ty_text,

      save_log.
