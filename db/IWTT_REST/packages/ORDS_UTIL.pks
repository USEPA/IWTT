CREATE OR REPLACE PACKAGE ords_util
AUTHID CURRENT_USER
AS
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE delete_service(
       p_module_name        IN  VARCHAR2
      ,p_base_path          IN  VARCHAR2     DEFAULT NULL
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE define_service(
       p_module_name        IN  VARCHAR2
      ,p_base_path          IN  VARCHAR2     DEFAULT NULL
      ,p_pattern            IN  VARCHAR2     DEFAULT '.'
      ,p_source_get_type    IN  VARCHAR2     DEFAULT ORDS.SOURCE_TYPE_PLSQL
      ,p_source_get         IN  CLOB         DEFAULT NULL
      ,p_source_post_type   IN  VARCHAR2     DEFAULT ORDS.SOURCE_TYPE_PLSQL
      ,p_source_post        IN  CLOB         DEFAULT NULL
      ,p_items_per_page     IN  INTEGER      DEFAULT 0
      ,p_status             IN  VARCHAR2     DEFAULT 'PUBLISHED'
      ,p_priority           IN  INTEGER      DEFAULT 0
      ,p_etag_type          IN  VARCHAR2     DEFAULT 'HASH'
      ,p_etag_query         IN  VARCHAR2     DEFAULT NULL
      ,p_mimes_allowed      IN  VARCHAR2     DEFAULT NULL
      ,p_module_comments    IN  VARCHAR2     DEFAULT NULL
      ,p_template_comments  IN  VARCHAR2     DEFAULT NULL
      ,p_handler_comments   IN  VARCHAR2     DEFAULT NULL
      ,p_origins_allowed    IN  VARCHAR2     DEFAULT NULL
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE reject_request;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE setup_ref_tables;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION get_env
   RETURN VARCHAR2 RESULT_CACHE;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION get_origins(
      p_service  IN  VARCHAR2 DEFAULT NULL
   ) RETURN VARCHAR2 RESULT_CACHE;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION get_header_name
   RETURN VARCHAR2 RESULT_CACHE;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION chk_header(
      p_header_value  IN  VARCHAR2
   ) RETURN BOOLEAN RESULT_CACHE;
   
END ords_util;
/

