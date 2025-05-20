CREATE OR REPLACE PACKAGE BODY ords_util
AS

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE delete_service(
       p_module_name        IN  VARCHAR2
      ,p_base_path          IN  VARCHAR2     DEFAULT NULL
   )
   AS
      str_name VARCHAR2(4000 Char);

   BEGIN

      ORDS.DELETE_MODULE(
         p_module_name => p_module_name
      );

      IF p_base_path IS NOT NULL
      THEN
         BEGIN
            SELECT
            a.name
            INTO
            str_name
            FROM
            user_ords_services a
            WHERE
            a.base_path = '/' || p_base_path;

         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               str_name := NULL;

            WHEN OTHERS
            THEN
               RAISE;

         END;

         IF str_name IS NOT NULL
         THEN
            ORDS.DELETE_MODULE(
               p_module_name => str_name
            );

         END IF;

      END IF;

      COMMIT;

   END delete_service;

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
   )
   AS
      str_base_path       VARCHAR2(32000 Char);
      str_origins_allowed VARCHAR2(32000 Char);
      str_header_name     VARCHAR2(4000 Char);

   BEGIN

      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      IF p_base_path IS NULL
      THEN
         str_base_path := LOWER(p_module_name) || '/';

      ELSE
         str_base_path := p_base_path;

      END IF;

      IF p_origins_allowed IS NULL
      THEN
         str_origins_allowed := get_origins(LOWER(p_module_name));

      ELSE
         str_origins_allowed := p_origins_allowed;

      END IF;
      
      str_header_name := ords_util.get_header_name();

      --------------------------------------------------------------------------
      -- Step 20
      -- Delete any preexising service
      --------------------------------------------------------------------------
      delete_service(
          p_module_name     => p_module_name
         ,p_base_path       => str_base_path
      );

      --------------------------------------------------------------------------
      -- Step 30
      -- Create the module
      --------------------------------------------------------------------------
      ORDS.DEFINE_MODULE(
          p_module_name     => p_module_name
         ,p_base_path       => str_base_path
         ,p_items_per_page  => p_items_per_page
         ,p_status          => p_status
         ,p_comments        => p_module_comments
      );

      --------------------------------------------------------------------------
      -- Step 40
      -- Create the template
      --------------------------------------------------------------------------
      ORDS.DEFINE_TEMPLATE(
          p_module_name     => p_module_name
         ,p_pattern         => p_pattern
         ,p_priority        => p_priority
         ,p_etag_type       => p_etag_type
         ,p_etag_query      => p_etag_query
         ,p_comments        => p_template_comments
      );

      --------------------------------------------------------------------------
      -- Step 50
      -- Define the GET endpoint if requested
      --------------------------------------------------------------------------
      IF p_source_get IS NOT NULL
      THEN
         ORDS.DEFINE_HANDLER(
             p_module_name     => p_module_name
            ,p_pattern         => p_pattern
            ,p_method          => 'GET'
            ,p_source_type     => p_source_get_type
            ,p_source          => p_source_get
            ,p_items_per_page  => p_items_per_page
            ,p_mimes_allowed   => p_mimes_allowed
            ,p_comments        => p_handler_comments
         );
         
         IF str_header_name IS NOT NULL
         AND str_header_name != 'NA'
         THEN
            ORDS.DEFINE_PARAMETER(
                p_module_name        => p_module_name
               ,p_pattern            => p_pattern
               ,p_method             => 'GET'
               ,p_name               => str_header_name
               ,p_bind_variable_name => REPLACE(str_header_name,'-','_')
               ,p_source_type        => 'HEADER'
               ,p_param_type         => 'STRING'
               ,p_access_method      => 'IN'
               ,p_comments           => NULL
            );
            
         END IF;

      END IF;

      --------------------------------------------------------------------------
      -- Step 60
      -- Define the POST endpoint if requested
      --------------------------------------------------------------------------
      IF p_source_post IS NOT NULL
      THEN
         ORDS.DEFINE_HANDLER(
             p_module_name     => p_module_name
            ,p_pattern         => p_pattern
            ,p_method          => 'POST'
            ,p_source_type     => p_source_post_type
            ,p_source          => p_source_post
            ,p_items_per_page  => p_items_per_page
            ,p_mimes_allowed   => p_mimes_allowed
            ,p_comments        => p_handler_comments
         );
         
         IF str_header_name IS NOT NULL
         AND str_header_name != 'NA'
         THEN
            ORDS.DEFINE_PARAMETER(
                p_module_name        => p_module_name
               ,p_pattern            => p_pattern
               ,p_method             => 'POST'
               ,p_name               => str_header_name
               ,p_bind_variable_name => REPLACE(str_header_name,'-','_')
               ,p_source_type        => 'HEADER'
               ,p_param_type         => 'STRING'
               ,p_access_method      => 'IN'
               ,p_comments           => NULL
            );
            
         END IF;

      END IF;

      --------------------------------------------------------------------------
      -- Step 70
      -- Commit to close things out
      --------------------------------------------------------------------------
      ORDS.SET_MODULE_ORIGINS_ALLOWED(
          p_module_name     => p_module_name
         ,p_origins_allowed => str_origins_allowed
      );

      --------------------------------------------------------------------------
      -- Step 80
      -- Commit to close things out
      --------------------------------------------------------------------------
      COMMIT;

   END define_service;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE reject_request
   AS   
   BEGIN
      OWA_UTIL.MIME_HEADER('application/json',FALSE,'UTF-8');
      HTP.P('Status: 403 Forbidden');
      
      OWA_UTIL.HTTP_HEADER_CLOSE;
      
      HTP.P('{"return_code":403,"status_message":"forbidden"}');
      
   END reject_request;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE setup_ref_tables
   AS
      str_sql VARCHAR2(32000 Char);
      
   BEGIN
   
      str_sql := 'CREATE TABLE ref_env('
              || '    database_name VARCHAR2(4000 Char) NOT NULL '
              || '   ,environment   VARCHAR2(4000 Char) NOT NULL '
              || '   ,PRIMARY KEY (database_name) '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
   
      str_sql := 'CREATE TABLE ref_origins('
              || '    service_match VARCHAR2(4000 Char) NOT NULL '
              || '   ,origins_list  VARCHAR2(4000 Char) '
              || '   ,PRIMARY KEY (service_match) '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
      
      str_sql := 'CREATE TABLE ref_header_check('
              || '    header_name   VARCHAR2(4000 Char) NOT NULL '
              || '   ,header_value  VARCHAR2(4000 Char) NOT NULL '
              || '   ,PRIMARY KEY (header_name) '
              || ') ';
              
      EXECUTE IMMEDIATE str_sql;
   
   END setup_ref_tables;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION get_env
   RETURN VARCHAR2 RESULT_CACHE
   AS
      str_sql           VARCHAR2(32000 Char);
      str_env           VARCHAR2(4000 Char);
      str_dbname        VARCHAR2(4000 Char);
      
   BEGIN

      SELECT ora_database_name INTO str_dbname FROM dual;
      
      str_sql := 'SELECT '
              || 'a.environment '
              || 'FROM '
              || 'ref_env a '
              || 'WHERE '
              || 'a.database_name = :p01 ';
              
      EXECUTE IMMEDIATE str_sql 
      INTO str_env USING str_dbname;
      
      RETURN str_env;
   
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         -- if no entry in ref_env, assume prod
         RETURN 'prod';
         
      WHEN OTHERS
      THEN
         RAISE;
   
   END get_env;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION get_origins(
      p_service  IN  VARCHAR2 DEFAULT NULL
   ) RETURN VARCHAR2 RESULT_CACHE
   AS
      str_sql           VARCHAR2(32000 Char);
      str_service       VARCHAR2(4000 Char) := p_service;
      str_origins       VARCHAR2(4000 Char);
      
   BEGIN
      
      IF str_service IS NULL
      THEN
         str_service := '*';
         
      END IF;
      
      BEGIN
         str_sql := 'SELECT '
                 || 'a.origins_list '
                 || 'FROM '
                 || 'ref_origins a '
                 || 'WHERE '
                 || 'a.service_match = :p01 ';
         
         EXECUTE IMMEDIATE str_sql 
         INTO str_origins USING str_service;
         
         RETURN str_origins;
   
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            str_service := '*';
            
         WHEN OTHERS
         THEN
            IF SQLCODE = -942
            THEN
               RAISE_APPLICATION_ERROR(-20001,'ref_origins table is missing, execute setup_ref_tables to correct');
               
            ELSE
               RAISE;
            
            END IF;
            
      END;
      
      BEGIN
         str_sql := 'SELECT '
                 || 'a.origins_list '
                 || 'FROM '
                 || 'ref_origins a '
                 || 'WHERE '
                 || 'a.service_match = :p01 ';
         
         EXECUTE IMMEDIATE str_sql 
         INTO str_origins USING str_service;
         
         RETURN str_origins;
   
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN NULL;
            
         WHEN OTHERS
         THEN
            IF SQLCODE = -942
            THEN
               RAISE_APPLICATION_ERROR(-20001,'ref_origins table is missing, execute setup_ref_tables to correct');
               
            ELSE
               RAISE;
            
            END IF;
            
      END;
   
   END get_origins;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE fetch_header_info(
       out_header_name  OUT VARCHAR2
      ,out_header_value OUT VARCHAR2
   )
   AS
      str_sql           VARCHAR2(32000 Char);
      str_server        VARCHAR2(4000 Char);
      
   BEGIN
   
      str_sql := 'SELECT '
              || ' a.header_name '
              || ',a.header_value '
              || 'FROM '
              || 'ref_header_check a ';
           
      EXECUTE IMMEDIATE str_sql 
      INTO out_header_name,out_header_value;
      
      IF out_header_name IS NULL
      THEN
         RAISE_APPLICATION_ERROR(-20001,'header entry required, set NA to skip');
         
      END IF;

   EXCEPTION
   
      WHEN NO_DATA_FOUND
      THEN
         RAISE_APPLICATION_ERROR(-20001,'ref_header_check table is empty, add an NA record to skip header checking');
         
      WHEN OTHERS
      THEN
         IF SQLCODE = -942
         THEN
            RAISE_APPLICATION_ERROR(-20001,'ref_header_check table is missing, execute setup_ref_tables to correct');
            
         ELSE
            RAISE;
         
         END IF;
         
   END fetch_header_info;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION get_header_name
   RETURN VARCHAR2 RESULT_CACHE
   AS
      str_header_name   VARCHAR2(4000 Char);
      str_header_value  VARCHAR2(4000 Char);
      
   BEGIN
   
      fetch_header_info(str_header_name,str_header_value);
      
      RETURN str_header_name;
   
   END get_header_name;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION chk_header(
      p_header_value  IN  VARCHAR2
   ) RETURN BOOLEAN RESULT_CACHE
   AS
      str_header_name   VARCHAR2(4000 Char);
      str_header_value  VARCHAR2(4000 Char);
      
   BEGIN
   
      fetch_header_info(str_header_name,str_header_value);

      IF str_header_name IS NULL
      THEN
         -- header check not specified, deny for safety
         RETURN FALSE;
         
      ELSIF str_header_name = 'NA'
      THEN
         -- header check turned off via ref table
         RETURN TRUE;
      
      ELSIF p_header_value = str_header_value
      THEN
         -- headers match, allow
         RETURN TRUE;
         
      ELSE
         -- headers do not match, deny      
         RETURN FALSE;
         
      END IF;
   
   END chk_header;

END ords_util;
/

