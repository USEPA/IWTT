CREATE OR REPLACE PACKAGE BODY iwtt.iwtt_services
AS
   g_delimiter CONSTANT VARCHAR2(1 Char) := ';';
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION c2b(
      p_in                IN VARCHAR2
   ) RETURN BOOLEAN
   AS
   BEGIN
      IF p_in IS NULL
      THEN
         RETURN NULL;
         
      END IF;
      
      IF UPPER(p_in) IN ('TRUE','YES','T','Y')
      THEN
         RETURN TRUE;
         
      END IF;
      
      RETURN FALSE;
   
   END c2b;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION jsend_success(
       p_data             IN  CLOB
      ,p_jsonp_callback   IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      clb_output  CLOB;
      str_pad     VARCHAR2(1 Char);
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
  
      --------------------------------------------------------------------------
      -- Step 20
      -- Add in the left bracket
      --------------------------------------------------------------------------
      IF p_pretty_print IS NULL
      THEN
         clb_output := dz_json_util.pretty('{',NULL);
         str_pad := '';
         
      ELSE
         clb_output := dz_json_util.pretty('{',-1);
         str_pad := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add in the status 
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          str_pad || dz_json_main.value2json(
              'status'
             ,'success'
             ,p_pretty_print + 1
          )
         ,p_pretty_print + 1
      );
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add in the data, account for null data though that is weird
      --------------------------------------------------------------------------
      IF p_data IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.fastname(
                 'data'
                ,p_pretty_print + 1
             ) || p_data
            ,p_pretty_print + 1
         );
         
      ELSE
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.fastname(
                 'data'
                ,p_pretty_print + 1
             ) || 'null'
            ,p_pretty_print + 1
         );
                             
      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Add the right bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,p_pretty_print,NULL,NULL
      );

      --------------------------------------------------------------------------
      -- Step 60
      -- Return results
      --------------------------------------------------------------------------
      IF p_jsonp_callback IS NOT NULL
      THEN
         RETURN p_jsonp_callback || '(' || clb_output || ')';
      
      ELSE
         RETURN clb_output;
      
      END IF;
         
   END jsend_success;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION jsend_fail(
       p_data             IN  CLOB
      ,p_jsonp_callback   IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      clb_output  CLOB;
      str_pad     VARCHAR2(1 Char);
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
  
      --------------------------------------------------------------------------
      -- Step 20
      -- Add in the left bracket
      --------------------------------------------------------------------------
      IF p_pretty_print IS NULL
      THEN
         clb_output := dz_json_util.pretty('{',NULL);
         str_pad := '';
         
      ELSE
         clb_output := dz_json_util.pretty('{',-1);
         str_pad := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add in the status 
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          str_pad || dz_json_main.value2json(
              'status'
             ,'fail'
             ,p_pretty_print + 1
          )
         ,p_pretty_print + 1
      );
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add in the data, account for null data though that is weird
      --------------------------------------------------------------------------
      IF p_data IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.fastname(
                 'data'
                ,p_pretty_print + 1
             ) || p_data
            ,p_pretty_print + 1
         );
         
      ELSE
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.fastname(
                 'data'
                ,p_pretty_print + 1
             ) || 'null'
            ,p_pretty_print + 1
         );
                             
      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Add the right bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,p_pretty_print,NULL,NULL
      );

      --------------------------------------------------------------------------
      -- Step 60
      -- Return results
      --------------------------------------------------------------------------
      IF p_jsonp_callback IS NOT NULL
      THEN
         RETURN p_jsonp_callback || '(' || clb_output || ')';
      
      ELSE
         RETURN clb_output;
      
      END IF;
         
   END jsend_fail;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION jsend_error(
       p_message          IN  VARCHAR2
      ,p_code             IN  NUMBER   DEFAULT NULL
      ,p_data             IN  CLOB     DEFAULT NULL
      ,p_jsonp_callback   IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print     IN  NUMBER   DEFAULT NULL
   ) RETURN CLOB
   AS
      clb_output  CLOB;
      str_pad     VARCHAR2(1 Char);
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
  
      --------------------------------------------------------------------------
      -- Step 20
      -- Add in the left bracket
      --------------------------------------------------------------------------
      IF p_pretty_print IS NULL
      THEN
         clb_output := dz_json_util.pretty('{',NULL);
         str_pad := '';
         
      ELSE
         clb_output := dz_json_util.pretty('{',-1);
         str_pad := ' ';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add in the status and message
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          str_pad || dz_json_main.value2json(
              'status'
             ,'error'
             ,p_pretty_print + 1
          )
         ,p_pretty_print + 1
      ) || dz_json_util.pretty(
          ',' || dz_json_main.value2json(
              'message'
             ,p_message
             ,p_pretty_print + 1
          )
         ,p_pretty_print + 1
      );
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Add in optional code
      --------------------------------------------------------------------------
      IF p_code IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.fastname(
                 'code'
                ,p_pretty_print + 1
             ) || p_code
            ,p_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add in optional data
      --------------------------------------------------------------------------
      IF p_data IS NOT NULL
      THEN
         clb_output := clb_output || dz_json_util.pretty(
             ',' || dz_json_main.fastname(
                 'data'
                ,p_pretty_print + 1
             ) || p_data
            ,p_pretty_print + 1
         );
         
      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Add the right bracket
      --------------------------------------------------------------------------
      clb_output := clb_output || dz_json_util.pretty(
          '}'
         ,p_pretty_print,NULL,NULL
      );

      --------------------------------------------------------------------------
      -- Step 60
      -- Return results
      --------------------------------------------------------------------------
      IF p_jsonp_callback IS NOT NULL
      THEN
         RETURN p_jsonp_callback || '(' || clb_output || ')';
      
      ELSE
         RETURN clb_output;
      
      END IF;
         
   END jsend_error;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE write_header(
       p_output_format    IN  VARCHAR2
      ,p_cache            IN  VARCHAR2 DEFAULT NULL
      ,p_json_callback    IN  VARCHAR2 DEFAULT NULL
      ,p_filename         IN  VARCHAR2 DEFAULT NULL
      ,p_mute             IN  BOOLEAN  DEFAULT FALSE
   )
   AS
      boo_nocache BOOLEAN;
      str_output_format VARCHAR2(4000 Char) := UPPER(p_output_format);

   BEGIN
   
      IF p_mute
      THEN
         RETURN;
         
      END IF;

      --------------------------------------------------------------------------
      -- Step 10
      -- Override to JSON if JSONP callback is set
      --------------------------------------------------------------------------
      IF p_json_callback IS NOT NULL
      THEN
         str_output_format := 'JSON';
         
      END IF;

      --------------------------------------------------------------------------
      -- Step 10
      -- Check for cache parameter
      --------------------------------------------------------------------------
      IF p_cache IS NULL
      THEN
         boo_nocache := TRUE;
         
      ELSE
         boo_nocache := FALSE;
         
      END IF;

      --------------------------------------------------------------------------
      -- Step 20
      -- Determine the proper mime header
      --------------------------------------------------------------------------
      IF str_output_format IS NULL
      OR UPPER(str_output_format) IN ('TXT','TEXT','KMLSTYLE')
      THEN
         OWA_UTIL.MIME_HEADER(
             ccontent_type => 'text/plain'
            ,bclose_header => FALSE
            ,ccharset      => 'UTF-8'
         );
         
      ELSIF UPPER(str_output_format) IN ('XML','KML','GEOKML','GML','GEOGML','SLD')
      THEN
         OWA_UTIL.MIME_HEADER(
             ccontent_type => 'text/xml'
            ,bclose_header => FALSE
            ,ccharset      => 'UTF-8'
         );
         
      ELSIF UPPER(str_output_format) IN ('CSV')
      THEN
         OWA_UTIL.MIME_HEADER(
             ccontent_type => 'text/csv'
            ,bclose_header => FALSE
            ,ccharset      => 'UTF-8'
         );
         
      ELSIF UPPER(str_output_format) IN ('JSON','GEOJSON')
      THEN
         OWA_UTIL.MIME_HEADER(
             ccontent_type => 'application/json'
            ,bclose_header => FALSE
            ,ccharset      => 'UTF-8'
         );

      ELSIF UPPER(str_output_format) IN ('JSONP','GEOJSONP')
      THEN
         OWA_UTIL.MIME_HEADER(
             ccontent_type => 'text/javascript'
            ,bclose_header => FALSE
            ,ccharset      => 'UTF-8'
         );
         
      ELSIF UPPER(str_output_format) IN ('GOOGLE EARTH','GOOGLE_EARTH','GOOGLE EARTH KML','GOOGLE_EARTH_KML')
      THEN
         OWA_UTIL.MIME_HEADER(
             ccontent_type => 'application/vnd.google-earth.kml+xml'
            ,bclose_header => FALSE
            ,ccharset      => 'UTF-8'
         );
         
      ELSIF UPPER(str_output_format) IN ('GOOGLE EARTH KMZ','GOOGLE_EARTH_KMZ')
      THEN
         OWA_UTIL.MIME_HEADER(
             ccontent_type => 'application/vnd.google-earth.kmz'
            ,bclose_header  => FALSE
            ,ccharset       => 'UTF-8'
         );
         
      ELSE
         RAISE_APPLICATION_ERROR(-20001,'<' || UPPER(str_output_format) || '> format not implemented');
         
      END IF;

      --------------------------------------------------------------------------
      -- Step 30
      -- Add in the filename if requested
      --------------------------------------------------------------------------
      IF p_filename IS NOT NULL
      THEN
         HTP.P('Content-Disposition: attachment; filename=' || p_filename);
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Add appropriate cache control
      --------------------------------------------------------------------------
      IF boo_nocache = FALSE
      THEN
         HTP.P('Expires: -1');
         HTP.P('Cache-Control: no-cache');
         HTP.P('Pragma: no-cache');
         
      END IF;

      --------------------------------------------------------------------------
      -- Step 40
      -- Close the HTTP header
      --------------------------------------------------------------------------
      OWA_UTIL.HTTP_HEADER_CLOSE;

   END write_header;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE clob2htp(
       p_input            IN  CLOB
      ,p_string_size      IN  NUMBER   DEFAULT 32000
      ,p_breaking_chars   IN  VARCHAR2 DEFAULT NULL
      ,p_breaking_delim   IN  VARCHAR2 DEFAULT ','
      ,p_mute             IN  BOOLEAN  DEFAULT FALSE
   )
   AS
      ary_chars  MDSYS.SDO_STRING2_ARRAY;
      int_index  PLS_INTEGER := 1;
      int_offset PLS_INTEGER := 1;
      int_cutoff PLS_INTEGER;
      str_line   VARCHAR2(32000 Char);
      
   BEGIN

      IF p_string_size > 32000
      THEN
         RAISE_APPLICATION_ERROR(
             -20001
            ,'VARCHAR2.HTP.P size maxes out at 32000 characters'
         );
         
      END IF;

      IF p_breaking_chars IS NOT NULL
      THEN
          ary_chars := dz_json_util.gz_split(
              p_str   => p_breaking_chars
             ,p_regex => p_breaking_delim
             ,p_trim  => 'FALSE'
          );
          
      END IF;

      WHILE DBMS_LOB.SUBSTR(p_input,p_string_size,int_offset) IS NOT NULL
      LOOP
         str_line := TO_CHAR(DBMS_LOB.SUBSTR(p_input,p_string_size,int_offset));

         IF p_breaking_chars IS NULL
         THEN
            int_cutoff := p_string_size;

         ELSE
            int_cutoff := 0;
            
            FOR i IN 1 .. ary_chars.COUNT
            LOOP
               int_cutoff := INSTR(str_line,ary_chars(i),-1);

               IF int_cutoff > 0
               THEN
                  EXIT;
                  
               END IF;

            END LOOP;

            IF  int_cutoff = 0
            THEN
               IF LENGTH(str_line) >= p_string_size
               THEN
                  RAISE_APPLICATION_ERROR(
                      -20001
                     ,'unable to break CLOB on given breaking characters'
                  );
                  
               ELSE
                  int_cutoff := LENGTH(str_line);
                  
               END IF;

            END IF;

         END IF;

         IF p_mute
         THEN
            DBMS_OUTPUT.PUT_LINE(SUBSTR(str_line,1,int_cutoff));
         
         ELSE
            HTP.PRN(SUBSTR(str_line,1,int_cutoff));
         
         END IF;
         
         int_index  := int_index + 1;
         int_offset := int_offset + int_cutoff;
         
      END LOOP;

   END clob2htp;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION get_filename(
       p_service_type               IN  VARCHAR2
      ,p_extension                  IN  VARCHAR2
   ) RETURN VARCHAR2
   AS
   BEGIN
   
      RETURN 'IWTT' || p_service_type || '_' || TO_CHAR(TRUNC(SYSTIMESTAMP),'MMDDYYYY') || p_extension;
   
   END get_filename;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION escape_regex(
       p_input                      IN  VARCHAR2
   ) RETURN VARCHAR2
   AS
      str_output VARCHAR2(32000 Char) := p_input;
      
   BEGIN
   
      str_output := REPLACE(str_output,'|','\|');
      str_output := REPLACE(str_output,'(','\(');
      str_output := REPLACE(str_output,')','\)');
   
      RETURN str_output;
   
   END escape_regex;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION treatment_tech_code_expander(
      p_input             IN MDSYS.SDO_STRING2_ARRAY
   ) RETURN MDSYS.SDO_STRING2_ARRAY
   AS
      ary_output  MDSYS.SDO_STRING2_ARRAY;
      ary_temp    MDSYS.SDO_STRING2_ARRAY;
      int_counter PLS_INTEGER;
      
   BEGIN
   
      ary_output := MDSYS.SDO_STRING2_ARRAY();
   
      IF p_input IS NULL
      OR p_input.COUNT = 0
      THEN
         RETURN ary_output;
         
      END IF;
      
      BEGIN
         SELECT 
         a.tt_code
         BULK COLLECT INTO ary_temp 
         FROM
         iwtt.xref_treatment_tech_category a
         WHERE
         a.tt_category_code IN (SELECT * FROM TABLE(p_input));
         
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN p_input;
            
         WHEN OTHERS
         THEN
            RAISE;
            
      END;
         
      IF ary_temp IS NULL
      OR ary_temp.COUNT = 0
      THEN
         RETURN p_input;
         
      END IF;
      
      int_counter := 1;
      FOR i IN 1 .. p_input.COUNT
      LOOP
         ary_output.EXTEND();
         ary_output(int_counter) := p_input(i);
         int_counter := int_counter + 1;
      
      END LOOP;
      
      FOR i IN 1 .. ary_temp.COUNT
      LOOP
         ary_output.EXTEND();
         ary_output(int_counter) := ary_temp(i);
         int_counter := int_counter + 1;
      
      END LOOP;
      
      RETURN dz_json_util.sort_string(
          p_input_array => ary_output
         ,p_unique      => 'TRUE'
      );
   
   END treatment_tech_code_expander;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE ref2csv(
       p_input            IN OUT SYS_REFCURSOR
      ,p_column_headers   IN  BOOLEAN DEFAULT TRUE
      ,p_add_bom          IN  BOOLEAN DEFAULT TRUE
   )
   AS
      int_curid          PLS_INTEGER;
      int_colcnt         PLS_INTEGER;
      desctab            DBMS_SQL.DESC_TAB;
      str_holder         VARCHAR2(32000 Char);
      num_holder         NUMBER;
      dat_holder         DATE;
      clb_holder         CLOB;
      clb_output         CLOB;
      line_delimiter     VARCHAR2(2 Char) := CHR(13) || CHR(10);
      
      -----------------------------------------------------------------------------
      -----------------------------------------------------------------------------
      FUNCTION csv(
         p_input_value     IN  CLOB
      ) RETURN VARCHAR2
      AS
         clb_input CLOB := p_input_value;

      BEGIN

         IF clb_input IS NULL
         THEN
            RETURN NULL;

         END IF;
         
         clb_input := REGEXP_REPLACE(clb_input,'[' || CHR(1) || '-' || CHR(9) || ']','');
         clb_input := REGEXP_REPLACE(clb_input,'[' || CHR(14) || '-' || CHR(31) || ']','');
         clb_input := REGEXP_REPLACE(clb_input,'^"[^"]|[^"]"$|[^"]"[^"]','""');
         
         -- CSV fields have a rough limit of 32000 bytes
         clb_input := SUBSTR(clb_input,1,32000);

         RETURN '"' || REPLACE(clb_input,'"','""') || '"';

      END csv;
      
      -----------------------------------------------------------------------------
      -----------------------------------------------------------------------------
      FUNCTION csv(
         p_input_value     IN  VARCHAR2
      ) RETURN VARCHAR2
      AS
         str_input  VARCHAR2(32000) := p_input_value;

      BEGIN

         IF str_input IS NULL
         THEN
            RETURN NULL;

         END IF;
         
         str_input := REGEXP_REPLACE(str_input,'[' || CHR(1) || '-' || CHR(9) || ']','');
         str_input := REGEXP_REPLACE(str_input,'[' || CHR(14) || '-' || CHR(31) || ']','');
         str_input := REGEXP_REPLACE(str_input,'^"[^"]|[^"]"$|[^"]"[^"]','""');

         RETURN '"' || REPLACE(str_input,'"','""') || '"';

      END csv;

      -----------------------------------------------------------------------------
      -----------------------------------------------------------------------------
      FUNCTION csv(
         p_input_value    IN  NUMBER
      ) RETURN VARCHAR2
      AS
         str_input  VARCHAR2(32000) := p_input_value;

      BEGIN

         IF str_input IS NULL
         THEN
            RETURN NULL;

         END IF;

         RETURN TO_CHAR(str_input);

      END csv;

      -----------------------------------------------------------------------------
      -----------------------------------------------------------------------------
      FUNCTION csv(
         p_input_value     IN  DATE
      ) RETURN VARCHAR2
      AS
         str_output  VARCHAR2(32000);

      BEGIN

         IF p_input_value IS NULL
         THEN
            RETURN NULL;

         END IF;

         IF TRUNC(p_input_value) = p_input_value
         THEN
            str_output := TO_CHAR(p_input_value,'MM/DD/YYYY');

         ELSE
            str_output := TO_CHAR(p_input_value,'MM/DD/YYYY HH24:mi:ss');

         END IF;

         RETURN str_output;

      END csv;

   BEGIN

      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      IF p_add_bom IS NULL OR p_add_bom
      THEN
         HTP.PRN(NCHR(65279));
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Convert ref cursor to dbms_sql
      --------------------------------------------------------------------------
      int_curid := DBMS_SQL.TO_CURSOR_NUMBER(p_input);

      --------------------------------------------------------------------------
      -- Step 30
      -- Describe and define the columns and write optional header
      --------------------------------------------------------------------------
      clb_output := '';
      DBMS_SQL.DESCRIBE_COLUMNS(int_curid,int_colcnt,desctab);

      FOR i IN 1 .. int_colcnt
      LOOP
         
         IF desctab(i).col_type IN (1,9,96)
         THEN
            DBMS_SQL.DEFINE_COLUMN(int_curid,i,str_holder,32000);

         ELSIF desctab(i).col_type = 2
         THEN
            DBMS_SQL.DEFINE_COLUMN(int_curid,i,num_holder);

         ELSIF desctab(i).col_type = 12
         THEN
            DBMS_SQL.DEFINE_COLUMN(int_curid,i,dat_holder);

         ELSIF desctab(i).col_type = 112
         THEN
            DBMS_SQL.DEFINE_COLUMN(int_curid,i,clb_holder);

         END IF;

         IF p_column_headers
         THEN
            clb_output := clb_output || csv(
               desctab(i).col_name
            );

            IF i < int_colcnt
            THEN
               clb_output := clb_output || ',';

            ELSE
               clb_output := clb_output || line_delimiter;

            END IF;

         END IF;

      END LOOP;

      --------------------------------------------------------------------------
      -- Step 40
      -- Output the header if requested
      --------------------------------------------------------------------------
      IF p_column_headers
      THEN
         clob2htp(clb_output);

      END IF;

      --------------------------------------------------------------------------
      -- Step 50
      -- Spin out the cursor
      --------------------------------------------------------------------------
      WHILE DBMS_SQL.FETCH_ROWS(int_curid) > 0
      LOOP
         clb_output := '';

         FOR i IN 1 .. int_colcnt
         LOOP
            IF desctab(i).col_type IN (1,9,96)
            THEN
               DBMS_SQL.COLUMN_VALUE(int_curid,i,str_holder);
               clb_output := clb_output || csv(str_holder);

            ELSIF desctab(i).col_type = 2
            THEN
               DBMS_SQL.COLUMN_VALUE(int_curid,i,num_holder);
               clb_output := clb_output || csv(num_holder);

            ELSIF desctab(i).col_type = 12
            THEN
               DBMS_SQL.COLUMN_VALUE(int_curid,i,dat_holder);
               clb_output := clb_output || csv(dat_holder);

            ELSIF desctab(i).col_type = 112
            THEN
               DBMS_SQL.COLUMN_VALUE(int_curid,i,clb_holder);
               clb_output := clb_output || csv(clb_holder);

            END IF;

            IF i < int_colcnt
            THEN
               clb_output := clb_output || ',';

            ELSE
               clb_output := clb_output || line_delimiter;

            END IF;

         END LOOP;

         clob2htp(clb_output);

      END LOOP;

      --------------------------------------------------------------------------
      -- Step 50
      -- Close the cursor
      --------------------------------------------------------------------------
      DBMS_SQL.CLOSE_CURSOR(int_curid);

   END ref2csv;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE guid_parameters(
       p_point_source_category_code IN  VARCHAR2
      ,p_point_source_category_desc IN  VARCHAR2
      ,p_treatment_technology_code  IN  VARCHAR2
      ,p_treatment_technology_desc  IN  VARCHAR2
      ,p_pollutant_search_term      IN  VARCHAR2
      ,p_pollutant_search_term_wc   IN  VARCHAR2
      ,p_parameter_desc             IN  VARCHAR2
      ,p_ary_psc_codes              OUT MDSYS.SDO_NUMBER_ARRAY
      ,p_str_psc_desc               OUT VARCHAR2
      ,p_ary_tt_codes               OUT MDSYS.SDO_STRING2_ARRAY
      ,p_str_tt_desc                OUT VARCHAR2
      ,p_ary_poll_search            OUT MDSYS.SDO_STRING2_ARRAY
      ,p_str_regexp_pst             OUT VARCHAR2
      ,p_ary_parameter              OUT MDSYS.SDO_STRING2_ARRAY
      ,p_status_message             OUT VARCHAR2
      ,p_return_code                OUT NUMBER
   )
   AS
      str_poll_search_wc VARCHAR2(4000 Char) := UPPER(p_pollutant_search_term_wc);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      p_status_message := '';
      p_return_code    := 0;
      
      IF str_poll_search_wc IS NULL 
      OR str_poll_search_wc NOT IN ('TRUE','FALSE')
      THEN
         str_poll_search_wc := 'FALSE';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Parse point source category items
      --------------------------------------------------------------------------
      IF p_point_source_category_code IS NOT NULL
      THEN
         p_ary_psc_codes := dz_json_util.strings2numbers(
            dz_json_util.gz_split(
                p_point_source_category_code
               ,g_delimiter
            )
         );
         
         IF p_ary_psc_codes IS NULL
         OR p_ary_psc_codes.COUNT = 0
         THEN
            p_status_message := p_status_message || 'Unable to parse p_point_source_category_code as one or more numeric codes. ';
            p_return_code    := -20;
            
         END IF;
               
      END IF;
      
      IF p_point_source_category_desc IS NOT NULL
      THEN
         p_str_psc_desc := UPPER(p_point_source_category_desc);
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Parse treatment_technology items
      --------------------------------------------------------------------------
      IF p_treatment_technology_code IS NOT NULL
      THEN
         p_ary_tt_codes := dz_json_util.gz_split(
             UPPER(p_treatment_technology_code)
            ,g_delimiter
         );
         
         p_ary_tt_codes := treatment_tech_code_expander(p_ary_tt_codes);
               
      END IF;
      
      IF p_treatment_technology_desc IS NOT NULL
      THEN
         p_str_tt_desc := UPPER(p_treatment_technology_desc);
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Parse p_pollutant_search_term 
      --------------------------------------------------------------------------
      IF p_pollutant_search_term IS NOT NULL
      THEN
         p_ary_poll_search := dz_json_util.gz_split(
             UPPER(p_pollutant_search_term )
            ,g_delimiter
         );
         
         IF str_poll_search_wc = 'TRUE'
         THEN         
            p_str_regexp_pst := '(' || escape_regex(p_ary_poll_search(1));
            
            IF p_ary_poll_search.COUNT > 1
            THEN
               FOR i IN 2 .. p_ary_poll_search.COUNT
               LOOP
                  p_str_regexp_pst := p_str_regexp_pst || '|' || escape_regex(p_ary_poll_search(i));
                  
               END LOOP;
            
            END IF;
            
            p_str_regexp_pst := p_str_regexp_pst || ')';
            
            p_ary_poll_search := NULL;
            
         END IF;
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Parse parameter items
      --------------------------------------------------------------------------
      IF p_parameter_desc IS NOT NULL
      THEN
         p_ary_parameter := dz_json_util.gz_split(
             UPPER(p_parameter_desc)
            ,g_delimiter
         );
         
      END IF;

   END guid_parameters;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE guid_search_jsonv01(
       p_point_source_category_code IN  VARCHAR2 DEFAULT NULL
      ,p_point_source_category_desc IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_code  IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_desc  IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term      IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term_wc   IN  VARCHAR2 DEFAULT NULL
      ,p_parameter_desc             IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      obj_CountIndustry    iwtt.dz_json_element1;
      obj_CountSystem      iwtt.dz_json_element1;
      obj_CountSystemFull  iwtt.dz_json_element1;
      obj_CountSystemPilot iwtt.dz_json_element1;
      obj_CountPollutant   iwtt.dz_json_element1;
      obj_Industries       iwtt.dz_json_element1;
      obj_Technologies     iwtt.dz_json_element1;
      obj_Pollutants       iwtt.dz_json_element1;
      obj_Details          iwtt.dz_json_element1;
      obj_Output           iwtt.dz_json_element1_obj;
      
      clb_output           CLOB;
      num_pretty_print     NUMBER;
      boo_mute             BOOLEAN;
      str_status_message   VARCHAR2(4000 Char);
      num_return_code      NUMBER;
      
      ary_psc_codes        MDSYS.SDO_NUMBER_ARRAY;
      str_psc_desc         VARCHAR2(32000 Char);
      ary_tt_codes         MDSYS.SDO_STRING2_ARRAY;
      str_tt_desc          VARCHAR2(32000 Char);
      ary_poll_search      MDSYS.SDO_STRING2_ARRAY;
      str_regexp_pst       VARCHAR2(32000 Char);
      ary_parameter        MDSYS.SDO_STRING2_ARRAY;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      boo_mute := FALSE;
      
      num_pretty_print := dz_json_util.safe_to_number(p_pretty_print);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the header
      --------------------------------------------------------------------------
      write_header(
          p_output_format    => 'JSON'
         ,p_cache            => NULL
         ,p_json_callback    => NULL
         ,p_mute             => boo_mute
      );
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Collect the query variables
      --------------------------------------------------------------------------
      guid_parameters(
          p_point_source_category_code => p_point_source_category_code
         ,p_point_source_category_desc => p_point_source_category_desc
         ,p_treatment_technology_code  => p_treatment_technology_code
         ,p_treatment_technology_desc  => p_treatment_technology_desc
         ,p_pollutant_search_term      => p_pollutant_search_term
         ,p_pollutant_search_term_wc   => p_pollutant_search_term_wc
         ,p_parameter_desc             => p_parameter_desc
         ,p_ary_psc_codes              => ary_psc_codes
         ,p_str_psc_desc               => str_psc_desc
         ,p_ary_tt_codes               => ary_tt_codes
         ,p_str_tt_desc                => str_tt_desc
         ,p_ary_poll_search            => ary_poll_search
         ,p_str_regexp_pst             => str_regexp_pst
         ,p_ary_parameter              => ary_parameter
         ,p_status_message             => str_status_message
         ,p_return_code                => num_return_code
      );
      
      ---------------------------------------------------------------------------
      -- Step 40
      -- Bail if problems
      --------------------------------------------------------------------------
      IF num_return_code <> 0
      THEN
         clob2htp(
             jsend_error(
                p_message        => str_status_message
               ,p_code           => num_return_code
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
            )
            ,p_mute => boo_mute
         );
         
         RETURN;
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Sort out the count items
      --------------------------------------------------------------------------
      SELECT
      iwtt.dz_json_element1(
          p_name => 'CountIndustry'
         ,p_element_number => COUNT(*)
      )
      INTO obj_CountIndustry
      FROM (
         SELECT
         a.industry
         FROM
         iwtt.treatment_system a
         LEFT JOIN 
         iwtt.key_psc b 
         ON 
         a.psc_code = b.psc_code
         LEFT JOIN 
         iwtt.parameter d 
         ON 
             a.ref_id      = d.ref_id
         AND a.system_name = d.system_name
         LEFT JOIN 
         iwtt.key_parameter_code b 
         ON d.paramid = b.paramid
         LEFT JOIN 
         iwtt.treatment_units f 
         ON 
             a.ref_id      = f.ref_id
         AND a.system_name = f.system_name
         LEFT JOIN 
         iwtt.key_treatment_tech_codes g
         ON 
         f.tt_code = g.tt_code
         WHERE
         ( 
            ary_psc_codes IS NULL 
            OR 
            a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
         ) AND ( 
            str_psc_desc IS NULL 
            OR 
            UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
         ) AND ( 
            ary_tt_codes IS NULL 
            OR 
            UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
         ) AND (
            str_tt_desc IS NULL 
            OR 
            UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
         ) AND ( 
            (ary_poll_search IS NULL AND str_regexp_pst IS NULL)
            OR
            UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
            OR 
            REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
         ) AND (
            ary_parameter IS NULL
            OR
            UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
         )
         GROUP BY
         a.industry
      );
      
      SELECT
      iwtt.dz_json_element1(
          p_name => 'CountSystem'
         ,p_element_number => COUNT(*)
      )
      INTO obj_CountSystem
      FROM (
         SELECT
         a.system_name
         FROM
         iwtt.treatment_system a
         LEFT JOIN 
         iwtt.key_psc b 
         ON 
         a.psc_code = b.psc_code
         LEFT JOIN 
         iwtt.parameter d 
         ON 
             a.ref_id      = d.ref_id
         AND a.system_name = d.system_name
         LEFT JOIN 
         iwtt.key_parameter_code b 
         ON d.paramid = b.paramid
         LEFT JOIN 
         iwtt.treatment_units f 
         ON 
             a.ref_id      = f.ref_id
         AND a.system_name = f.system_name
         LEFT JOIN 
         iwtt.key_treatment_tech_codes g
         ON 
         f.tt_code = g.tt_code
         WHERE
         ( 
            ary_psc_codes IS NULL 
            OR 
            a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
         ) AND ( 
            str_psc_desc IS NULL 
            OR 
            UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
         ) AND ( 
            ary_tt_codes IS NULL 
            OR 
            UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
         ) AND (
            str_tt_desc IS NULL 
            OR 
            UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
         ) AND ( 
            (ary_poll_search IS NULL AND str_regexp_pst IS NULL)
            OR
            UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
            OR 
            REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
         ) AND (
            ary_parameter IS NULL
            OR
            UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
         )
         GROUP BY
         a.system_name
      );

      SELECT
      iwtt.dz_json_element1(
          p_name => 'CountSystemFull'
         ,p_element_number => COUNT(*)
      )
      INTO obj_CountSystemFull
      FROM (
         SELECT
         a.system_name
         FROM
         iwtt.treatment_system a
         LEFT JOIN 
         iwtt.key_psc b 
         ON 
         a.psc_code = b.psc_code
         LEFT JOIN 
         iwtt.parameter d 
         ON 
             a.ref_id      = d.ref_id
         AND a.system_name = d.system_name
         LEFT JOIN 
         iwtt.key_parameter_code b 
         ON d.paramid = b.paramid
         LEFT JOIN 
         iwtt.treatment_units f 
         ON 
             a.ref_id      = f.ref_id
         AND a.system_name = f.system_name
         LEFT JOIN 
         iwtt.key_treatment_tech_codes g
         ON 
         f.tt_code = g.tt_code
         WHERE
         ( 
            ary_psc_codes IS NULL 
            OR 
            a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
         ) AND ( 
            str_psc_desc IS NULL 
            OR 
            UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
         ) AND ( 
            ary_tt_codes IS NULL 
            OR 
            UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
         ) AND (
            str_tt_desc IS NULL 
            OR 
            UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
         ) AND ( 
            (ary_poll_search IS NULL AND str_regexp_pst IS NULL)
            OR
            UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
            OR 
            REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
         ) AND (
            ary_parameter IS NULL
            OR
            UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
         )
         AND a.scale = 'Full'
         GROUP BY
         a.system_name
      );
      
      SELECT
      iwtt.dz_json_element1(
          p_name => 'CountSystemPilot'
         ,p_element_number => COUNT(*)
      )
      INTO obj_CountSystemPilot
      FROM (
         SELECT
         a.system_name
         FROM
         iwtt.treatment_system a
         LEFT JOIN 
         iwtt.key_psc b 
         ON 
         a.psc_code = b.psc_code
         LEFT JOIN 
         iwtt.parameter d 
         ON 
             a.ref_id      = d.ref_id
         AND a.system_name = d.system_name
         LEFT JOIN 
         iwtt.key_parameter_code b 
         ON d.paramid = b.paramid
         LEFT JOIN 
         iwtt.treatment_units f 
         ON 
             a.ref_id      = f.ref_id
         AND a.system_name = f.system_name
         LEFT JOIN 
         iwtt.key_treatment_tech_codes g
         ON 
         f.tt_code = g.tt_code
         WHERE
         ( 
            ary_psc_codes IS NULL 
            OR 
            a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
         ) AND ( 
            str_psc_desc IS NULL 
            OR 
            UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
         ) AND ( 
            ary_tt_codes IS NULL 
            OR 
            UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
         ) AND (
            str_tt_desc IS NULL 
            OR 
            UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
         ) AND ( 
            (ary_poll_search IS NULL AND str_regexp_pst IS NULL)
            OR
            UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
            OR 
            REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
         ) AND (
            ary_parameter IS NULL
            OR
            UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
         )
         AND a.scale = 'Pilot'
         GROUP BY
         a.system_name
      );
      
      SELECT
      iwtt.dz_json_element1(
          p_name => 'CountPollutant'
         ,p_element_number => COUNT(*)
      )
      INTO obj_CountPollutant
      FROM (
         SELECT
         d.paramid
         FROM
         iwtt.treatment_system a
         LEFT JOIN 
         iwtt.key_psc b 
         ON 
         a.psc_code = b.psc_code
         LEFT JOIN 
         iwtt.parameter d 
         ON 
             a.ref_id      = d.ref_id
         AND a.system_name = d.system_name
         LEFT JOIN 
         iwtt.key_parameter_code b 
         ON d.paramid = b.paramid
         LEFT JOIN 
         iwtt.treatment_units f 
         ON 
             a.ref_id      = f.ref_id
         AND a.system_name = f.system_name
         LEFT JOIN 
         iwtt.key_treatment_tech_codes g
         ON 
         f.tt_code = g.tt_code
         WHERE
         ( 
            ary_psc_codes IS NULL 
            OR 
            a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
         ) AND ( 
            str_psc_desc IS NULL 
            OR 
            UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
         ) AND ( 
            ary_tt_codes IS NULL 
            OR 
            UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
         ) AND (
            str_tt_desc IS NULL 
            OR 
            UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
         ) AND ( 
            (ary_poll_search IS NULL AND str_regexp_pst IS NULL) 
            OR
            UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
            OR 
            REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
         ) AND (
            ary_parameter IS NULL
            OR
            UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
         )
         AND d.paramid IS NOT NULL
         GROUP BY
         d.paramid
      );
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Build the Industries object
      --------------------------------------------------------------------------
      SELECT
      iwtt.dz_json_element1(
          p_name => 'Industries'
         ,p_element_obj_vry => CAST(MULTISET(
            SELECT
            iwtt.dz_json_element2_obj(
               p_elements => iwtt.dz_json_element2_vry(
                  iwtt.dz_json_element2(
                      p_name           => 'PSCCode'
                     ,p_element_string => xi.PSCCode
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'PSCName'
                     ,p_element_string => xi.PSCName
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'CountSystembyInd'
                     ,p_element_number => xi.CountSystembyInd
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'CountPollbyInd'
                     ,p_element_number => xi.CountPollbyInd
                  )
               )
            )
            FROM (
               SELECT
                a.industry AS PSCName
               ,a.psc_code AS PSCCode
               ,COUNT(DISTINCT a.system_name) AS CountSystembyInd
               ,COUNT(DISTINCT d.parameter) AS CountPollbyInd
               FROM
               iwtt.treatment_system a 
               LEFT JOIN 
               iwtt.key_psc b 
               ON 
               a.psc_code = b.psc_code
               LEFT JOIN 
               iwtt.parameter d 
               ON 
                   a.ref_id      = d.ref_id
               AND a.system_name = d.system_name
               LEFT JOIN 
               iwtt.key_parameter_code b 
               ON 
               d.paramid = b.paramid
               LEFT JOIN 
               iwtt.treatment_units f 
               ON 
                   a.ref_id      = f.ref_id
               AND a.system_name = f.system_name
               LEFT JOIN 
               iwtt.key_treatment_tech_codes g
               ON 
               f.tt_code = g.tt_code
               WHERE
               ( 
                  ary_psc_codes IS NULL 
                  OR 
                  a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
               ) AND ( 
                  str_psc_desc IS NULL 
                  OR 
                  UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
               ) AND ( 
                  ary_tt_codes IS NULL 
                  OR 
                  UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
               ) AND (
                  str_tt_desc IS NULL 
                  OR 
                  UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
               ) AND ( 
                  (ary_poll_search IS NULL AND str_regexp_pst IS NULL)
                  OR
                  UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
                  OR 
                  REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
               ) AND (
                  ary_parameter IS NULL
                  OR
                  UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
               )
               GROUP BY
                a.industry
               ,a.psc_code
            ) xi                  
         ) AS iwtt.dz_json_element2_obj_vry)
      )
      INTO obj_Industries 
      FROM
      dual;

      --------------------------------------------------------------------------
      -- Step 60
      -- Build the Technologies object
      --------------------------------------------------------------------------
      SELECT
      iwtt.dz_json_element1(
          p_name => 'Technologies'
         ,p_element_obj_vry => CAST(MULTISET(
            SELECT
            iwtt.dz_json_element2_obj(
               p_elements => iwtt.dz_json_element2_vry(
                  iwtt.dz_json_element2(
                      p_name           => 'TreatmentTech'
                     ,p_element_string => xt.TreatmentTech
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'TreatmentTechCode'
                     ,p_element_string => xt.TreatmentTechCode
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'CountSystembyTech'
                     ,p_element_number => xt.CountSystembyTech
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'CountIndbyTech'
                     ,p_element_number => xt.CountIndbyTech
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'CountPollbyTech'
                     ,p_element_number => xt.CountPollbyTech
                  )
               )
            )
            FROM (
               SELECT
                MAX(g.tt_name)                AS TreatmentTech
               ,f.tt_code                     AS TreatmentTechCode
               ,COUNT(DISTINCT a.system_name) AS CountSystembyTech
               ,COUNT(DISTINCT a.industry)    AS CountIndbyTech
               ,COUNT(DISTINCT d.paramid)     AS CountPollbyTech
               FROM
               iwtt.treatment_system a 
               LEFT JOIN 
               iwtt.key_psc b 
               ON 
               a.psc_code = b.psc_code
               LEFT JOIN 
               iwtt.parameter d 
               ON 
                   a.ref_id      = d.ref_id
               AND a.system_name = d.system_name
               LEFT JOIN 
               iwtt.key_parameter_code b 
               ON 
               d.paramid = b.paramid
               LEFT JOIN 
               iwtt.treatment_units f 
               ON 
                   a.ref_id      = f.ref_id
               AND a.system_name = f.system_name
               LEFT JOIN 
               iwtt.key_treatment_tech_codes g
               ON 
               f.tt_code = g.tt_code
               WHERE
               ( 
                  ary_psc_codes IS NULL 
                  OR 
                  a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
               ) AND ( 
                  str_psc_desc IS NULL 
                  OR 
                  UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
               ) AND ( 
                  ary_tt_codes IS NULL 
                  OR 
                  UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
               ) AND (
                  str_tt_desc IS NULL 
                  OR 
                  UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
               ) AND ( 
                  (ary_poll_search IS NULL AND str_regexp_pst IS NULL) 
                  OR
                  UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
                  OR 
                  REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
               ) AND (
                  ary_parameter IS NULL
                  OR
                  UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
               )
               GROUP BY
               f.tt_code
            ) xt                 
         ) AS iwtt.dz_json_element2_obj_vry)
      )
      INTO obj_Technologies 
      FROM
      dual;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Build the Pollutants object
      --------------------------------------------------------------------------
      SELECT
      iwtt.dz_json_element1(
          p_name => 'Pollutants'
         ,p_element_obj_vry => CAST(MULTISET(
            SELECT
            iwtt.dz_json_element2_obj(
               p_elements => iwtt.dz_json_element2_vry(
                  iwtt.dz_json_element2(
                      p_name           => 'ParameterName'
                     ,p_element_string => xp.ParameterName
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'CountSystembyPoll'
                     ,p_element_number => xp.CountSystembyPoll
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'CountIndbyPoll'
                     ,p_element_number => xp.CountIndbyPoll
                  )
               )
            )
            FROM (
               SELECT
                MAX(d.parameter) AS ParameterName
               ,COUNT(DISTINCT d.system_name) AS CountSystembyPoll
               ,COUNT(DISTINCT a.industry) AS CountIndbyPoll
               FROM
               iwtt.treatment_system a 
               LEFT JOIN 
               iwtt.key_psc b 
               ON 
               a.psc_code = b.psc_code
               LEFT JOIN 
               iwtt.parameter d 
               ON 
                   a.ref_id      = d.ref_id
               AND a.system_name = d.system_name
               LEFT JOIN 
               iwtt.key_parameter_code b 
               ON 
               d.paramid = b.paramid
               LEFT JOIN 
               iwtt.treatment_units f 
               ON 
                   a.ref_id      = f.ref_id
               AND a.system_name = f.system_name
               LEFT JOIN 
               iwtt.key_treatment_tech_codes g
               ON 
               f.tt_code = g.tt_code
               WHERE
               ( 
                  ary_psc_codes IS NULL 
                  OR 
                  a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
               ) AND ( 
                  str_psc_desc IS NULL 
                  OR 
                  UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
               ) AND ( 
                  ary_tt_codes IS NULL 
                  OR 
                  UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
               ) AND (
                  str_tt_desc IS NULL 
                  OR 
                  UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
               ) AND ( 
                  (ary_poll_search IS NULL AND str_regexp_pst IS NULL) 
                  OR
                  UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
                  OR 
                  REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
               ) AND (
                  ary_parameter IS NULL
                  OR
                  UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
               )
               AND d.paramid IS NOT NULL
               GROUP BY
               d.paramid 
            ) xp                  
         ) AS iwtt.dz_json_element2_obj_vry)
      )
      INTO obj_Pollutants 
      FROM
      dual;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Build the Details object
      --------------------------------------------------------------------------
      SELECT
      iwtt.dz_json_element1(
          p_name => 'Details'
         ,p_element_obj_vry => CAST(MULTISET(
            SELECT
            iwtt.dz_json_element2_obj(
               p_elements => iwtt.dz_json_element2_vry(
                  iwtt.dz_json_element2(
                      p_name           => 'PSCName'
                     ,p_element_string => xd.industry
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'ScaleSystem'
                     ,p_element_string => xd.scale
                  )
                  ,iwtt.dz_json_element2(
                      p_name               => 'TreatmentSystem'
                     ,p_element_string_vry => xd.ary_treat_system
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'ParameterName'
                     ,p_element_string => xd.parameter
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'InfluentFlag'
                     ,p_element_string => xd.influentflag
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'InfluentConcentration'
                     ,p_element_number => xd.influentconcentration
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'EffluentFlag'
                     ,p_element_string => xd.effluentflag
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'EffluentConcentration'
                     ,p_element_number => xd.effluentconcentration
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'Units'
                     ,p_element_string => xd.effluentunits
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'UpdateRemovalFlag'
                     ,p_element_string => xd.updateremovalflag
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'UpdateRemoval'
                     ,p_element_number => xd.updateremoval
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'Author'
                     ,p_element_string => xd.authors
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'MainAuthor'
                     ,p_element_string => xd.main_author
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'Year'
                     ,p_element_string => xd.refdate
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'Ref_ID'
                     ,p_element_number => xd.ref_id
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'System_Name'
                     ,p_element_string => xd.system_name
                  )
                  ,iwtt.dz_json_element2(
                      p_name           => 'Parameter_ID'
                     ,p_element_number => xd.paramid
                  )
               )
            )
            FROM (
               SELECT
                a.industry
               ,a.scale
               ,(
                  SELECT
                  CAST(COLLECT(ff.tt_code ORDER BY ff.tt_code_order) AS MDSYS.SDO_STRING2_ARRAY)
                  FROM
                  iwtt.treatment_units ff
                  WHERE
                      ff.ref_id = a.ref_id
                  AND ff.system_name = a.system_name
                ) AS ary_treat_system
               ,d.parameter
               ,d.influentflag 
               ,d.influentconcentration
               ,d.effluentflag 
               ,d.effluentconcentration
               ,d.effluentunits
               ,d.updateremovalflag 
               ,d.updateremoval
               ,h.authors
               ,h.main_author
               ,h.refdate
               ,a.ref_id
               ,a.system_name
               ,d.paramid
               FROM
               iwtt.treatment_system a 
               LEFT JOIN 
               iwtt.key_psc b 
               ON 
               a.psc_code = b.psc_code
               LEFT JOIN 
               iwtt.parameter d 
               ON 
                   a.ref_id      = d.ref_id
               AND a.system_name = d.system_name
               LEFT JOIN 
               iwtt.key_parameter_code b 
               ON 
               d.paramid = b.paramid
               LEFT JOIN 
               iwtt.treatment_units f 
               ON 
                   a.ref_id      = f.ref_id
               AND a.system_name = f.system_name
               LEFT JOIN 
               iwtt.key_treatment_tech_codes g
               ON 
               f.tt_code = g.tt_code
               LEFT JOIN
               iwtt.reference_info h
               ON
               a.ref_id = h.ref_id
               WHERE
               ( 
                  ary_psc_codes IS NULL 
                  OR 
                  a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
               ) AND ( 
                  str_psc_desc IS NULL 
                  OR 
                  UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
               ) AND ( 
                  ary_tt_codes IS NULL 
                  OR 
                  UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
               ) AND (
                  str_tt_desc IS NULL 
                  OR 
                  UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
               ) AND ( 
                  (ary_poll_search IS NULL AND str_regexp_pst IS NULL) 
                  OR
                  UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
                  OR 
                  REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
               ) AND (
                  ary_parameter IS NULL
                  OR
                  UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
               )
               GROUP BY
                a.industry
               ,a.scale
               ,d.parameter
               ,d.influentflag 
               ,d.influentconcentration
               ,d.effluentflag 
               ,d.effluentconcentration
               ,d.effluentunits
               ,d.updateremovalflag 
               ,d.updateremoval
               ,h.authors
               ,h.main_author
               ,h.refdate
               ,a.ref_id
               ,a.system_name
               ,d.paramid
            ) xd
            ORDER BY
             xd.ref_id
            ,xd.industry
            ,xd.paramid
         ) AS iwtt.dz_json_element2_obj_vry)
      )
      INTO obj_Details
      FROM
      dual;
      
      --------------------------------------------------------------------------
      -- Step 90
      -- Build the Output object
      --------------------------------------------------------------------------
      obj_output := iwtt.dz_json_element1_obj(
         p_elements => iwtt.dz_json_element1_vry(
             obj_CountIndustry
            ,obj_CountSystem
            ,obj_CountSystemFull
            ,obj_CountSystemPilot
            ,obj_CountPollutant
            ,obj_Industries
            ,obj_Technologies
            ,obj_Pollutants
            ,obj_Details
         )
      );

      --------------------------------------------------------------------------
      -- Step 100
      -- Convert results to clob
      --------------------------------------------------------------------------
      clb_output := obj_output.toJSON(
         p_pretty_print    => num_pretty_print + 1
      );
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Cough out what we got
      --------------------------------------------------------------------------      
      clob2htp(
         jsend_success(
             p_data           => clb_output
            ,p_jsonp_callback => NULL
            ,p_pretty_print   => num_pretty_print
          )
         ,p_mute => boo_mute
      );
      
   END guid_search_jsonv01;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE guid_search_i_csvv01(
       p_point_source_category_code IN  VARCHAR2 DEFAULT NULL
      ,p_point_source_category_desc IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_code  IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_desc  IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term      IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term_wc   IN  VARCHAR2 DEFAULT NULL
      ,p_parameter_desc             IN  VARCHAR2 DEFAULT NULL
      ,p_filename_override          IN  VARCHAR2 DEFAULT NULL
      ,p_add_bom                    IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      str_filename         VARCHAR2(4000 Char) := p_filename_override;
      str_status_message   VARCHAR2(4000 Char);
      num_return_code      NUMBER;
      curs_mine            SYS_REFCURSOR;
      
      ary_psc_codes        MDSYS.SDO_NUMBER_ARRAY;
      str_psc_desc         VARCHAR2(32000 Char);
      ary_tt_codes         MDSYS.SDO_STRING2_ARRAY;
      str_tt_desc          VARCHAR2(32000 Char);
      ary_poll_search      MDSYS.SDO_STRING2_ARRAY;
      str_regexp_pst       VARCHAR2(32000 Char);
      ary_parameter        MDSYS.SDO_STRING2_ARRAY;
      boo_add_bom          BOOLEAN;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      boo_add_bom := c2b(p_add_bom);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Determine the filename
      --------------------------------------------------------------------------
      IF str_filename IS NULL
      THEN
         str_filename := get_filename('GuidedSearchIndustries','.csv');
         
      END IF;
     
      --------------------------------------------------------------------------
      -- Step 30
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      guid_parameters(
          p_point_source_category_code => p_point_source_category_code
         ,p_point_source_category_desc => p_point_source_category_desc
         ,p_treatment_technology_code  => p_treatment_technology_code
         ,p_treatment_technology_desc  => p_treatment_technology_desc
         ,p_pollutant_search_term      => p_pollutant_search_term
         ,p_pollutant_search_term_wc   => p_pollutant_search_term_wc
         ,p_parameter_desc             => p_parameter_desc
         ,p_ary_psc_codes              => ary_psc_codes
         ,p_str_psc_desc               => str_psc_desc
         ,p_ary_tt_codes               => ary_tt_codes
         ,p_str_tt_desc                => str_tt_desc
         ,p_ary_poll_search            => ary_poll_search
         ,p_str_regexp_pst             => str_regexp_pst
         ,p_ary_parameter              => ary_parameter
         ,p_status_message             => str_status_message
         ,p_return_code                => num_return_code
      );
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Query the reference items
      --------------------------------------------------------------------------
      OPEN curs_mine 
      FOR
      SELECT
       a.psc_code                    AS "PSCCode"
      ,a.industry                    AS "PSCName"
      ,COUNT(DISTINCT a.system_name) AS "CountSystembyInd"
      ,COUNT(DISTINCT d.parameter)   AS "CountPollbyInd"
      FROM
      iwtt.treatment_system a 
      LEFT JOIN 
      iwtt.key_psc b 
      ON 
      a.psc_code = b.psc_code
      LEFT JOIN 
      iwtt.parameter d 
      ON 
          a.ref_id      = d.ref_id
      AND a.system_name = d.system_name
      LEFT JOIN 
      iwtt.key_parameter_code b 
      ON 
      d.paramid = b.paramid
      LEFT JOIN 
      iwtt.treatment_units f 
      ON 
          a.ref_id      = f.ref_id
      AND a.system_name = f.system_name
      LEFT JOIN 
      iwtt.key_treatment_tech_codes g
      ON 
      f.tt_code = g.tt_code
      WHERE
      ( 
         ary_psc_codes IS NULL 
         OR 
         a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
      ) AND ( 
         str_psc_desc IS NULL 
         OR 
         UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
      ) AND ( 
         ary_tt_codes IS NULL 
         OR 
         UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
      ) AND (
         str_tt_desc IS NULL 
         OR 
         UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
      ) AND ( 
         (ary_poll_search IS NULL AND str_regexp_pst IS NULL) 
         OR
         UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
         OR 
         REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
      ) AND (
         ary_parameter IS NULL
         OR
         UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
      )
      GROUP BY
       a.industry
      ,a.psc_code;
            
      --------------------------------------------------------------------------
      -- Step 50
      -- Write out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format  => 'CSV'
         ,p_cache          => NULL
         ,p_filename       => str_filename
      );
      
      ref2csv(
          p_input          => curs_mine
         ,p_column_headers => TRUE
         ,p_add_bom        => boo_add_bom
      );
      
   END guid_search_i_csvv01;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE guid_search_t_csvv01(
       p_point_source_category_code IN  VARCHAR2 DEFAULT NULL
      ,p_point_source_category_desc IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_code  IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_desc  IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term      IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term_wc   IN  VARCHAR2 DEFAULT NULL
      ,p_parameter_desc             IN  VARCHAR2 DEFAULT NULL
      ,p_filename_override          IN  VARCHAR2 DEFAULT NULL
      ,p_add_bom                    IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      str_filename         VARCHAR2(4000 Char) := p_filename_override;
      str_status_message   VARCHAR2(4000 Char);
      num_return_code      NUMBER;
      curs_mine            SYS_REFCURSOR;
      
      ary_psc_codes        MDSYS.SDO_NUMBER_ARRAY;
      str_psc_desc         VARCHAR2(32000 Char);
      ary_tt_codes         MDSYS.SDO_STRING2_ARRAY;
      str_tt_desc          VARCHAR2(32000 Char);
      ary_poll_search      MDSYS.SDO_STRING2_ARRAY;
      str_regexp_pst       VARCHAR2(32000 Char);
      ary_parameter        MDSYS.SDO_STRING2_ARRAY;
      boo_add_bom          BOOLEAN;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      boo_add_bom := c2b(p_add_bom);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Determine the filename
      --------------------------------------------------------------------------
      IF str_filename IS NULL
      THEN
         str_filename := get_filename('GuidedSearchTechnologies','.csv');
         
      END IF;
     
      --------------------------------------------------------------------------
      -- Step 30
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      guid_parameters(
          p_point_source_category_code => p_point_source_category_code
         ,p_point_source_category_desc => p_point_source_category_desc
         ,p_treatment_technology_code  => p_treatment_technology_code
         ,p_treatment_technology_desc  => p_treatment_technology_desc
         ,p_pollutant_search_term      => p_pollutant_search_term
         ,p_pollutant_search_term_wc   => p_pollutant_search_term_wc
         ,p_parameter_desc             => p_parameter_desc
         ,p_ary_psc_codes              => ary_psc_codes
         ,p_str_psc_desc               => str_psc_desc
         ,p_ary_tt_codes               => ary_tt_codes
         ,p_str_tt_desc                => str_tt_desc
         ,p_ary_poll_search            => ary_poll_search
         ,p_str_regexp_pst             => str_regexp_pst
         ,p_ary_parameter              => ary_parameter
         ,p_status_message             => str_status_message
         ,p_return_code                => num_return_code
      );
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Query the reference items
      --------------------------------------------------------------------------
      OPEN curs_mine 
      FOR
      SELECT
       MAX(g.tt_name)                AS "TreatmentTech"
      ,f.tt_code                     AS "TreatmentTechCode"
      ,COUNT(DISTINCT a.system_name) AS "CountSystembyTech"
      ,COUNT(DISTINCT a.industry)    AS "CountIndbyTech"
      ,COUNT(DISTINCT d.paramid)     AS "CountPollbyTech"
      FROM
      iwtt.treatment_system a 
      LEFT JOIN 
      iwtt.key_psc b 
      ON 
      a.psc_code = b.psc_code
      LEFT JOIN 
      iwtt.parameter d 
      ON 
          a.ref_id      = d.ref_id
      AND a.system_name = d.system_name
      LEFT JOIN 
      iwtt.key_parameter_code b 
      ON 
      d.paramid = b.paramid
      LEFT JOIN 
      iwtt.treatment_units f 
      ON 
          a.ref_id      = f.ref_id
      AND a.system_name = f.system_name
      LEFT JOIN 
      iwtt.key_treatment_tech_codes g
      ON 
      f.tt_code = g.tt_code
      WHERE
      ( 
         ary_psc_codes IS NULL 
         OR 
         a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
      ) AND ( 
         str_psc_desc IS NULL 
         OR 
         UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
      ) AND ( 
         ary_tt_codes IS NULL 
         OR 
         UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
      ) AND (
         str_tt_desc IS NULL 
         OR 
         UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
      ) AND ( 
         (ary_poll_search IS NULL AND str_regexp_pst IS NULL) 
         OR
         UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
         OR 
         REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
      ) AND (
         ary_parameter IS NULL
         OR
         UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
      )
      GROUP BY
      f.tt_code;
               
      --------------------------------------------------------------------------
      -- Step 50
      -- Write out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format  => 'CSV'
         ,p_cache          => NULL
         ,p_filename       => str_filename
      );
   
      ref2csv(
          p_input          => curs_mine
         ,p_column_headers => TRUE
         ,p_add_bom        => boo_add_bom
      );
      
   END guid_search_t_csvv01;   
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE guid_search_p_csvv01(
       p_point_source_category_code IN  VARCHAR2 DEFAULT NULL
      ,p_point_source_category_desc IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_code  IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_desc  IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term      IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term_wc   IN  VARCHAR2 DEFAULT NULL
      ,p_parameter_desc             IN  VARCHAR2 DEFAULT NULL
      ,p_filename_override          IN  VARCHAR2 DEFAULT NULL
      ,p_add_bom                    IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      str_filename         VARCHAR2(4000 Char) := p_filename_override;
      str_status_message   VARCHAR2(4000 Char);
      num_return_code      NUMBER;
      curs_mine            SYS_REFCURSOR;
      
      ary_psc_codes        MDSYS.SDO_NUMBER_ARRAY;
      str_psc_desc         VARCHAR2(32000 Char);
      ary_tt_codes         MDSYS.SDO_STRING2_ARRAY;
      str_tt_desc          VARCHAR2(32000 Char);
      ary_poll_search      MDSYS.SDO_STRING2_ARRAY;
      str_regexp_pst       VARCHAR2(32000 Char);
      ary_parameter        MDSYS.SDO_STRING2_ARRAY;
      boo_add_bom          BOOLEAN;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      boo_add_bom := c2b(p_add_bom);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Determine the filename
      --------------------------------------------------------------------------
      IF str_filename IS NULL
      THEN
         str_filename := get_filename('GuidedSearchParameters','.csv');
         
      END IF;
     
      --------------------------------------------------------------------------
      -- Step 30
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      guid_parameters(
          p_point_source_category_code => p_point_source_category_code
         ,p_point_source_category_desc => p_point_source_category_desc
         ,p_treatment_technology_code  => p_treatment_technology_code
         ,p_treatment_technology_desc  => p_treatment_technology_desc
         ,p_pollutant_search_term      => p_pollutant_search_term
         ,p_pollutant_search_term_wc   => p_pollutant_search_term_wc
         ,p_parameter_desc             => p_parameter_desc
         ,p_ary_psc_codes              => ary_psc_codes
         ,p_str_psc_desc               => str_psc_desc
         ,p_ary_tt_codes               => ary_tt_codes
         ,p_str_tt_desc                => str_tt_desc
         ,p_ary_poll_search            => ary_poll_search
         ,p_str_regexp_pst             => str_regexp_pst
         ,p_ary_parameter              => ary_parameter
         ,p_status_message             => str_status_message
         ,p_return_code                => num_return_code
      );
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Query the reference items
      --------------------------------------------------------------------------
      OPEN curs_mine 
      FOR
      SELECT
       MAX(d.parameter)              AS "ParameterName"
      ,COUNT(DISTINCT d.system_name) AS "CountSystembyPoll"
      ,COUNT(DISTINCT a.industry)    AS "CountIndbyPoll"
      FROM
      iwtt.treatment_system a 
      LEFT JOIN 
      iwtt.key_psc b 
      ON 
      a.psc_code = b.psc_code
      LEFT JOIN 
      iwtt.parameter d 
      ON 
          a.ref_id      = d.ref_id
      AND a.system_name = d.system_name
      LEFT JOIN 
      iwtt.key_parameter_code b 
      ON 
      d.paramid = b.paramid
      LEFT JOIN 
      iwtt.treatment_units f 
      ON 
          a.ref_id      = f.ref_id
      AND a.system_name = f.system_name
      LEFT JOIN 
      iwtt.key_treatment_tech_codes g
      ON 
      f.tt_code = g.tt_code
      WHERE
      ( 
         ary_psc_codes IS NULL 
         OR 
         a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
      ) AND ( 
         str_psc_desc IS NULL 
         OR 
         UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
      ) AND ( 
         ary_tt_codes IS NULL 
         OR 
         UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
      ) AND (
         str_tt_desc IS NULL 
         OR 
         UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
      ) AND ( 
         (ary_poll_search IS NULL AND str_regexp_pst IS NULL) 
         OR
         UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
         OR 
         REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
      ) AND (
         ary_parameter IS NULL
         OR
         UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
      )
      GROUP BY
      d.paramid;
               
      --------------------------------------------------------------------------
      -- Step 50
      -- Write out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format  => 'CSV'
         ,p_cache          => NULL
         ,p_filename       => str_filename
      );
   
      ref2csv(
          p_input          => curs_mine
         ,p_column_headers => TRUE
         ,p_add_bom        => boo_add_bom
      );
      
   END guid_search_p_csvv01; 
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE guid_search_d_csvv01(
       p_point_source_category_code IN  VARCHAR2 DEFAULT NULL
      ,p_point_source_category_desc IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_code  IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_desc  IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term      IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term_wc   IN  VARCHAR2 DEFAULT NULL
      ,p_parameter_desc             IN  VARCHAR2 DEFAULT NULL
      ,p_filename_override          IN  VARCHAR2 DEFAULT NULL
      ,p_add_bom                    IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      str_filename         VARCHAR2(4000 Char) := p_filename_override;
      str_status_message   VARCHAR2(4000 Char);
      num_return_code      NUMBER;
      curs_mine            SYS_REFCURSOR;
      
      ary_psc_codes        MDSYS.SDO_NUMBER_ARRAY;
      str_psc_desc         VARCHAR2(32000 Char);
      ary_tt_codes         MDSYS.SDO_STRING2_ARRAY;
      str_tt_desc          VARCHAR2(32000 Char);
      ary_poll_search      MDSYS.SDO_STRING2_ARRAY;
      str_regexp_pst       VARCHAR2(32000 Char);
      ary_parameter        MDSYS.SDO_STRING2_ARRAY;
      boo_add_bom          BOOLEAN;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      boo_add_bom := c2b(p_add_bom);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Determine the filename
      --------------------------------------------------------------------------
      IF str_filename IS NULL
      THEN
         str_filename := get_filename('GuidedSearchDetails','.csv');
         
      END IF;
     
      --------------------------------------------------------------------------
      -- Step 30
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      guid_parameters(
          p_point_source_category_code => p_point_source_category_code
         ,p_point_source_category_desc => p_point_source_category_desc
         ,p_treatment_technology_code  => p_treatment_technology_code
         ,p_treatment_technology_desc  => p_treatment_technology_desc
         ,p_pollutant_search_term      => p_pollutant_search_term
         ,p_pollutant_search_term_wc   => p_pollutant_search_term_wc
         ,p_parameter_desc             => p_parameter_desc
         ,p_ary_psc_codes              => ary_psc_codes
         ,p_str_psc_desc               => str_psc_desc
         ,p_ary_tt_codes               => ary_tt_codes
         ,p_str_tt_desc                => str_tt_desc
         ,p_ary_poll_search            => ary_poll_search
         ,p_str_regexp_pst             => str_regexp_pst
         ,p_ary_parameter              => ary_parameter
         ,p_status_message             => str_status_message
         ,p_return_code                => num_return_code
      );
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Query the reference items
      --------------------------------------------------------------------------
      OPEN curs_mine 
      FOR
      SELECT
       a.industry          AS "PSCName"
      ,a.scale             AS "ScaleSystem"
      ,(
         SELECT
         LISTAGG(ff.tt_code,', ') WITHIN GROUP (ORDER BY ff.tt_code_order)
         FROM
         iwtt.treatment_units ff
         WHERE
             ff.ref_id      = a.ref_id
         AND ff.system_name = a.system_name
       ) AS "TreatmentSystem"
      ,d.parameter         AS "ParameterName"
      ,d.influentflag      AS "InfluentFlag"
      ,d.influentconcentration AS "InfluentConcentration"
      ,d.effluentflag      AS "EffluentFlag"
      ,d.effluentconcentration AS "EffluentConcentration"
      ,d.effluentunits     AS "Units"
      ,d.updateremovalflag AS "UpdateRemovalFlag" 
      ,d.updateremoval     AS "UpdateRemoval"
      ,h.authors           AS "Authors"
      ,h.main_author       AS "MainAuthor"
      ,h.refdate           AS "Year"
      ,a.ref_id            AS "RefID"
      ,a.system_name       AS "System_Name"
      ,d.paramid           AS "ParameterID"
      FROM
      iwtt.treatment_system a 
      LEFT JOIN 
      iwtt.key_psc b 
      ON 
      a.psc_code = b.psc_code
      LEFT JOIN 
      iwtt.parameter d 
      ON 
          a.ref_id      = d.ref_id
      AND a.system_name = d.system_name
      LEFT JOIN 
      iwtt.key_parameter_code b 
      ON 
      d.paramid = b.paramid
      LEFT JOIN 
      iwtt.treatment_units f 
      ON 
          a.ref_id      = f.ref_id
      AND a.system_name = f.system_name
      LEFT JOIN 
      iwtt.key_treatment_tech_codes g
      ON 
      f.tt_code = g.tt_code
      LEFT JOIN
      iwtt.reference_info h
      ON
      a.ref_id = h.ref_id
      WHERE
      ( 
         ary_psc_codes IS NULL 
         OR 
         a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
      ) AND ( 
         str_psc_desc IS NULL 
         OR 
         UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
      ) AND ( 
         ary_tt_codes IS NULL 
         OR 
         UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
      ) AND (
         str_tt_desc IS NULL 
         OR 
         UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
      ) AND ( 
         (ary_poll_search IS NULL AND str_regexp_pst IS NULL) 
         OR
         UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
         OR 
         REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
      ) AND (
         ary_parameter IS NULL
         OR
         UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
      )
      GROUP BY
       a.industry
      ,a.scale
      ,d.parameter
      ,d.influentflag 
      ,d.influentconcentration
      ,d.effluentflag 
      ,d.effluentconcentration
      ,d.effluentunits
      ,d.updateremovalflag 
      ,d.updateremoval
      ,h.authors
      ,h.main_author
      ,h.refdate
      ,a.ref_id
      ,a.system_name
      ,d.paramid
      ORDER BY
       a.ref_id
      ,a.industry
      ,d.paramid;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Write out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format  => 'CSV'
         ,p_cache          => NULL
         ,p_filename       => str_filename
      );
   
      ref2csv(
          p_input          => curs_mine
         ,p_column_headers => TRUE
         ,p_add_bom        => boo_add_bom
      );
      
   END guid_search_d_csvv01; 
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE guid_search_raw(
       p_point_source_category_code IN  VARCHAR2 DEFAULT NULL
      ,p_point_source_category_desc IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_code  IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_desc  IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term      IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term_wc   IN  VARCHAR2 DEFAULT NULL
      ,p_parameter_desc             IN  VARCHAR2 DEFAULT NULL
      ,p_filename_override          IN  VARCHAR2 DEFAULT NULL
      ,p_add_bom                    IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      str_filename         VARCHAR2(4000 Char) := p_filename_override;
      str_status_message   VARCHAR2(4000 Char);
      num_return_code      NUMBER;
      curs_mine            SYS_REFCURSOR;
      
      ary_psc_codes        MDSYS.SDO_NUMBER_ARRAY;
      str_psc_desc         VARCHAR2(32000 Char);
      ary_tt_codes         MDSYS.SDO_STRING2_ARRAY;
      str_tt_desc          VARCHAR2(32000 Char);
      ary_poll_search      MDSYS.SDO_STRING2_ARRAY;
      str_regexp_pst       VARCHAR2(32000 Char);
      ary_parameter        MDSYS.SDO_STRING2_ARRAY;
      boo_add_bom          BOOLEAN;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      boo_add_bom := c2b(p_add_bom);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Determine the filename
      --------------------------------------------------------------------------
      IF str_filename IS NULL
      THEN
         str_filename := get_filename('GuidedSearchDetails','.csv');
         
      END IF;
     
      --------------------------------------------------------------------------
      -- Step 30
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      guid_parameters(
          p_point_source_category_code => p_point_source_category_code
         ,p_point_source_category_desc => p_point_source_category_desc
         ,p_treatment_technology_code  => p_treatment_technology_code
         ,p_treatment_technology_desc  => p_treatment_technology_desc
         ,p_pollutant_search_term      => p_pollutant_search_term
         ,p_pollutant_search_term_wc   => p_pollutant_search_term_wc
         ,p_parameter_desc             => p_parameter_desc
         ,p_ary_psc_codes              => ary_psc_codes
         ,p_str_psc_desc               => str_psc_desc
         ,p_ary_tt_codes               => ary_tt_codes
         ,p_str_tt_desc                => str_tt_desc
         ,p_ary_poll_search            => ary_poll_search
         ,p_str_regexp_pst             => str_regexp_pst
         ,p_ary_parameter              => ary_parameter
         ,p_status_message             => str_status_message
         ,p_return_code                => num_return_code
      );
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Query the reference items
      --------------------------------------------------------------------------
      OPEN curs_mine 
      FOR
      SELECT
       a.ref_id
      ,a.system_name
      ,a.scale
      ,d.paramid
      ,d.parameter
      ,f.tt_code
      ,g.tt_name
      ,a.psc_code
      ,b.psc_desc
      ,b.pollutant_search_term
      FROM
      iwtt.treatment_system a 
      LEFT JOIN 
      iwtt.key_psc b 
      ON 
      a.psc_code = b.psc_code
      LEFT JOIN 
      iwtt.parameter d 
      ON 
          a.ref_id      = d.ref_id
      AND a.system_name = d.system_name
      LEFT JOIN 
      iwtt.key_parameter_code b 
      ON 
      d.paramid = b.paramid
      LEFT JOIN 
      iwtt.treatment_units f 
      ON 
          a.ref_id      = f.ref_id
      AND a.system_name = f.system_name
      LEFT JOIN 
      iwtt.key_treatment_tech_codes g
      ON 
      f.tt_code = g.tt_code
      LEFT JOIN
      iwtt.reference_info h
      ON
      a.ref_id = h.ref_id
      WHERE
      ( 
         ary_psc_codes IS NULL 
         OR 
         a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
      ) AND ( 
         str_psc_desc IS NULL 
         OR 
         UPPER(b.psc_desc) LIKE '%' || str_psc_desc || '%'
      ) AND ( 
         ary_tt_codes IS NULL 
         OR 
         UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
      ) AND (
         str_tt_desc IS NULL 
         OR 
         UPPER(g.tt_name) LIKE '%' || str_tt_desc || '%'
      ) AND ( 
         (ary_poll_search IS NULL AND str_regexp_pst IS NULL) 
         OR
         UPPER(b.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
         OR 
         REGEXP_INSTR(UPPER(b.pollutant_search_term),str_regexp_pst) > 0
      ) AND (
         ary_parameter IS NULL
         OR
         UPPER(d.parameter) IN (SELECT * FROM TABLE(ary_parameter))
      );
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Write out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format  => 'CSV'
         ,p_cache          => NULL
         ,p_filename       => str_filename
      );
   
      ref2csv(
          p_input          => curs_mine
         ,p_column_headers => TRUE
         ,p_add_bom        => boo_add_bom
      );
      
   END guid_search_raw; 
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE art_parameters(
       p_point_source_category_code IN  VARCHAR2 
      ,p_point_source_category_desc IN  VARCHAR2
      ,p_treatment_technology_code  IN  VARCHAR2
      ,p_treatment_technology_desc  IN  VARCHAR2
      ,p_treatment_scale            IN  VARCHAR2
      ,p_pollutant_search_term      IN  VARCHAR2
      ,p_pollutant_search_term_wc   IN  VARCHAR2
      ,p_parameter_desc             IN  VARCHAR2
      ,p_percent_removal_flag       IN  VARCHAR2
      ,p_percent_min                IN  VARCHAR2 
      ,p_percent_max                IN  VARCHAR2 
      ,p_SIC                        IN  VARCHAR2
      ,p_NAICS                      IN  VARCHAR2
      ,p_year_min                   IN  VARCHAR2
      ,p_year_max                   IN  VARCHAR2
      ,p_motivation_category        IN  VARCHAR2
      ,p_document_type              IN  VARCHAR2
      ,p_keyword                    IN  VARCHAR2
      ,p_author                     IN  VARCHAR2
      ,p_ary_psc_codes              OUT MDSYS.SDO_NUMBER_ARRAY
      ,p_str_psc_desc               OUT VARCHAR2
      ,p_ary_tt_codes               OUT MDSYS.SDO_STRING2_ARRAY
      ,p_str_tt_desc                OUT VARCHAR2
      ,p_ary_scales                 OUT MDSYS.SDO_STRING2_ARRAY
      ,p_str_regexp_scales          OUT VARCHAR2
      ,p_ary_poll_search            OUT MDSYS.SDO_STRING2_ARRAY
      ,p_str_regexp_pst             OUT VARCHAR2
      ,p_ary_parameter_desc         OUT MDSYS.SDO_STRING2_ARRAY
      ,p_str_perc_remove            OUT VARCHAR2
      ,p_num_percent_min            OUT NUMBER
      ,p_num_percent_max            OUT NUMBER
      ,p_ary_sic_codes              OUT MDSYS.SDO_NUMBER_ARRAY
      ,p_ary_naics_codes            OUT MDSYS.SDO_NUMBER_ARRAY
      ,p_num_year_min               OUT NUMBER
      ,p_num_year_max               OUT NUMBER
      ,p_ary_motivation             OUT MDSYS.SDO_STRING2_ARRAY
      ,p_ary_doc_types              OUT MDSYS.SDO_STRING2_ARRAY
      ,p_ary_keyword                OUT MDSYS.SDO_STRING2_ARRAY
      ,p_str_regexp_keyword         OUT VARCHAR2
      ,p_ary_authors                OUT MDSYS.SDO_STRING2_ARRAY
      ,p_str_regexp_authors         OUT VARCHAR2
      ,p_status_message             OUT VARCHAR2
      ,p_return_code                OUT NUMBER
   )
   AS
      str_poll_search_wc VARCHAR2(4000 Char) := UPPER(p_pollutant_search_term_wc);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      p_status_message := '';
      p_return_code    := 0;
      
      IF str_poll_search_wc IS NULL 
      OR str_poll_search_wc NOT IN ('TRUE','FALSE')
      THEN
         str_poll_search_wc := 'FALSE';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Parse point source category items
      --------------------------------------------------------------------------
      IF p_point_source_category_code IS NOT NULL
      THEN
         p_ary_psc_codes := dz_json_util.strings2numbers(
            dz_json_util.gz_split(
                p_point_source_category_code
               ,g_delimiter
            )
         );
         
         IF p_ary_psc_codes IS NULL
         OR p_ary_psc_codes.COUNT = 0
         THEN
            p_status_message := p_status_message || 'Unable to parse p_point_source_category_code as one or more numeric codes. ';
            p_return_code    := -20;
            
         END IF;
               
      END IF;
      
      IF p_point_source_category_desc IS NOT NULL
      THEN
         p_str_psc_desc := UPPER(p_point_source_category_desc);
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Parse treatment_technology items
      --------------------------------------------------------------------------
      IF p_treatment_technology_code IS NOT NULL
      THEN
         p_ary_tt_codes := dz_json_util.gz_split(
             UPPER(p_treatment_technology_code)
            ,g_delimiter
         );
         
         p_ary_tt_codes := treatment_tech_code_expander(p_ary_tt_codes);
               
      END IF;
      
      IF p_treatment_technology_desc IS NOT NULL
      THEN
         p_str_tt_desc := UPPER(p_treatment_technology_desc);
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Parse scales 
      --------------------------------------------------------------------------
      IF p_treatment_scale IS NOT NULL
      THEN
         p_ary_scales := dz_json_util.gz_split(
             UPPER(p_treatment_scale)
            ,g_delimiter
         );
         
         FOR i IN 1 .. p_ary_scales.COUNT
         LOOP
            IF p_ary_scales(i) = 'BOTH'
            THEN
               p_ary_scales := NULL;
               
            END IF;
            
         END LOOP;
         
         IF p_ary_scales IS NOT NULL
         AND p_ary_scales.COUNT > 0
         THEN
            p_str_regexp_scales := '(' || escape_regex(p_ary_scales(1));
            
            IF p_ary_scales.COUNT > 1
            THEN
               FOR i IN 2 .. p_ary_scales.COUNT
               LOOP
                  p_str_regexp_scales := p_str_regexp_scales || '|' || escape_regex(p_ary_scales(i));
                  
               END LOOP;
            
            END IF;
            
            p_str_regexp_scales := p_str_regexp_scales || ')';
            
         END IF;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Parse p_pollutant_search_term 
      --------------------------------------------------------------------------
      IF p_pollutant_search_term IS NOT NULL
      THEN
         p_ary_poll_search := dz_json_util.gz_split(
             UPPER(p_pollutant_search_term )
            ,g_delimiter
         );
         
         IF str_poll_search_wc = 'TRUE'
         THEN         
            p_str_regexp_pst := '(' || escape_regex(p_ary_poll_search(1));
            
            IF p_ary_poll_search.COUNT > 1
            THEN
               FOR i IN 2 .. p_ary_poll_search.COUNT
               LOOP
                  p_str_regexp_pst := p_str_regexp_pst || '|' || escape_regex(p_ary_poll_search(i));
                  
               END LOOP;
            
            END IF;
            
            p_str_regexp_pst := p_str_regexp_pst || ')';
            
            p_ary_poll_search := NULL;
            
         END IF;
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Parse parameter items
      --------------------------------------------------------------------------
      IF p_parameter_desc IS NOT NULL
      THEN
         p_ary_parameter_desc := dz_json_util.gz_split(
             UPPER(p_parameter_desc)
            ,g_delimiter
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Parse percent removal items
      --------------------------------------------------------------------------
      IF p_percent_removal_flag IS NOT NULL
      THEN
         IF UPPER(p_percent_removal_flag) IN ('Y','YES','T','TRUE')
         THEN
            p_str_perc_remove := 'Y';
         
         ELSE
            p_str_perc_remove := 'N';
            
         END IF;      
      
      END IF;
      
      IF p_percent_min IS NOT NULL
      THEN
         p_num_percent_min := dz_json_util.safe_to_number(p_percent_min);
         
         IF p_num_percent_min IS NULL
         THEN
            p_status_message := p_status_message || 'Unable to parse p_percent_min as a numeric value. ';
            p_return_code    := -60;
            
         ELSIF p_num_percent_min <= 0 OR p_num_percent_min > 100
         THEN
            p_status_message := p_status_message || 'Parameter p_percent_min must be a numeric value more than zero and less than or equal to 100. ';
            p_return_code    := -60;
         
         END IF;
         
      END IF;
      
      IF p_percent_max IS NOT NULL
      THEN
         p_num_percent_max := dz_json_util.safe_to_number(p_percent_max);
         
         IF p_num_percent_max IS NULL
         THEN
            p_status_message := p_status_message || 'Unable to parse p_percent_max as a numeric value. ';
            p_return_code    := -60;
            
         ELSIF p_num_percent_max <= 0 OR p_num_percent_max > 100
         THEN
            p_status_message := p_status_message || 'Parameter p_percent_max must be a numeric value more than zero and less than or equal to 100. ';
            p_return_code    := -60;
         
         END IF;
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 80
      -- Parse sic and naics codes
      --------------------------------------------------------------------------
      IF p_SIC IS NOT NULL
      THEN
         p_ary_sic_codes := dz_json_util.strings2numbers(
            dz_json_util.gz_split(
                p_SIC
               ,g_delimiter
            )
         );
         
         IF p_ary_sic_codes IS NULL
         OR p_ary_sic_codes.COUNT = 0
         THEN
            p_status_message := p_status_message || 'Unable to parse p_SIC as one or more numeric codes. ';
            p_return_code    := -20;
            
         END IF;
               
      END IF;
      
      IF p_NAICS IS NOT NULL
      THEN
         p_ary_naics_codes := dz_json_util.strings2numbers(
            dz_json_util.gz_split(
                p_NAICS
               ,g_delimiter
            )
         );
         
         IF p_ary_naics_codes IS NULL
         OR p_ary_naics_codes.COUNT = 0
         THEN
            p_status_message := p_status_message || 'Unable to parse p_NAICS as one or more numeric codes. ';
            p_return_code    := -20;
            
         END IF;
               
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 90
      -- Parse year min and year max
      --------------------------------------------------------------------------
      IF p_year_min IS NOT NULL
      THEN
         p_num_year_min := dz_json_util.safe_to_number(p_year_min);
         
         IF p_num_year_min IS NULL
         THEN
            p_status_message := p_status_message || 'Unable to parse p_year_min as a year value. ';
            p_return_code    := -60;
            
         END IF;
         
      END IF;
      
      IF p_year_max IS NOT NULL
      THEN
         p_num_year_max := dz_json_util.safe_to_number(p_year_max);
         
         IF p_num_year_max IS NULL
         THEN
            p_status_message := p_status_message || 'Unable to parse p_year_max as a year value. ';
            p_return_code    := -60;
            
         END IF;
         
      END IF;
           
      --------------------------------------------------------------------------
      -- Step 100
      -- Parse motivation and doc types
      --------------------------------------------------------------------------
      IF p_motivation_category IS NOT NULL
      THEN
         p_ary_motivation := dz_json_util.gz_split(
             UPPER(p_motivation_category)
            ,g_delimiter
         );
         
      END IF;
      
      IF p_document_type IS NOT NULL
      THEN
         p_ary_doc_types := dz_json_util.gz_split(
             UPPER(p_document_type)
            ,g_delimiter
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 110
      -- Parse keywords and authors
      --------------------------------------------------------------------------
      IF p_keyword IS NOT NULL
      THEN
         p_ary_keyword := dz_json_util.gz_split(
             UPPER(p_keyword)
            ,g_delimiter
         );
         
         p_str_regexp_keyword := '(' || escape_regex(p_ary_keyword(1));
         
         IF p_ary_keyword.COUNT > 1
         THEN
            FOR i IN 2 .. p_ary_keyword.COUNT
            LOOP
               p_str_regexp_keyword := p_str_regexp_keyword || '|' || escape_regex(p_ary_keyword(i));
               
            END LOOP;
         
         END IF;
         
         p_str_regexp_keyword := p_str_regexp_keyword || ')';
         
      END IF;
      
      IF p_author IS NOT NULL
      THEN
         p_ary_authors := dz_json_util.gz_split(
             UPPER(p_author)
            ,g_delimiter
         );
         
         p_str_regexp_authors := '(' || escape_regex(p_ary_authors(1));
         
         IF p_ary_authors.COUNT > 1
         THEN
            FOR i IN 2 .. p_ary_authors.COUNT
            LOOP
               p_str_regexp_authors := p_str_regexp_authors || '|' || escape_regex(p_ary_authors(i));
               
            END LOOP;
         
         END IF;
         
         p_str_regexp_authors := p_str_regexp_authors || ')';
         
      END IF;
   
   END art_parameters;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE art_search_jsonv01(
       p_point_source_category_code IN  VARCHAR2 DEFAULT NULL
      ,p_point_source_category_desc IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_code  IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_desc  IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_scale            IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term      IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term_wc   IN  VARCHAR2 DEFAULT NULL
      ,p_parameter_desc             IN  VARCHAR2 DEFAULT NULL
      ,p_percent_removal_flag       IN  VARCHAR2 DEFAULT NULL
      ,p_percent_min                IN  VARCHAR2 DEFAULT NULL
      ,p_percent_max                IN  VARCHAR2 DEFAULT NULL
      ,p_SIC                        IN  VARCHAR2 DEFAULT NULL
      ,p_NAICS                      IN  VARCHAR2 DEFAULT NULL
      ,p_year_min                   IN  VARCHAR2 DEFAULT NULL
      ,p_year_max                   IN  VARCHAR2 DEFAULT NULL
      ,p_motivation_category        IN  VARCHAR2 DEFAULT NULL
      ,p_document_type              IN  VARCHAR2 DEFAULT NULL
      ,p_keyword                    IN  VARCHAR2 DEFAULT NULL
      ,p_author                     IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      obj_output         iwtt.dz_json_element1_obj;
      clb_output         CLOB;
      num_pretty_print   NUMBER;
      boo_mute           BOOLEAN;
      str_status_message VARCHAR2(4000 Char);
      num_return_code    NUMBER;
      
      --  --  --  --  --  --  --  --  --  --
      ary_psc_codes      MDSYS.SDO_NUMBER_ARRAY;
      str_psc_desc       VARCHAR2(32000 Char);
      ary_tt_codes       MDSYS.SDO_STRING2_ARRAY;
      str_tt_desc        VARCHAR2(32000 Char);
      ary_scales         MDSYS.SDO_STRING2_ARRAY;
      str_regexp_scales  VARCHAR2(32000 Char);
      ary_poll_search    MDSYS.SDO_STRING2_ARRAY;
      ary_parameter_desc MDSYS.SDO_STRING2_ARRAY;
      str_perc_remove    VARCHAR2(1 Char);
      num_percent_min    NUMBER;
      num_percent_max    NUMBER;
      ary_sic_codes      MDSYS.SDO_NUMBER_ARRAY;
      ary_naics_codes    MDSYS.SDO_NUMBER_ARRAY;
      num_year_min       NUMBER;
      num_year_max       NUMBER;
      ary_motivation     MDSYS.SDO_STRING2_ARRAY;
      ary_doc_types      MDSYS.SDO_STRING2_ARRAY;
      ary_keyword        MDSYS.SDO_STRING2_ARRAY;
      str_regexp_pst     VARCHAR2(32000 Char);
      str_regexp_keyword VARCHAR2(32000 Char);
      str_regexp_authors VARCHAR2(32000 Char);
      ary_authors        MDSYS.SDO_STRING2_ARRAY;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      boo_mute := FALSE;
      
      num_pretty_print := dz_json_util.safe_to_number(p_pretty_print);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Write the header
      --------------------------------------------------------------------------
      write_header(
          p_output_format    => 'JSON'
         ,p_cache            => NULL
         ,p_json_callback    => NULL
         ,p_mute             => boo_mute
      );
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Gather the ref ids
      --------------------------------------------------------------------------
      art_parameters(
          p_point_source_category_code => p_point_source_category_code
         ,p_point_source_category_desc => p_point_source_category_desc
         ,p_treatment_technology_code  => p_treatment_technology_code
         ,p_treatment_technology_desc  => p_treatment_technology_desc
         ,p_treatment_scale            => p_treatment_scale
         ,p_pollutant_search_term      => p_pollutant_search_term
         ,p_pollutant_search_term_wc   => p_pollutant_search_term_wc
         ,p_parameter_desc             => p_parameter_desc
         ,p_percent_removal_flag       => p_percent_removal_flag
         ,p_percent_min                => p_percent_min
         ,p_percent_max                => p_percent_max
         ,p_SIC                        => p_SIC
         ,p_NAICS                      => p_NAICS
         ,p_year_min                   => p_year_min
         ,p_year_max                   => p_year_max
         ,p_motivation_category        => p_motivation_category
         ,p_document_type              => p_document_type
         ,p_keyword                    => p_keyword
         ,p_author                     => p_author
         ,p_ary_psc_codes              => ary_psc_codes
         ,p_str_psc_desc               => str_psc_desc
         ,p_ary_tt_codes               => ary_tt_codes
         ,p_str_tt_desc                => str_tt_desc
         ,p_ary_scales                 => ary_scales
         ,p_str_regexp_scales          => str_regexp_scales
         ,p_ary_poll_search            => ary_poll_search
         ,p_str_regexp_pst             => str_regexp_pst
         ,p_ary_parameter_desc         => ary_parameter_desc
         ,p_str_perc_remove            => str_perc_remove
         ,p_num_percent_min            => num_percent_min
         ,p_num_percent_max            => num_percent_max
         ,p_ary_sic_codes              => ary_sic_codes
         ,p_ary_naics_codes            => ary_naics_codes
         ,p_num_year_min               => num_year_min
         ,p_num_year_max               => num_year_max
         ,p_ary_motivation             => ary_motivation
         ,p_ary_doc_types              => ary_doc_types
         ,p_ary_keyword                => ary_keyword
         ,p_str_regexp_keyword         => str_regexp_keyword
         ,p_ary_authors                => ary_authors
         ,p_str_regexp_authors         => str_regexp_authors
         ,p_status_message             => str_status_message
         ,p_return_code                => num_return_code
      );
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Bail if problems
      --------------------------------------------------------------------------
      IF num_return_code <> 0
      THEN
         clob2htp(
             jsend_error(
                p_message        => str_status_message
               ,p_code           => num_return_code
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
            )
            ,p_mute => boo_mute
         );
         
         RETURN;
      
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Execute the query
      --------------------------------------------------------------------------
      SELECT
      iwtt.dz_json_element1_obj(
         p_elements => (
            SELECT
             iwtt.dz_json_element1_vry(
                iwtt.dz_json_element1(
                   p_name => 'CountREF_ID'
                  ,p_element_number => (
                     SELECT
                     COUNT(*)
                     FROM (
                        SELECT
                        ri.ref_id
                        FROM
                        iwtt.reference_info ri
                        LEFT JOIN 
                        iwtt.reference_motivation c 
                        ON 
                        ri.ref_id = c.ref_id
                        LEFT JOIN 
                        iwtt.treatment_system  e
                        ON 
                        ri.ref_id = e.ref_id
                        LEFT JOIN 
                        iwtt.key_psc e2 
                        ON 
                        e.psc_code = e2.psc_code
                        LEFT JOIN 
                        iwtt.key_sic e3 
                        ON 
                        e.sic_code = e3.sic_code_numeric
                        LEFT JOIN 
                        iwtt.key_naics e4 
                        ON 
                        e.naics_code = e4.naics_code
                        LEFT JOIN 
                        iwtt.parameter d
                        ON 
                            ri.ref_id = d.ref_id
                        AND e.system_name = d.system_name
                        LEFT JOIN 
                        iwtt.key_parameter_code d1 
                        ON 
                        d.paramid = d1.paramid
                        LEFT JOIN 
                        iwtt.key_performstat d2
                        ON
                        d.performstatid = d2.performstatid
                        LEFT JOIN 
                        iwtt.treatment_units f
                        ON 
                            ri.ref_id = f.ref_id
                        AND e.system_name = f.system_name
                        LEFT JOIN 
                        iwtt.key_treatment_tech_codes f2
                        ON 
                        f.tt_code = f2.tt_code
                        WHERE
                        -- Records limited to the psc codes provided
                        ( 
                           ary_psc_codes IS NULL 
                           OR 
                           e.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
                           OR
                           ri.lab_scale_psc IN (SELECT * FROM TABLE(ary_psc_codes))
                        )
                        AND -- Records limited to a case-insensitive string match
                        ( 
                           str_psc_desc IS NULL 
                           OR 
                           UPPER(e2.psc_desc) LIKE '%' || str_psc_desc || '%'
                           OR
                           UPPER(ri.lab_scale_psc_desc) LIKE '%' || str_psc_desc || '%' 
                        )
                        AND -- Records limited to the tt codes provided 
                        ( 
                           p_treatment_technology_code  IS NULL 
                           OR 
                           UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
                        )
                        AND -- Records limited to a case-insensitve string match
                        ( 
                           p_treatment_technology_desc  IS NULL 
                           OR 
                           UPPER(f2.tt_name) LIKE '%' || str_tt_desc || '%'
                        )
                        AND -- Records limited to case insenstive match
                        ( 
                           ary_scales IS NULL
                           OR
                           UPPER(e.scale) IN (SELECT * FROM TABLE(ary_scales))
                           OR
                           REGEXP_INSTR(UPPER(ri.scale),str_regexp_scales) > 0
                        )
                        AND -- Records limited to case insenstive match
                        ( 
                           p_pollutant_search_term IS NULL 
                           OR 
                           REGEXP_INSTR(UPPER(d1.pollutant_search_term),str_regexp_pst) > 0
                           OR
                           UPPER(d1.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
                        )
                        AND 
                        -- if Y then only records with a percent removal value
                        -- if N then only records without a percent removal value
                        ( 
                           p_percent_removal_flag      IS NULL 
                           OR 
                           (str_perc_remove = 'Y' AND d.updateremoval IS NOT NULL)
                           OR
                           (str_perc_remove = 'N' AND d.updateremoval IS NULL)
                        )
                        AND 
                        -- p_percent_min
                        ( 
                           p_percent_min      IS NULL 
                           OR 
                           d.updateremoval >= p_percent_min
                        )
                        AND 
                        -- p_percent_max
                        ( 
                           p_percent_max      IS NULL 
                           OR 
                           d.updateremoval <= p_percent_max
                        )
                        AND 
                        -- SIC
                        ( 
                           ary_sic_codes IS NULL 
                           OR 
                           e.sic_code IN (SELECT * FROM TABLE(ary_sic_codes))
                           OR
                           ri.lab_scale_sic IN (SELECT * FROM TABLE(ary_sic_codes))
                        )
                        AND 
                        -- NAICS
                        ( 
                           p_NAICS IS NULL 
                           OR 
                           e.naics_code IN (SELECT * FROM TABLE(ary_naics_codes))
                        )
                        AND 
                        -- p_year_min
                        ( 
                           p_year_min IS NULL 
                           OR 
                           TO_NUMBER(ri.refdate) >= num_year_min
                        )
                        AND 
                        -- p_year_max
                        ( 
                           p_year_max IS NULL 
                           OR 
                           TO_NUMBER(ri.refdate) <= num_year_max
                        )
                        AND 
                        -- motivation_category
                        ( 
                           p_motivation_category IS NULL 
                           OR 
                           UPPER(c.motivationcategory) IN (SELECT * FROM TABLE(ary_motivation))
                        )
                        AND 
                        -- document type
                        ( 
                           p_document_type IS NULL 
                           OR 
                           UPPER(ri.documenttype) IN (SELECT * FROM TABLE(ary_doc_types))
                        )
                        AND 
                        -- authors
                        ( 
                           p_author IS NULL 
                           OR 
                           REGEXP_INSTR(UPPER(ri.authors),str_regexp_authors) > 0
                        )
                        AND 
                        -- keywords
                        ( 
                           p_keyword IS NULL 
                           OR 
                           REGEXP_INSTR(UPPER(ri.title),str_regexp_keyword) > 0
                           OR
                           REGEXP_INSTR(UPPER(ri.key_findings),str_regexp_keyword) > 0
                           OR
                           REGEXP_INSTR(UPPER(ri.abstract),str_regexp_keyword) > 0
                        )
                        GROUP BY
                        ri.ref_id
                     )
                  )
               )
               ,iwtt.dz_json_element1(
                   p_name => 'Reference_Info'
                  ,p_element_obj_vry => CAST(MULTISET(
                     SELECT
                     iwtt.dz_json_element2_obj(
                        p_elements => iwtt.dz_json_element2_vry(
                           iwtt.dz_json_element2(
                               p_name           => 'Ref_ID'
                              ,p_element_number => ri.ref_id
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Authors'
                              ,p_element_string => ri.authors
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Title'
                              ,p_element_string => ri.title
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'RefDate'
                              ,p_element_string => ri.refdate
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Journal_Publisher'
                              ,p_element_string => ri.journal_publisher
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Abstract'
                              ,p_element_clob   => (SELECT xx.abstract FROM iwtt.reference_info xx WHERE xx.ref_id = ri.ref_id)
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Scale'
                              ,p_element_string => ri.scale
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'CountSystem'
                              ,p_element_number => (SELECT COUNT(*) FROM iwtt.treatment_system bb WHERE bb.ref_id = ri.ref_id)
                           )
                           /*
                           ,iwtt.dz_json_element2(
                               p_name           => 'System_Scale'
                              ,p_element_string_vry => (SELECT CAST(COLLECT(bb.scale ORDER BY bb.system_name) AS MDSYS.SDO_STRING2_ARRAY) FROM iwtt.treatment_system bb WHERE bb.ref_id = ri.ref_id)
                              ,p_unique_flag        => 'TRUE'
                           )
                           */
                        )
                     )
                     FROM
                     iwtt.reference_info ri
                     LEFT JOIN 
                     iwtt.reference_motivation c 
                     ON 
                     ri.ref_id = c.ref_id
                     LEFT JOIN 
                     iwtt.treatment_system  e
                     ON 
                     ri.ref_id = e.ref_id
                     LEFT JOIN 
                     iwtt.key_psc e2 
                     ON 
                     e.psc_code = e2.psc_code
                     LEFT JOIN 
                     iwtt.key_sic e3 
                     ON 
                     e.sic_code = e3.sic_code_numeric
                     LEFT JOIN 
                     iwtt.key_naics e4 
                     ON 
                     e.naics_code = e4.naics_code
                     LEFT JOIN 
                     iwtt.parameter d
                     ON 
                         ri.ref_id = d.ref_id
                     AND e.system_name = d.system_name
                     LEFT JOIN 
                     iwtt.key_parameter_code d1 
                     ON 
                     d.paramid = d1.paramid
                     LEFT JOIN 
                     iwtt.key_performstat d2
                     ON
                     d.performstatid = d2.performstatid
                     LEFT JOIN 
                     iwtt.treatment_units f
                     ON 
                         ri.ref_id = f.ref_id
                     AND e.system_name = f.system_name
                     LEFT JOIN 
                     iwtt.key_treatment_tech_codes f2
                     ON 
                     f.tt_code = f2.tt_code
                     WHERE
                     -- Records limited to the psc codes provided
                     ( 
                        ary_psc_codes IS NULL 
                        OR 
                        e.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
                        OR
                        ri.lab_scale_psc IN (SELECT * FROM TABLE(ary_psc_codes))
                     )
                     AND -- Records limited to a case-insensitive string match
                     ( 
                        str_psc_desc IS NULL 
                        OR 
                        UPPER(e2.psc_desc) LIKE '%' || str_psc_desc || '%'
                        OR
                        UPPER(ri.lab_scale_psc_desc) LIKE '%' || str_psc_desc || '%' 
                     )
                     AND -- Records limited to the tt codes provided 
                     ( 
                        p_treatment_technology_code  IS NULL 
                        OR 
                        UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
                     )
                     AND -- Records limited to a case-insensitve string match
                     ( 
                        p_treatment_technology_desc  IS NULL 
                        OR 
                        UPPER(f2.tt_name) LIKE '%' || str_tt_desc || '%'
                     )
                     AND -- Records limited to case insenstive match
                     ( 
                        ary_scales IS NULL
                        OR
                        UPPER(e.scale) IN (SELECT * FROM TABLE(ary_scales))
                        OR
                        REGEXP_INSTR(UPPER(ri.scale),str_regexp_scales) > 0
                     )
                     AND -- Records limited to case insenstive match
                     ( 
                        p_pollutant_search_term IS NULL 
                        OR 
                        REGEXP_INSTR(UPPER(d1.pollutant_search_term),str_regexp_pst) > 0
                        OR
                        UPPER(d1.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
                     )
                     AND 
                     -- if Y then only records with a percent removal value
                     -- if N then only records without a percent removal value
                     ( p_percent_removal_flag      IS NULL 
                        OR 
                        (
                           str_perc_remove = 'Y' AND d.updateremoval IS NOT NULL
                        )
                        OR
                        (
                           str_perc_remove = 'N' AND d.updateremoval IS NULL
                        )
                     )
                     AND 
                     -- p_percent_min
                     ( p_percent_min      IS NULL 
                        OR 
                        d.updateremoval >= p_percent_min
                     )
                     AND 
                     -- p_percent_max
                     ( p_percent_max      IS NULL 
                        OR 
                        d.updateremoval <= p_percent_max
                     )
                     AND 
                     -- SIC
                     ( 
                        ary_sic_codes IS NULL 
                        OR 
                        e.sic_code IN (SELECT * FROM TABLE(ary_sic_codes))
                        OR
                        ri.lab_scale_sic IN (SELECT * FROM TABLE(ary_sic_codes))
                     )
                     AND 
                     -- NAICS
                     ( p_NAICS IS NULL 
                        OR 
                        e.naics_code IN (SELECT * FROM TABLE(ary_naics_codes))
                     )
                     AND 
                     -- p_year_min
                     ( p_year_min IS NULL 
                        OR 
                        TO_NUMBER(ri.refdate) >= num_year_min
                     )
                     AND 
                     -- p_year_max
                     ( p_year_max IS NULL 
                        OR 
                        TO_NUMBER(ri.refdate) <= num_year_max
                     )
                     AND 
                     -- motivation_category
                     ( p_motivation_category IS NULL 
                        OR 
                        UPPER(c.motivationcategory) IN (SELECT * FROM TABLE(ary_motivation))
                     )
                     AND 
                     -- document type
                     ( p_document_type IS NULL 
                        OR 
                        UPPER(ri.documenttype) IN (SELECT * FROM TABLE(ary_doc_types))
                     )
                     AND 
                     -- authors
                     ( p_author IS NULL 
                        OR 
                        REGEXP_INSTR(UPPER(ri.authors),str_regexp_authors) > 0
                     )
                     AND 
                     -- keywords
                     ( p_keyword IS NULL 
                        OR 
                        REGEXP_INSTR(UPPER(ri.title),str_regexp_keyword) > 0
                        OR
                        REGEXP_INSTR(UPPER(ri.key_findings),str_regexp_keyword) > 0
                        OR
                        REGEXP_INSTR(UPPER(ri.abstract),str_regexp_keyword) > 0
                     )
                     GROUP BY
                      ri.ref_id
                     ,ri.authors
                     ,ri.title
                     ,ri.refdate
                     ,ri.journal_publisher
                     ,ri.scale 
                     ORDER BY
                     ri.ref_id     
                  ) AS iwtt.dz_json_element2_obj_vry)
               ) 
            )
            FROM
            dual
         )
      )
      INTO obj_output
      FROM
      dual;

      --------------------------------------------------------------------------
      -- Step 60
      -- Convert results to clob
      --------------------------------------------------------------------------
      clb_output := obj_output.toJSON(
         p_pretty_print    => num_pretty_print + 1
      );
      
      --------------------------------------------------------------------------
      -- Step 70
      -- Convert results to clob
      --------------------------------------------------------------------------      
      clob2htp(
         jsend_success(
             p_data           => clb_output
            ,p_jsonp_callback => NULL
            ,p_pretty_print   => num_pretty_print
          )
         ,p_mute => boo_mute
      );
      
   END art_search_jsonv01;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE art_search_csvv01(
       p_point_source_category_code IN  VARCHAR2 DEFAULT NULL
      ,p_point_source_category_desc IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_code  IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_technology_desc  IN  VARCHAR2 DEFAULT NULL
      ,p_treatment_scale            IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term      IN  VARCHAR2 DEFAULT NULL
      ,p_pollutant_search_term_wc   IN  VARCHAR2 DEFAULT NULL
      ,p_parameter_desc             IN  VARCHAR2 DEFAULT NULL
      ,p_percent_removal_flag       IN  VARCHAR2 DEFAULT NULL
      ,p_percent_min                IN  VARCHAR2 DEFAULT NULL
      ,p_percent_max                IN  VARCHAR2 DEFAULT NULL
      ,p_SIC                        IN  VARCHAR2 DEFAULT NULL
      ,p_NAICS                      IN  VARCHAR2 DEFAULT NULL
      ,p_year_min                   IN  VARCHAR2 DEFAULT NULL
      ,p_year_max                   IN  VARCHAR2 DEFAULT NULL
      ,p_motivation_category        IN  VARCHAR2 DEFAULT NULL
      ,p_document_type              IN  VARCHAR2 DEFAULT NULL
      ,p_keyword                    IN  VARCHAR2 DEFAULT NULL
      ,p_author                     IN  VARCHAR2 DEFAULT NULL
      ,p_filename_override          IN  VARCHAR2 DEFAULT NULL
      ,p_add_bom                    IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      str_filename         VARCHAR2(4000 Char) := p_filename_override;
      str_status_message   VARCHAR2(4000 Char);
      num_return_code      NUMBER;
      curs_mine            SYS_REFCURSOR;
      ary_psc_codes        MDSYS.SDO_NUMBER_ARRAY;
      str_psc_desc         VARCHAR2(32000 Char);
      ary_tt_codes         MDSYS.SDO_STRING2_ARRAY;
      str_tt_desc          VARCHAR2(32000 Char);
      ary_scales           MDSYS.SDO_STRING2_ARRAY;
      str_regexp_scales    VARCHAR2(32000 Char);
      ary_poll_search      MDSYS.SDO_STRING2_ARRAY;
      ary_parameter_desc   MDSYS.SDO_STRING2_ARRAY;
      str_perc_remove      VARCHAR2(1 Char);
      num_percent_min      NUMBER;
      num_percent_max      NUMBER;
      ary_sic_codes        MDSYS.SDO_NUMBER_ARRAY;
      ary_naics_codes      MDSYS.SDO_NUMBER_ARRAY;
      num_year_min         NUMBER;
      num_year_max         NUMBER;
      ary_motivation       MDSYS.SDO_STRING2_ARRAY;
      ary_doc_types        MDSYS.SDO_STRING2_ARRAY;
      ary_keyword          MDSYS.SDO_STRING2_ARRAY;
      str_regexp_pst       VARCHAR2(32000 Char);
      str_regexp_keyword   VARCHAR2(32000 Char);
      str_regexp_authors   VARCHAR2(32000 Char);
      ary_authors          MDSYS.SDO_STRING2_ARRAY;
      boo_add_bom          BOOLEAN;
      
   BEGIN
   
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      boo_add_bom := c2b(p_add_bom);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Determine the filename
      --------------------------------------------------------------------------
      IF str_filename IS NULL
      THEN
         str_filename := get_filename('ArticleSearch','.csv');
         
      END IF;
     
      --------------------------------------------------------------------------
      -- Step 30
      -- Process the parameter inputs
      --------------------------------------------------------------------------
      art_parameters(
          p_point_source_category_code => p_point_source_category_code
         ,p_point_source_category_desc => p_point_source_category_desc
         ,p_treatment_technology_code  => p_treatment_technology_code
         ,p_treatment_technology_desc  => p_treatment_technology_desc
         ,p_treatment_scale            => p_treatment_scale
         ,p_pollutant_search_term      => p_pollutant_search_term
         ,p_pollutant_search_term_wc   => p_pollutant_search_term_wc
         ,p_parameter_desc             => p_parameter_desc
         ,p_percent_removal_flag       => p_percent_removal_flag
         ,p_percent_min                => p_percent_min
         ,p_percent_max                => p_percent_max
         ,p_SIC                        => p_SIC
         ,p_NAICS                      => p_NAICS
         ,p_year_min                   => p_year_min
         ,p_year_max                   => p_year_max
         ,p_motivation_category        => p_motivation_category
         ,p_document_type              => p_document_type
         ,p_keyword                    => p_keyword
         ,p_author                     => p_author
         ,p_ary_psc_codes              => ary_psc_codes
         ,p_str_psc_desc               => str_psc_desc
         ,p_ary_tt_codes               => ary_tt_codes
         ,p_str_tt_desc                => str_tt_desc
         ,p_ary_scales                 => ary_scales
         ,p_str_regexp_scales          => str_regexp_scales
         ,p_ary_poll_search            => ary_poll_search
         ,p_str_regexp_pst             => str_regexp_pst
         ,p_ary_parameter_desc         => ary_parameter_desc
         ,p_str_perc_remove            => str_perc_remove
         ,p_num_percent_min            => num_percent_min
         ,p_num_percent_max            => num_percent_max
         ,p_ary_sic_codes              => ary_sic_codes
         ,p_ary_naics_codes            => ary_naics_codes
         ,p_num_year_min               => num_year_min
         ,p_num_year_max               => num_year_max
         ,p_ary_motivation             => ary_motivation
         ,p_ary_doc_types              => ary_doc_types
         ,p_ary_keyword                => ary_keyword
         ,p_str_regexp_keyword         => str_regexp_keyword
         ,p_ary_authors                => ary_authors
         ,p_str_regexp_authors         => str_regexp_authors
         ,p_status_message             => str_status_message
         ,p_return_code                => num_return_code
      );
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Query the reference items
      --------------------------------------------------------------------------
      OPEN curs_mine 
      FOR
      SELECT
       ri.ref_id AS "Ref_ID"
      ,ri.authors AS "Authors"
      ,ri.title AS "Title"
      ,ri.refdate AS "RefDate"
      ,ri.journal_publisher AS "Journal_Publisher"
      ,(SELECT c.abstract FROM iwtt.reference_info c WHERE c.ref_id = ri.ref_id) AS "Abstract"
      ,ri.scale AS "Scales"
      ,(SELECT COUNT(*) FROM iwtt.treatment_system d WHERE d.ref_id = ri.ref_id) AS "CountSystem"
      FROM 
      iwtt.reference_info ri
      LEFT JOIN 
      iwtt.reference_motivation c 
      ON 
      ri.ref_id = c.ref_id
      LEFT JOIN 
      iwtt.treatment_system e
      ON 
      ri.ref_id = e.ref_id
      LEFT JOIN 
      iwtt.key_psc e2 
      ON 
      e.psc_code = e2.psc_code
      LEFT JOIN 
      iwtt.key_sic e3 
      ON 
      e.sic_code = e3.sic_code_numeric
      LEFT JOIN 
      iwtt.key_naics e4 
      ON 
      e.naics_code = e4.naics_code
      LEFT JOIN 
      iwtt.parameter d
      ON 
          ri.ref_id = d.ref_id
      AND e.system_name = d.system_name
      LEFT JOIN 
      iwtt.key_parameter_code d1 
      ON 
      d.paramid = d1.paramid
      LEFT JOIN 
      iwtt.key_performstat d2
      ON
      d.performstatid = d2.performstatid
      LEFT JOIN 
      iwtt.treatment_units f
      ON 
          ri.ref_id = f.ref_id
      AND e.system_name = f.system_name
      LEFT JOIN 
      iwtt.key_treatment_tech_codes f2
      ON 
      f.tt_code = f2.tt_code
      WHERE
      -- Records limited to the psc codes provided
      ( 
         ary_psc_codes IS NULL 
         OR 
         e.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
         OR
         ri.lab_scale_psc IN (SELECT * FROM TABLE(ary_psc_codes))
      )
      AND -- Records limited to a case-insensitive string match
      ( 
         str_psc_desc IS NULL 
         OR 
         UPPER(e2.psc_desc) LIKE '%' || str_psc_desc || '%'
         OR
         UPPER(ri.lab_scale_psc_desc) LIKE '%' || str_psc_desc || '%' 
      )
      AND -- Records limited to the tt codes provided 
      ( 
         p_treatment_technology_code  IS NULL 
         OR 
         UPPER(f.tt_code) IN (SELECT * FROM TABLE(ary_tt_codes))
      )
      AND -- Records limited to a case-insensitve string match
      ( 
         p_treatment_technology_desc  IS NULL 
         OR 
         UPPER(f2.tt_name) LIKE '%' || str_tt_desc || '%'
      )
      AND -- Records limited to case insenstive match
      ( 
         ary_scales IS NULL
         OR
         UPPER(e.scale) IN (SELECT * FROM TABLE(ary_scales))
         OR
         REGEXP_INSTR(UPPER(ri.scale),str_regexp_scales) > 0
      )
      AND -- Records limited to case insenstive match
      ( 
         p_pollutant_search_term IS NULL 
         OR 
         REGEXP_INSTR(UPPER(d1.pollutant_search_term),str_regexp_pst) > 0
         OR
         UPPER(d1.pollutant_search_term) IN (SELECT * FROM TABLE(ary_poll_search))
      )
      AND 
      -- if Y then only records with a percent removal value
      -- if N then only records without a percent removal value
      ( p_percent_removal_flag      IS NULL 
         OR 
         (
            str_perc_remove = 'Y' AND d.updateremoval IS NOT NULL
         )
         OR
         (
            str_perc_remove = 'N' AND d.updateremoval IS NULL
         )
      )
      AND 
      -- p_percent_min
      ( p_percent_min      IS NULL 
         OR 
         d.updateremoval >= p_percent_min
      )
      AND 
      -- p_percent_max
      ( p_percent_max      IS NULL 
         OR 
         d.updateremoval <= p_percent_max
      )
      AND 
      -- SIC
      ( 
         ary_sic_codes IS NULL 
         OR 
         e.sic_code IN (SELECT * FROM TABLE(ary_sic_codes))
         OR
         ri.lab_scale_sic IN (SELECT * FROM TABLE(ary_sic_codes))
      )
      AND 
      -- NAICS
      ( p_NAICS IS NULL 
         OR 
         e.naics_code IN (SELECT * FROM TABLE(ary_naics_codes))
      )
      AND 
      -- p_year_min
      ( p_year_min IS NULL 
         OR 
         TO_NUMBER(ri.refdate) >= num_year_min
      )
      AND 
      -- p_year_max
      ( p_year_max IS NULL 
         OR 
         TO_NUMBER(ri.refdate) <= num_year_max
      )
      AND 
      -- motivation_category
      ( p_motivation_category IS NULL 
         OR 
         UPPER(c.motivationcategory) IN (SELECT * FROM TABLE(ary_motivation))
      )
      AND 
      -- document type
      ( p_document_type IS NULL 
         OR 
         UPPER(ri.documenttype) IN (SELECT * FROM TABLE(ary_doc_types))
      )
      AND 
      -- authors
      ( p_author IS NULL 
         OR 
         REGEXP_INSTR(UPPER(ri.authors),str_regexp_authors) > 0
      )
      AND 
      -- keywords
      ( p_keyword IS NULL 
         OR 
         REGEXP_INSTR(UPPER(ri.title),str_regexp_keyword) > 0
         OR
         REGEXP_INSTR(UPPER(ri.key_findings),str_regexp_keyword) > 0
         OR
         REGEXP_INSTR(UPPER(ri.abstract),str_regexp_keyword) > 0
      )
      GROUP BY
       ri.ref_id
      ,ri.authors
      ,ri.title
      ,ri.refdate
      ,ri.journal_publisher
      ,ri.scale
      ORDER BY
      ri.ref_id;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Write out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format  => 'CSV'
         ,p_cache          => NULL
         ,p_filename       => str_filename
      );
   
      ref2csv(
          p_input          => curs_mine
         ,p_column_headers => TRUE
         ,p_add_bom        => boo_add_bom              
      );
      
   END art_search_csvv01;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE report_jsonv01(
       p_REF_ID                     IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      obj_output         iwtt.dz_json_element1_obj;
      num_pretty_print   NUMBER;
      clb_output         CLOB;
      num_ref_id         INTEGER;
      num_return_code    NUMBER;
      str_status_message VARCHAR2(4000 Char);
      boo_mute           BOOLEAN;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      num_ref_id := dz_json_util.safe_to_number(p_REF_ID);
      
      num_pretty_print := dz_json_util.safe_to_number(p_pretty_print);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Query the tables
      --------------------------------------------------------------------------
      SELECT
      iwtt.dz_json_element1_obj(
         p_elements => (
            SELECT
             iwtt.dz_json_element1_vry(
                iwtt.dz_json_element1(
                   p_name => 'Reference ID'
                  ,p_element_number => a.ref_id
               )
               ,iwtt.dz_json_element1(
                   p_name => 'Title'
                  ,p_element_string => a.title
               )
               ,iwtt.dz_json_element1(
                   p_name           => 'Authors'
                  ,p_element_string => a.authors
               )
               ,iwtt.dz_json_element1(
                   p_name => 'Main_Author'
                  ,p_element_string => a.main_author
               )
               ,iwtt.dz_json_element1(
                   p_name => 'Journal_Publisher'
                  ,p_element_string => a.journal_publisher
               )
               ,iwtt.dz_json_element1(
                   p_name => 'Industry'
                  ,p_element_string_vry => CAST(MULTISET(
                     SELECT
                     ts.industry
                     FROM (
                        SELECT
                         aa.ref_id
                        ,CASE WHEN aa.scale = 'Lab'
                         THEN
                           cc.psc_desc
                         ELSE
                           bb.industry   
                         END AS industry
                        FROM
                        iwtt.reference_info aa
                        LEFT JOIN
                        iwtt.treatment_system bb
                        ON
                        aa.ref_id = bb.ref_id
                        LEFT JOIN
                        iwtt.key_psc cc
                        ON
                        aa.lab_scale_psc = cc.psc_code
                     ) ts
                     WHERE
                     ts.ref_id = a.ref_id
                     GROUP BY
                     ts.industry
                     ORDER BY
                     ts.industry
                  ) AS MDSYS.SDO_STRING2_ARRAY)
               )
               ,iwtt.dz_json_element1(
                   p_name => 'DocumentType'
                  ,p_element_string => a.documenttype
               )
               ,iwtt.dz_json_element1(
                   p_name => 'RefDate'
                  ,p_element_string => a.refdate
               )
               ,iwtt.dz_json_element1(
                   p_name           => 'MotivationCategory'
                  ,p_element_string_vry => CAST(MULTISET(
                     SELECT
                     rm.motivationcategory
                     FROM 
                     iwtt.reference_motivation rm
                     WHERE
                     rm.ref_id = a.ref_id
                     ORDER BY
                     rm.motivationcategory
                  ) AS MDSYS.SDO_STRING2_ARRAY)
               )
               ,iwtt.dz_json_element1(
                   p_name => 'Motivation'
                  ,p_element_string => a.motivation
               )
               ,iwtt.dz_json_element1(
                   p_name => 'CountSystem'
                  ,p_element_number => (SELECT COUNT(*) FROM iwtt.treatment_system t1 WHERE t1.ref_id = a.ref_id)
               )
               ,iwtt.dz_json_element1(
                   p_name           => 'Scale'
                  ,p_element_string => a.scale
               )
               ,iwtt.dz_json_element1(
                   p_name => 'MainParameter'
                  ,p_element_string => a.mainparameter
               )
               ,iwtt.dz_json_element1(
                   p_name => 'Abstract'
                  ,p_element_clob => a.abstract
               )
               ,iwtt.dz_json_element1(
                   p_name => 'Key_Findings'
                  ,p_element_string => a.key_findings
               )
               ,iwtt.dz_json_element1(
                   p_name => 'Treatment_Systems'
                  ,p_element_obj_vry => CAST(MULTISET(
                     SELECT
                     iwtt.dz_json_element2_obj(
                        p_elements => iwtt.dz_json_element2_vry(
                            iwtt.dz_json_element2(
                               p_name           => 'System_ID'
                              ,p_element_number => SUBSTR(
                                  aa.system_name
                                 ,INSTR(aa.system_name,'T') + 1
                              )
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'System_Name'
                              ,p_element_string => aa.system_name
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'TreatmentSystemScale'
                              ,p_element_string => aa.scale
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'PSC_Code'
                              ,p_element_string => CASE
                                 WHEN aa.psc_code < 10 
                                 THEN 
                                    '0' || TO_CHAR (aa.psc_code)
                                 ELSE 
                                    TO_CHAR (aa.psc_code)
                                 END
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'PSC_Desc'
                              ,p_element_string => bb.psc_desc
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'SIC_Code'
                              ,p_element_string => CASE
                                 WHEN aa.sic_code < 1000 
                                 THEN 
                                    '0' || TO_CHAR (aa.sic_code)
                                 ELSE 
                                    TO_CHAR (aa.sic_code)
                                 END
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'SICName'
                              ,p_element_string => cc.sic_desc
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Naics_Code'
                              ,p_element_string => TO_CHAR(aa.naics_code)
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'NAICSName'
                              ,p_element_string => dd.naics_desc
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'TT_Code'
                              ,p_element_string_vry => CAST(MULTISET(
                                 SELECT
                                 tu.tt_code
                                 FROM 
                                 iwtt.treatment_units tu
                                 WHERE
                                     tu.ref_id      = aa.ref_id
                                 AND tu.system_name = aa.system_name
                                 ORDER BY
                                 tu.tt_code_order
                              ) AS MDSYS.SDO_STRING2_ARRAY)
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Discharge_Designation'
                              ,p_element_string => aa.discharge_designation
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'WW_Use'
                              ,p_element_string => aa.ww_use
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Treatment_Tech_Description'
                              ,p_element_string => aa.treatment_tech_description
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Chemical_Addition'
                              ,p_element_string => aa.chemical_addition
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Addt_System_Parameters'
                              ,p_element_string => aa.addt_system_parameters
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Manufacturer'
                              ,p_element_string => aa.manufacturer
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Capital_Cost'
                              ,p_element_string => aa.capital_cost
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'OandM_Cost'
                              ,p_element_string => aa.oandm_cost
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Media_Type'
                              ,p_element_string => aa.media_type
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'pH_Descriptor'
                              ,p_element_string => aa.ph_descriptor
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'Low_pH_Range'
                              ,p_element_string => aa.low_ph_range
                           )
                           ,iwtt.dz_json_element2(
                               p_name           => 'High_pH_Range'
                              ,p_element_string => aa.high_ph_range
                           )
                           ,iwtt.dz_json_element2(
                               p_name => 'Parameters'
                              ,p_element_obj_vry => CAST(MULTISET(
                                 SELECT
                                 iwtt.dz_json_element3_obj(
                                    p_elements => iwtt.dz_json_element3_vry(
                                        iwtt.dz_json_element3(
                                           p_name           => 'ParamID'
                                          ,p_element_number => a.paramid
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'Parameter'
                                          ,p_element_string => a.parameter
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'InfluentFlag'
                                          ,p_element_string => a.influentflag
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'InfluentConcentration'
                                          ,p_element_number => a.influentconcentration
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'InfluentUnits'
                                          ,p_element_string => a.influentunits
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'EffluentFlag'
                                          ,p_element_string => a.effluentflag
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'EffluentConcentration'
                                          ,p_element_number => a.effluentconcentration
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'EffluentUnits'
                                          ,p_element_string => a.effluentunits
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'ReportedRemovalFlag'
                                          ,p_element_string => a.reportedremovalflag
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'ReportedRemoval'
                                          ,p_element_string => a.reportedremoval
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'CalculatedRemoval'
                                          ,p_element_number => a.calculatedremoval
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'UpdateRemovalFlag'
                                          ,p_element_string => a.updateremovalflag
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'UpdatedRemoval'
                                          ,p_element_number => a.updateremoval
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'AnalyticalMethod'
                                          ,p_element_string => a.analytical_method
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'PerformStatID'
                                          ,p_element_number => a.performstatid
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'PerformStat'
                                          ,p_element_string => c.performstat
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'InfluentDL'
                                          ,p_element_number => a.influentdl
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'InfluentDLUnits'
                                          ,p_element_string => a.influentdlunits
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'EffluentDL'
                                          ,p_element_number => a.effluentdl
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'EffluentDLUnits'
                                          ,p_element_string => a.effluentdlunits
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'ELDescription'
                                          ,p_element_string => a.eldescription
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'EffluentLimit'
                                          ,p_element_number => a.effluentlimit
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'ELUnits'
                                          ,p_element_string => a.elunits
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'ELDescription2'
                                          ,p_element_string => a.eldescription2
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'EL2'
                                          ,p_element_number => a.el2
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'ELUnits2'
                                          ,p_element_string => a.elunits2
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'ELDescription3'
                                          ,p_element_string => a.eldescription3
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'EL3'
                                          ,p_element_number => a.el3
                                       )
                                       ,iwtt.dz_json_element3(
                                           p_name           => 'ELUnits3'
                                          ,p_element_string => a.elunits3
                                       )
                                    )
                                 )
                                 FROM 
                                 iwtt.parameter  a
                                 LEFT JOIN 
                                 iwtt.key_performstat c
                                 ON 
                                 a.performstatid = c.performstatid
                                 WHERE
                                     a.ref_id      = aa.ref_id  
                                 AND a.system_name = aa.system_name
                                 ORDER BY
                                 a.parameter               
                              ) AS iwtt.dz_json_element3_obj_vry)
                           )
                        )
                     ) 
                     FROM 
                     iwtt.treatment_system aa
                     LEFT JOIN 
                     iwtt.key_psc bb 
                     ON 
                     aa.psc_code = bb.psc_code
                     LEFT JOIN 
                     iwtt.key_sic cc 
                     ON 
                     aa.sic_code = cc.sic_code_numeric
                     LEFT JOIN 
                     iwtt.key_naics dd
                     ON 
                     aa.naics_code = dd.naics_code
                     WHERE
                     aa.ref_id = a.ref_id
                     ORDER BY
                     aa.system_name
                  ) AS iwtt.dz_json_element2_obj_vry)
               )
            )
            FROM
            iwtt.reference_info a
            WHERE
            a.ref_id = num_ref_id
         ) 
      )
      INTO obj_output
      FROM
      dual;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Convert results to clob
      --------------------------------------------------------------------------
      clb_output := obj_output.toJSON(
         p_pretty_print    => num_pretty_print + 1
      );
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Push out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format    => 'JSON'
         ,p_cache            => NULL
         ,p_json_callback    => NULL
         ,p_mute             => boo_mute
      );
      
      IF num_return_code <> 0
      THEN
         clob2htp(
             jsend_error(
                p_message        => str_status_message
               ,p_code           => num_return_code
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
            )
            ,p_mute => boo_mute
         );
         
      ELSE
         clob2htp(
            jsend_success(
                p_data           => clb_output
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
             )
            ,p_mute => boo_mute
         );
         
      END IF;
      
   END report_jsonv01;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_industry_jsonv01(
       p_industry_ID                IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      obj_output         iwtt.dz_json_element1_obj;
      num_pretty_print   NUMBER;
      clb_output         CLOB;
      num_return_code    NUMBER;
      str_status_message VARCHAR2(4000 Char);
      boo_mute           BOOLEAN;
      ary_psc_codes      MDSYS.SDO_NUMBER_ARRAY;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      num_return_code  := 0;
      num_pretty_print := dz_json_util.safe_to_number(p_pretty_print);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Parse PSC code limiters
      --------------------------------------------------------------------------
      IF p_industry_id IS NOT NULL
      THEN
         ary_psc_codes := dz_json_util.strings2numbers(
            dz_json_util.gz_split(
                p_industry_ID
               ,g_delimiter
            )
         );
      
         IF ary_psc_codes IS NULL
         OR ary_psc_codes.COUNT = 0
         THEN
            str_status_message := 'Unable to parse numeric PSC codes from input parameter.';
            num_return_code    := -10;
         
         END IF;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Query the tables
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         SELECT
         iwtt.dz_json_element1_obj(
            p_elements => (
               SELECT
                iwtt.dz_json_element1_vry(
                   iwtt.dz_json_element1(
                      p_name => 'Industries'
                     ,p_element_obj_vry => CAST(MULTISET(
                        SELECT
                        iwtt.dz_json_element2_obj(
                           p_elements => iwtt.dz_json_element2_vry(
                              iwtt.dz_json_element2(
                                  p_name => 'psc'
                                 ,p_element_string => CASE
                                  WHEN a.psc_code < 10
                                  THEN
                                    '0' || TO_CHAR(a.psc_code)
                                  ELSE
                                    TO_CHAR(a.psc_code)
                                  END
                              )
                              ,iwtt.dz_json_element2(
                                  p_name => 'p_psc_desc'
                                 ,p_element_string => a.psc_desc
                              )
                           )
                        )
                        FROM
                        iwtt.key_psc a
                        JOIN (
                           SELECT
                           bb.psc_code
                           FROM
                           iwtt.treatment_system bb
                           GROUP BY
                           bb.psc_code
                        ) b
                        ON
                        a.psc_code = b.psc_code
                        WHERE
                        p_industry_ID IS NULL
                        OR
                        a.psc_code IN (SELECT * FROM TABLE(ary_psc_codes))
                        ORDER BY
                        a.psc_code
                     ) AS iwtt.dz_json_element2_obj_vry)
                  )
               )
               FROM
               dual
            ) 
         )
         INTO obj_output
         FROM
         dual;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Convert results to clob
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         clb_output := obj_output.toJSON(
            p_pretty_print    => num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Push out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format    => 'JSON'
         ,p_cache            => NULL
         ,p_json_callback    => NULL
         ,p_mute             => boo_mute
      );
      
      IF num_return_code <> 0
      THEN
         clob2htp(
             jsend_error(
                p_message        => str_status_message
               ,p_code           => num_return_code
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
            )
            ,p_mute => boo_mute
         );
         
      ELSE
         clob2htp(
            jsend_success(
                p_data           => clb_output
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
             )
            ,p_mute => boo_mute
         );
         
      END IF;
      
   END lookup_industry_jsonv01;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_parameter_jsonv01(
       p_pollutant_search_term      IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      obj_output         iwtt.dz_json_element1_obj;
      num_pretty_print   NUMBER;
      clb_output         CLOB;
      num_return_code    NUMBER;
      str_status_message VARCHAR2(4000 Char);
      boo_mute           BOOLEAN;
      ary_pollutant_term MDSYS.SDO_STRING2_ARRAY;
      str_poll_regexp    VARCHAR2(32000 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      num_return_code  := 0;
      num_pretty_print := dz_json_util.safe_to_number(p_pretty_print);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Parse pollutant search term limiters
      --------------------------------------------------------------------------
      IF p_pollutant_search_term IS NOT NULL
      THEN
         ary_pollutant_term := dz_json_util.gz_split(
             UPPER(p_pollutant_search_term)
            ,g_delimiter
         );
      
         str_poll_regexp := '(' || escape_regex(ary_pollutant_term(1));
         
         IF ary_pollutant_term.COUNT > 1
         THEN
            FOR i IN 2 .. ary_pollutant_term.COUNT
            LOOP
               str_poll_regexp := str_poll_regexp || '|' || escape_regex(ary_pollutant_term(i));
               
            END LOOP;
         
         END IF;
         
         str_poll_regexp := str_poll_regexp || ')';
         
      END IF;
     
      --------------------------------------------------------------------------
      -- Step 30
      -- Query the tables
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         SELECT
         iwtt.dz_json_element1_obj(
            p_elements => (
               SELECT
                iwtt.dz_json_element1_vry(
                   iwtt.dz_json_element1(
                      p_name => 'Parameter_Codes'
                     ,p_element_obj_vry => CAST(MULTISET(
                        SELECT
                        iwtt.dz_json_element2_obj(
                           p_elements => iwtt.dz_json_element2_vry(
                              iwtt.dz_json_element2(
                                  p_name => 'p_pollutant_search_term'
                                 ,p_element_string => a.pollutant_search_term
                              )
                              ,iwtt.dz_json_element2(
                                  p_name => 'p_parameter'
                                 ,p_element_number => a.paramid
                              )
                              ,iwtt.dz_json_element2(
                                  p_name => 'p_parameter_desc'
                                 ,p_element_string => a.parameter
                              )
                              ,iwtt.dz_json_element2(
                                  p_name => 'p_CAS'
                                 ,p_element_number => a.cas_nmbr
                              )
                           )
                        )
                        FROM
                        iwtt.key_parameter_code a
                        JOIN (
                           SELECT
                           bb.paramid
                           FROM
                           iwtt.parameter bb
                           GROUP BY
                           bb.paramid                        
                        ) b
                        ON
                        a.paramid = b.paramid
                        WHERE
                        p_pollutant_search_term IS NULL
                        OR
                        REGEXP_INSTR(UPPER(a.pollutant_search_term),str_poll_regexp) > 0
                        ORDER BY
                        a.paramid
                     ) AS iwtt.dz_json_element2_obj_vry)
                  )
               )
               FROM
               dual
            ) 
         )
         INTO obj_output
         FROM
         dual;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Convert results to clob
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         clb_output := obj_output.toJSON(
            p_pretty_print    => num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Push out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format    => 'JSON'
         ,p_cache            => NULL
         ,p_json_callback    => NULL
         ,p_mute             => boo_mute
      );
      
      IF num_return_code <> 0
      THEN
         clob2htp(
             jsend_error(
                p_message        => str_status_message
               ,p_code           => num_return_code
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
            )
            ,p_mute => boo_mute
         );
         
      ELSE
         clob2htp(
            jsend_success(
                p_data           => clb_output
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
             )
            ,p_mute => boo_mute
         );
         
      END IF;
      
   END lookup_parameter_jsonv01;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_treatment_tech_jsonv01(
       p_treatment_technology_code  IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      obj_output         iwtt.dz_json_element1_obj;
      num_pretty_print   NUMBER;
      clb_output         CLOB;
      num_return_code    NUMBER;
      str_status_message VARCHAR2(4000 Char);
      boo_mute           BOOLEAN;
      ary_tt_code        MDSYS.SDO_STRING2_ARRAY;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      num_return_code  := 0;
      num_pretty_print := dz_json_util.safe_to_number(p_pretty_print);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Parse pollutant search term limiters
      --------------------------------------------------------------------------
      IF p_treatment_technology_code IS NOT NULL
      THEN
         ary_tt_code := dz_json_util.gz_split(
             UPPER(p_treatment_technology_code)
            ,g_delimiter
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Query the tables
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         SELECT
         iwtt.dz_json_element1_obj(
            p_elements => (
               SELECT
                iwtt.dz_json_element1_vry(
                   iwtt.dz_json_element1(
                      p_name => 'Treatment_Technologies'
                     ,p_element_obj_vry => CAST(MULTISET(
                        WITH tt_codes AS (
                           SELECT
                            a.tt_code
                           ,a.tt_name
                           ,a.tt_category
                           ,a.tt_variation
                           FROM
                           iwtt.key_treatment_tech_codes a
                           JOIN (
                              SELECT
                              bb.tt_code
                              FROM
                              iwtt.treatment_units bb
                              GROUP BY
                              bb.tt_code 
                           ) b
                           ON
                           a.tt_code = b.tt_code
                           WHERE
                           p_treatment_technology_code IS NULL
                           OR
                           a.tt_code IN (SELECT * FROM TABLE(ary_tt_code))
                        )
                        SELECT
                        iwtt.dz_json_element2_obj(
                           p_elements => iwtt.dz_json_element2_vry(
                              iwtt.dz_json_element2(
                                  p_name => 'p_tt_code'
                                 ,p_element_string => a.tt_code
                              )
                              ,iwtt.dz_json_element2(
                                  p_name => 'p_tt_desc'
                                 ,p_element_string => a.tt_name
                              )
                              ,iwtt.dz_json_element2(
                                  p_name => 'p_tt_cat'
                                 ,p_element_string => a.tt_category
                              )
                              ,iwtt.dz_json_element2(
                                  p_name => 'p_tt_definition'
                                 ,p_element_string => a.tt_variation
                              )
                           )
                        )
                        FROM (
                           SELECT
                            aa.tt_code
                           ,aa.tt_name
                           ,aa.tt_category
                           ,aa.tt_variation
                           FROM
                           tt_codes aa
                           UNION
                           SELECT
                            bb.tt_category_code
                           ,bb.tt_category_desc
                           ,NULL
                           ,NULL
                           FROM
                           iwtt.key_treatment_tech_category bb
                           JOIN
                           iwtt.xref_treatment_tech_category cc
                           ON
                           bb.tt_category_code = cc.tt_category_code
                           JOIN (
                              SELECT
                              ddd.tt_code
                              FROM
                              iwtt.treatment_units ddd
                              GROUP BY
                              ddd.tt_code 
                           ) dd
                           ON
                           dd.tt_code = cc.tt_code
                           WHERE
                               bb.category_group_flag = 'Y'  
                           AND (
                              p_treatment_technology_code IS NULL
                              OR
                              bb.tt_category_code IN (SELECT * FROM TABLE(ary_tt_code))
                           ) 
                           ORDER BY
                           1
                        ) a
                     ) AS iwtt.dz_json_element2_obj_vry)
                  )
               )
               FROM
               dual
            ) 
         )
         INTO obj_output
         FROM
         dual;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Convert results to clob
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         clb_output := obj_output.toJSON(
            p_pretty_print    => num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Push out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format    => 'JSON'
         ,p_cache            => NULL
         ,p_json_callback    => NULL
         ,p_mute             => boo_mute
      );
      
      IF num_return_code <> 0
      THEN
         clob2htp(
             jsend_error(
                p_message        => str_status_message
               ,p_code           => num_return_code
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
            )
            ,p_mute => boo_mute
         );
         
      ELSE
         clob2htp(
            jsend_success(
                p_data           => clb_output
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
             )
            ,p_mute => boo_mute
         );
         
      END IF;
      
   END lookup_treatment_tech_jsonv01;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_year_jsonv01(
       p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      obj_output         iwtt.dz_json_element1_obj;
      num_pretty_print   NUMBER;
      clb_output         CLOB;
      num_return_code    NUMBER;
      str_status_message VARCHAR2(4000 Char);
      boo_mute           BOOLEAN;
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      num_return_code  := 0;
      num_pretty_print := dz_json_util.safe_to_number(p_pretty_print);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Query the data
      --------------------------------------------------------------------------
      SELECT
      iwtt.dz_json_element1_obj(
         p_elements => (
            SELECT
             iwtt.dz_json_element1_vry(
                iwtt.dz_json_element1(
                   p_name => 'p_min_year'
                  ,p_element_string => MIN(a.refdate)
               )
               ,iwtt.dz_json_element1(
                   p_name => 'p_max_year'
                  ,p_element_string => MAX(a.refdate)
               ) 
            )
            FROM
            iwtt.reference_info a
         )
      )
      INTO obj_output
      FROM
      dual;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Convert results to clob
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         clb_output := obj_output.toJSON(
            p_pretty_print    => num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Push out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format    => 'JSON'
         ,p_cache            => NULL
         ,p_json_callback    => NULL
         ,p_mute             => boo_mute
      );
      
      IF num_return_code <> 0
      THEN
         clob2htp(
             jsend_error(
                p_message        => str_status_message
               ,p_code           => num_return_code
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
            )
            ,p_mute => boo_mute
         );
         
      ELSE
         clob2htp(
            jsend_success(
                p_data           => clb_output
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
             )
            ,p_mute => boo_mute
         );
         
      END IF;
      
   END lookup_year_jsonv01;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_document_type_jsonv01(
       p_document_type              IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      obj_output         iwtt.dz_json_element1_obj;
      num_pretty_print   NUMBER;
      clb_output         CLOB;
      num_return_code    NUMBER;
      str_status_message VARCHAR2(4000 Char);
      boo_mute           BOOLEAN;
      ary_document_types MDSYS.SDO_STRING2_ARRAY;
      str_doctype_regexp VARCHAR2(32000 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      num_return_code  := 0;
      num_pretty_print := dz_json_util.safe_to_number(p_pretty_print);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Parse PSC code limiters
      --------------------------------------------------------------------------
      IF p_document_type IS NOT NULL
      THEN
         ary_document_types := dz_json_util.gz_split(
             UPPER(p_document_type)
            ,g_delimiter
         );
      
         str_doctype_regexp := '(' || escape_regex(ary_document_types(1));
         
         IF ary_document_types.COUNT > 1
         THEN
            FOR i IN 2 .. ary_document_types.COUNT
            LOOP
               str_doctype_regexp := str_doctype_regexp || '|' || escape_regex(ary_document_types(i));
               
            END LOOP;
         
         END IF;
         
         str_doctype_regexp := str_doctype_regexp || ')';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Query the data
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         SELECT
         iwtt.dz_json_element1_obj(
            p_elements => (
               SELECT
                iwtt.dz_json_element1_vry(
                   iwtt.dz_json_element1(
                      p_name => 'Document_Types'
                     ,p_element_obj_vry => CAST(MULTISET(
                        SELECT
                        iwtt.dz_json_element2_obj(
                           p_elements => iwtt.dz_json_element2_vry(
                              iwtt.dz_json_element2(
                                  p_name => 'p_document_type'
                                 ,p_element_string => a.documenttype
                              )
                           )
                        )
                        FROM
                        iwtt.key_document_types a
                        JOIN (
                           SELECT
                           bb.documenttype
                           FROM
                           iwtt.reference_info bb
                           GROUP BY
                           bb.documenttype
                        ) b
                        ON
                        a.documenttype = b.documenttype
                        WHERE
                        p_document_type IS NULL
                        OR
                        REGEXP_INSTR(UPPER(a.documenttype),str_doctype_regexp) > 0
                        ORDER BY
                        a.documenttype_order
                     ) AS iwtt.dz_json_element2_obj_vry)
                  )
               )
               FROM
               dual
            ) 
         )
         INTO obj_output
         FROM
         dual;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Convert results to clob
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         clb_output := obj_output.toJSON(
            p_pretty_print    => num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Push out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format    => 'JSON'
         ,p_cache            => NULL
         ,p_json_callback    => NULL
         ,p_mute             => boo_mute
      );
      
      IF num_return_code <> 0
      THEN
         clob2htp(
             jsend_error(
                p_message        => str_status_message
               ,p_code           => num_return_code
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
            )
            ,p_mute => boo_mute
         );
         
      ELSE
         clob2htp(
            jsend_success(
                p_data           => clb_output
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
             )
            ,p_mute => boo_mute
         );
         
      END IF;
      
   END lookup_document_type_jsonv01;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_motivation_cat_jsonv01(
       p_motivation_cat             IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      obj_output            iwtt.dz_json_element1_obj;
      num_pretty_print      NUMBER;
      clb_output            CLOB;
      num_return_code       NUMBER;
      str_status_message    VARCHAR2(4000 Char);
      boo_mute              BOOLEAN;
      ary_motivation_cat    MDSYS.SDO_STRING2_ARRAY;
      str_motivation_regexp VARCHAR2(32000 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      num_return_code  := 0;
      num_pretty_print := dz_json_util.safe_to_number(p_pretty_print);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Parse PSC code limiters
      --------------------------------------------------------------------------
      IF p_motivation_cat IS NOT NULL
      THEN
         ary_motivation_cat := dz_json_util.gz_split(
             UPPER(p_motivation_cat)
            ,g_delimiter
         );
      
         str_motivation_regexp := '(' || escape_regex(ary_motivation_cat(1));
         
         IF ary_motivation_cat.COUNT > 1
         THEN
            FOR i IN 2 .. ary_motivation_cat.COUNT
            LOOP
               str_motivation_regexp := str_motivation_regexp || '|' || escape_regex(ary_motivation_cat(i));
               
            END LOOP;
         
         END IF;
         
         str_motivation_regexp := str_motivation_regexp || ')';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Query the data
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         SELECT
         iwtt.dz_json_element1_obj(
            p_elements => (
               SELECT
                iwtt.dz_json_element1_vry(
                   iwtt.dz_json_element1(
                      p_name => 'MotivationCategories'
                     ,p_element_obj_vry => CAST(MULTISET(
                        SELECT
                        iwtt.dz_json_element2_obj(
                           p_elements => iwtt.dz_json_element2_vry(
                              iwtt.dz_json_element2(
                                  p_name => 'p_motivationcategory'
                                 ,p_element_string => a.motivationcategory
                              )
                           )
                        )
                        FROM
                        iwtt.key_motivation a
                        JOIN (
                           SELECT
                           bb.motivationcategory
                           FROM
                           iwtt.reference_motivation bb
                           GROUP BY
                           bb.motivationcategory
                        ) b
                        ON
                        a.motivationcategory = b.motivationcategory
                        WHERE
                        p_motivation_cat IS NULL
                        OR
                        REGEXP_INSTR(UPPER(a.motivationcategory),str_motivation_regexp) > 0
                        ORDER BY
                        a.motivation_sort
                     ) AS iwtt.dz_json_element2_obj_vry)
                  )
               )
               FROM
               dual
            ) 
         )
         INTO obj_output
         FROM
         dual;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Convert results to clob
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         clb_output := obj_output.toJSON(
            p_pretty_print    => num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Push out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format    => 'JSON'
         ,p_cache            => NULL
         ,p_json_callback    => NULL
         ,p_mute             => boo_mute
      );
      
      IF num_return_code <> 0
      THEN
         clob2htp(
             jsend_error(
                p_message        => str_status_message
               ,p_code           => num_return_code
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
            )
            ,p_mute => boo_mute
         );
         
      ELSE
         clob2htp(
            jsend_success(
                p_data           => clb_output
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
             )
            ,p_mute => boo_mute
         );
         
      END IF;
      
   END lookup_motivation_cat_jsonv01;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_sic_jsonv01(
       p_sic_code                   IN  VARCHAR2 DEFAULT NULL
      ,p_sic_desc                   IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      obj_output         iwtt.dz_json_element1_obj;
      num_pretty_print   NUMBER;
      clb_output         CLOB;
      num_return_code    NUMBER;
      str_status_message VARCHAR2(4000 Char);
      boo_mute           BOOLEAN;
      ary_sic_codes      MDSYS.SDO_NUMBER_ARRAY;
      ary_sic_desc       MDSYS.SDO_STRING2_ARRAY;
      str_sic_regexp     VARCHAR2(32000 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      num_return_code  := 0;
      num_pretty_print := dz_json_util.safe_to_number(p_pretty_print);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Parse SIC code limiters
      --------------------------------------------------------------------------
      IF p_sic_code IS NOT NULL
      THEN
         ary_sic_codes := dz_json_util.strings2numbers(
            dz_json_util.gz_split(
                p_sic_code
               ,g_delimiter
            )
         );
         
      END IF;
      
      IF p_sic_desc IS NOT NULL
      THEN
         ary_sic_desc := dz_json_util.gz_split(
             UPPER(p_sic_desc)
            ,g_delimiter
         );
         
         str_sic_regexp := '(' || escape_regex(ary_sic_desc(1));
         
         IF ary_sic_desc.COUNT > 1
         THEN
            FOR i IN 2 .. ary_sic_desc.COUNT
            LOOP
               str_sic_regexp := str_sic_regexp || '|' || escape_regex(ary_sic_desc(i));
               
            END LOOP;
         
         END IF;
         
         str_sic_regexp := str_sic_regexp || ')';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Query the data
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         SELECT
         iwtt.dz_json_element1_obj(
            p_elements => (
               SELECT
                iwtt.dz_json_element1_vry(
                   iwtt.dz_json_element1(
                      p_name => 'SIC'
                     ,p_element_obj_vry => CAST(MULTISET(
                        SELECT
                        iwtt.dz_json_element2_obj(
                           p_elements => iwtt.dz_json_element2_vry(
                               iwtt.dz_json_element2(
                                  p_name => 'p_sic_code'
                                 ,p_element_string => a.sic_code
                              )
                              ,iwtt.dz_json_element2(
                                  p_name => 'p_sic_desc'
                                 ,p_element_string => a.sic_desc
                              )
                              ,iwtt.dz_json_element2(
                                  p_name => 'p_sic_code_2_digit'
                                 ,p_element_string => a.sic_code_2_digit
                              )
                              ,iwtt.dz_json_element2(
                                  p_name => 'p_sic_desc_2_digit'
                                 ,p_element_string => a.sic_desc_2_digit
                              )
                           )
                        )
                        FROM
                        iwtt.key_sic a
                        JOIN (
                           SELECT
                           bb.sic_code
                           FROM
                           iwtt.treatment_system bb
                           GROUP BY
                           bb.sic_code
                        ) b
                        ON
                        a.sic_code_numeric = b.sic_code
                        WHERE (
                           p_sic_code IS NULL
                           OR
                           a.sic_code IN (SELECT * FROM TABLE(ary_sic_codes))
                        ) AND (
                           p_sic_desc IS NULL
                           OR
                           REGEXP_INSTR(UPPER(a.sic_desc),str_sic_regexp) > 0
                        )
                        ORDER BY
                        a.sic_code
                     ) AS iwtt.dz_json_element2_obj_vry)
                  )
               )
               FROM
               dual
            ) 
         )
         INTO obj_output
         FROM
         dual;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 60
      -- Convert results to clob
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         clb_output := obj_output.toJSON(
            p_pretty_print    => num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Push out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format    => 'JSON'
         ,p_cache            => NULL
         ,p_json_callback    => NULL
         ,p_mute             => boo_mute
      );
      
      IF num_return_code <> 0
      THEN
         clob2htp(
             jsend_error(
                p_message        => str_status_message
               ,p_code           => num_return_code
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
            )
            ,p_mute => boo_mute
         );
         
      ELSE
         clob2htp(
            jsend_success(
                p_data           => clb_output
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
             )
            ,p_mute => boo_mute
         );
         
      END IF;
      
   END lookup_sic_jsonv01;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_naics_jsonv01(
       p_naics_code                 IN  VARCHAR2 DEFAULT NULL
      ,p_naics_desc                 IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   )
   AS
      obj_output         iwtt.dz_json_element1_obj;
      num_pretty_print   NUMBER;
      clb_output         CLOB;
      num_return_code    NUMBER;
      str_status_message VARCHAR2(4000 Char);
      boo_mute           BOOLEAN;
      ary_naics_codes    MDSYS.SDO_NUMBER_ARRAY;
      ary_naics_desc     MDSYS.SDO_STRING2_ARRAY;
      str_naics_regexp   VARCHAR2(32000 Char);
      
   BEGIN
      
      --------------------------------------------------------------------------
      -- Step 10
      -- Check over incoming parameters
      --------------------------------------------------------------------------
      num_return_code  := 0;
      num_pretty_print := dz_json_util.safe_to_number(p_pretty_print);
      
      --------------------------------------------------------------------------
      -- Step 20
      -- Parse SIC code limiters
      --------------------------------------------------------------------------
      IF p_naics_code IS NOT NULL
      THEN
         ary_naics_codes := dz_json_util.strings2numbers(
            dz_json_util.gz_split(
                p_naics_code
               ,g_delimiter
            )
         );
         
      END IF;
      
      IF p_naics_desc IS NOT NULL
      THEN
         ary_naics_desc := dz_json_util.gz_split(
             UPPER(p_naics_desc)
            ,g_delimiter
         );
         
         str_naics_regexp := '(' || escape_regex(ary_naics_desc(1));
         
         IF ary_naics_desc.COUNT > 1
         THEN
            FOR i IN 2 .. ary_naics_desc.COUNT
            LOOP
               str_naics_regexp := str_naics_regexp || '|' || escape_regex(ary_naics_desc(i));
               
            END LOOP;
         
         END IF;
         
         str_naics_regexp := str_naics_regexp || ')';
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 30
      -- Query the data
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         SELECT
         iwtt.dz_json_element1_obj(
            p_elements => (
               SELECT
                iwtt.dz_json_element1_vry(
                   iwtt.dz_json_element1(
                      p_name => 'NAICS'
                     ,p_element_obj_vry => CAST(MULTISET(
                        SELECT
                        iwtt.dz_json_element2_obj(
                           p_elements => iwtt.dz_json_element2_vry(
                              iwtt.dz_json_element2(
                                  p_name => 'p_naics_code'
                                 ,p_element_string => TO_CHAR(a.naics_code)
                              )
                              ,iwtt.dz_json_element2(
                                  p_name => 'p_naics_desc'
                                 ,p_element_string => a.naics_desc
                              )
                           )
                        )
                        FROM
                        iwtt.key_naics a
                        JOIN (
                           SELECT
                           bb.naics_code
                           FROM
                           iwtt.treatment_system bb
                           GROUP BY
                           bb.naics_code
                        ) b
                        ON
                        a.naics_code = b.naics_code
                        WHERE (
                           p_naics_code IS NULL
                           OR
                           a.naics_code IN (SELECT * FROM TABLE(ary_naics_codes))
                        ) AND (
                           p_naics_desc IS NULL
                           OR
                           REGEXP_INSTR(UPPER(a.naics_desc),str_naics_regexp) > 0
                        )
                        ORDER BY
                        a.naics_code
                     ) AS iwtt.dz_json_element2_obj_vry)
                  )
               )
               FROM
               dual
            ) 
         )
         INTO obj_output
         FROM
         dual;
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 40
      -- Convert results to clob
      --------------------------------------------------------------------------
      IF num_return_code = 0
      THEN
         clb_output := obj_output.toJSON(
            p_pretty_print    => num_pretty_print + 1
         );
         
      END IF;
      
      --------------------------------------------------------------------------
      -- Step 50
      -- Push out the results
      --------------------------------------------------------------------------
      write_header(
          p_output_format    => 'JSON'
         ,p_cache            => NULL
         ,p_json_callback    => NULL
         ,p_mute             => boo_mute
      );
      
      IF num_return_code <> 0
      THEN
         clob2htp(
             jsend_error(
                p_message        => str_status_message
               ,p_code           => num_return_code
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
            )
            ,p_mute => boo_mute
         );
         
      ELSE
         clob2htp(
            jsend_success(
                p_data           => clb_output
               ,p_jsonp_callback => NULL
               ,p_pretty_print   => num_pretty_print
             )
            ,p_mute => boo_mute
         );
         
      END IF;
      
   END lookup_naics_jsonv01;

END iwtt_services;
/
