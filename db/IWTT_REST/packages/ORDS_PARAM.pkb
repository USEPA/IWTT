create or replace PACKAGE BODY ords_param
AS

   g_iso_mask CONSTANT VARCHAR2(4000 Char) := 'YYYY-MM-DD"T"HH24:MI:SS.FF3TZH:TZM';
   g_dat_mask CONSTANT VARCHAR2(4000 Char) := 'YYYY-MM-DD HH24:MI:SS';

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION clean_lf(
       p_input            IN VARCHAR2
   ) RETURN VARCHAR2 DETERMINISTIC
   AS
   BEGIN
      RETURN REPLACE(
         REPLACE(
            p_input,
            CHR(10),
            ''
         ),
         CHR(13),
         ''
      );   
   
   END clean_lf;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION safe_to_number(
       p_input            IN  VARCHAR2
      ,p_null_replacement IN  NUMBER DEFAULT NULL
   ) RETURN NUMBER DETERMINISTIC
   AS
   BEGIN
      RETURN clean_lf(p_input);

   EXCEPTION
      WHEN VALUE_ERROR
      THEN
         RETURN p_null_replacement;

   END safe_to_number;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION safe_to_date(
       p_input            IN  VARCHAR2
      ,p_null_replacement IN  DATE     DEFAULT NULL
      ,p_date_mask        IN  VARCHAR2 DEFAULT 'ISO'
   ) RETURN DATE DETERMINISTIC
   AS
      dat_results    DATE;
      
   BEGIN
      IF p_date_mask IS NULL
      OR p_date_mask = 'ISO'
      THEN
         RETURN TO_TIMESTAMP_TZ(
             clean_lf(p_input)
            ,g_iso_mask
         );
 
      ELSE
         RETURN TO_DATE(
             clean_lf(p_input)
            ,p_date_mask
         );
         
      END IF;

   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN p_null_replacement;

   END safe_to_date;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION safe_to_tz(
       p_input            IN  VARCHAR2
      ,p_null_replacement IN  DATE     DEFAULT NULL
      ,p_date_mask        IN  VARCHAR2 DEFAULT 'ISO'
   ) RETURN TIMESTAMP WITH TIME ZONE DETERMINISTIC
   AS
   BEGIN
      IF p_date_mask IS NULL
      OR p_date_mask = 'ISO'
      THEN
         RETURN TO_TIMESTAMP_TZ(
             clean_lf(p_input)
            ,g_iso_mask
         );
         
      ELSE
         RETURN TO_TIMESTAMP_TZ(
             clean_lf(p_input)
            ,p_date_mask
         );
      
      END IF;

   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN p_null_replacement;

   END safe_to_tz;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION gz_split(
       p_str              IN CLOB
      ,p_regex            IN VARCHAR2
      ,p_match            IN VARCHAR2 DEFAULT NULL
      ,p_end              IN NUMBER   DEFAULT 0
      ,p_trim             IN VARCHAR2 DEFAULT 'FALSE'
   ) RETURN array_clob DETERMINISTIC 
   AS
      int_delim      PLS_INTEGER;
      int_position   PLS_INTEGER := 1;
      int_counter    PLS_INTEGER := 1;
      ary_output     array_clob;
      num_end        NUMBER      := p_end;
      str_trim       VARCHAR2(5 Char) := UPPER(p_trim);

      FUNCTION trim_varray(
         p_input            IN array_clob
      ) RETURN array_clob
      AS
         ary_output array_clob := array_clob();
         int_index  PLS_INTEGER := 1;
         str_check  CLOB;

      BEGIN

         --------------------------------------------------------------------------
         -- Step 10
         -- Exit if input is empty
         --------------------------------------------------------------------------
         IF p_input IS NULL
         OR p_input.COUNT = 0
         THEN
            RETURN ary_output;

         END IF;

         --------------------------------------------------------------------------
         -- Step 20
         -- Trim the strings removing anything utterly trimmed away
         --------------------------------------------------------------------------
         FOR i IN 1 .. p_input.COUNT
         LOOP
            str_check := TRIM(p_input(i));

            IF str_check IS NULL
            OR str_check = ''
            THEN
               NULL;

            ELSE
               ary_output.EXTEND(1);
               ary_output(int_index) := str_check;
               int_index := int_index + 1;

            END IF;

         END LOOP;

         --------------------------------------------------------------------------
         -- Step 10
         -- Return the results
         --------------------------------------------------------------------------
         RETURN ary_output;

      END trim_varray;

   BEGIN

      --------------------------------------------------------------------------
      -- Step 10
      -- Create the output array and check parameters
      --------------------------------------------------------------------------
      ary_output := array_clob();

      IF str_trim IS NULL
      THEN
         str_trim := 'FALSE';

      ELSIF str_trim NOT IN ('TRUE','FALSE')
      THEN
         RAISE_APPLICATION_ERROR(-20001,'boolean error');

      END IF;

      IF num_end IS NULL
      THEN
         num_end := 0;

      END IF;

      --------------------------------------------------------------------------
      -- Step 20
      -- Exit early if input is empty
      --------------------------------------------------------------------------
      IF p_str IS NULL
      OR p_str = ''
      THEN
         RETURN ary_output;

      END IF;

      --------------------------------------------------------------------------
      -- Step 30
      -- Account for weird instance of pure character breaking
      --------------------------------------------------------------------------
      IF p_regex IS NULL
      OR p_regex = ''
      THEN
         FOR i IN 1 .. LENGTH(p_str)
         LOOP
            ary_output.EXTEND(1);
            ary_output(i) := SUBSTR(p_str,i,1);

         END LOOP;

         RETURN ary_output;

      END IF;

      --------------------------------------------------------------------------
      -- Step 40
      -- Break string using the usual REGEXP functions
      --------------------------------------------------------------------------
      LOOP
         EXIT WHEN int_position = 0;
         int_delim  := REGEXP_INSTR(p_str,p_regex,int_position,1,0,p_match);

         IF  int_delim = 0
         THEN
            -- no more matches found
            ary_output.EXTEND(1);
            ary_output(int_counter) := SUBSTR(p_str,int_position);
            int_position  := 0;

         ELSE
            IF int_counter = num_end
            THEN
               -- take the rest as is
               ary_output.EXTEND(1);
               ary_output(int_counter) := SUBSTR(p_str,int_position);
               int_position  := 0;

            ELSE
               --dbms_output.put_line(ary_output.COUNT);
               ary_output.EXTEND(1);
               ary_output(int_counter) := SUBSTR(p_str,int_position,int_delim-int_position);
               int_counter := int_counter + 1;
               int_position := REGEXP_INSTR(p_str,p_regex,int_position,1,1,p_match);

            END IF;

         END IF;

      END LOOP;

      --------------------------------------------------------------------------
      -- Step 50
      -- Trim results if so desired
      --------------------------------------------------------------------------
      IF str_trim = 'TRUE'
      THEN
         RETURN trim_varray(
            p_input => ary_output
         );

      END IF;

      --------------------------------------------------------------------------
      -- Step 60
      -- Cough out the results
      --------------------------------------------------------------------------
      RETURN ary_output;

   END gz_split;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION body_parse(
       p_str              IN  CLOB
   ) RETURN param_dict DETERMINISTIC
   AS
      ary_clob      array_clob;
      ary_items     array_clob;
      dict_results  param_dict;

   BEGIN

      IF p_str IS NULL
      OR p_str = ''
      THEN
         RETURN dict_results;

      END IF;

      ary_clob := gz_split(
          p_str   => p_str
         ,p_regex => CHR(38)
         ,p_trim  => 'TRUE'
      );

      FOR i IN 1 .. ary_clob.COUNT
      LOOP
         ary_items := gz_split(
             p_str   => ary_clob(i)
            ,p_regex => '='
            ,p_trim  => 'TRUE'
         );

         IF ary_items.COUNT = 2
         THEN
            IF ary_items(2) IS NOT NULL
            AND LENGTH(ary_items(2)) > 0
            AND TO_CHAR(SUBSTR(ary_items(2),1,1)) != ' '
            THEN
               dict_results(ary_items(1)) := UTL_URL.UNESCAPE(
                  REPLACE(ary_items(2),'+','%20')
               );

            END IF;

         END IF;

      END LOOP;

      RETURN dict_results;

   END body_parse;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param(
       p_clob_dict         IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  CLOB         DEFAULT NULL
   ) RETURN CLOB DETERMINISTIC
   AS
      str_loop_key     VARCHAR2(4000 Char);

   BEGIN

      str_loop_key := p_clob_dict.FIRST;
      WHILE str_loop_key IS NOT NULL
      LOOP
         IF str_loop_key = p_key
         THEN
            RETURN p_clob_dict(str_loop_key);

         END IF;

         str_loop_key := p_clob_dict.NEXT(str_loop_key);

      END LOOP;

      RETURN p_default_value;

   END query_param;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_varchar2(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  VARCHAR2     DEFAULT NULL
   ) RETURN VARCHAR2 DETERMINISTIC
   AS
      str_loop_key     VARCHAR2(4000 Char);

   BEGIN

      str_loop_key := p_clob_dict.FIRST;
      WHILE str_loop_key IS NOT NULL
      LOOP
         IF str_loop_key = p_key
         THEN
            RETURN TO_CHAR(
               SUBSTR(p_clob_dict(str_loop_key),1,4000)
            );

         END IF;

         str_loop_key := p_clob_dict.NEXT(str_loop_key);

      END LOOP;

      RETURN p_default_value;

   END query_param_varchar2;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_number(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  NUMBER       DEFAULT NULL
   ) RETURN NUMBER DETERMINISTIC
   AS
      str_loop_key     VARCHAR2(4000 Char);

   BEGIN

      str_loop_key := p_clob_dict.FIRST;
      WHILE str_loop_key IS NOT NULL
      LOOP
         IF str_loop_key = p_key
         THEN
            RETURN safe_to_number(
                p_input            => TO_CHAR(SUBSTR(p_clob_dict(str_loop_key),1,4000))
               ,p_null_replacement => p_default_value
            );

         END IF;

         str_loop_key := p_clob_dict.NEXT(str_loop_key);

      END LOOP;

      RETURN p_default_value;

   END query_param_number;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_date(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  DATE         DEFAULT NULL
      ,p_date_mask        IN  VARCHAR2     DEFAULT 'ISO'
   ) RETURN DATE DETERMINISTIC
   AS
      str_loop_key     VARCHAR2(4000 Char);

   BEGIN

      str_loop_key := p_clob_dict.FIRST;
      WHILE str_loop_key IS NOT NULL
      LOOP
         IF str_loop_key = p_key
         THEN
            RETURN safe_to_date(
                p_input            => TO_CHAR(SUBSTR(p_clob_dict(str_loop_key),1,4000))
               ,p_null_replacement => p_default_value
               ,p_date_mask        => p_date_mask
            );

         END IF;

         str_loop_key := p_clob_dict.NEXT(str_loop_key);

      END LOOP;

      RETURN p_default_value;

   END query_param_date;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_tz(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  TIMESTAMP WITH TIME ZONE DEFAULT NULL
      ,p_date_mask        IN  VARCHAR2     DEFAULT 'ISO'
   ) RETURN TIMESTAMP WITH TIME ZONE DETERMINISTIC
   AS
      str_loop_key     VARCHAR2(4000 Char);

   BEGIN

      str_loop_key := p_clob_dict.FIRST;
      WHILE str_loop_key IS NOT NULL
      LOOP
         IF str_loop_key = p_key
         THEN
            RETURN safe_to_tz(
                p_input            => TO_CHAR(SUBSTR(p_clob_dict(str_loop_key),1,4000))
               ,p_null_replacement => p_default_value
               ,p_date_mask        => p_date_mask
            );

         END IF;

         str_loop_key := p_clob_dict.NEXT(str_loop_key);

      END LOOP;

      RETURN p_default_value;

   END query_param_tz;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_array_clob(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  CLOB         DEFAULT NULL
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
   ) RETURN array_clob DETERMINISTIC
   AS
      str_loop_key     VARCHAR2(4000 Char);
      ary_results      array_clob;
      
   BEGIN

      str_loop_key := p_clob_dict.FIRST;
      WHILE str_loop_key IS NOT NULL
      LOOP
         IF str_loop_key = p_key
         THEN
            ary_results := gz_split(
                p_str              => p_clob_dict(str_loop_key)
               ,p_regex            => p_delimiter
               ,p_trim             => 'TRUE'
            );
            
            RETURN ary_results;

         END IF;

         str_loop_key := p_clob_dict.NEXT(str_loop_key);

      END LOOP;

      RETURN gz_split(
          p_str              => p_clob_dict(str_loop_key)
         ,p_regex            => p_delimiter
         ,p_trim             => 'TRUE'
      );
   
   END query_param_array_clob;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_array_varchar2(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  CLOB         DEFAULT NULL
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
   ) RETURN array_varchar2 DETERMINISTIC
   AS
      str_loop_key     VARCHAR2(4000 Char);
      ary_results      array_varchar2;
      ary_param        array_clob;
      
   BEGIN

      str_loop_key := p_clob_dict.FIRST;
      WHILE str_loop_key IS NOT NULL
      LOOP
         IF str_loop_key = p_key
         THEN
            ary_param := gz_split(
                p_str              => p_clob_dict(str_loop_key)
               ,p_regex            => p_delimiter
               ,p_trim             => 'TRUE'
            );
            
            ary_results := array_varchar2();
            FOR i IN 1 .. ary_param.COUNT
            LOOP
               ary_results.EXTEND();
               ary_results(i) := TO_CHAR(SUBSTR(ary_param(i),1,4000));
               
            END LOOP;
            
            RETURN ary_results;

         END IF;

         str_loop_key := p_clob_dict.NEXT(str_loop_key);

      END LOOP;
      
      IF p_default_value IS NULL
      THEN
         RETURN NULL;
         
      END IF;
      
      ary_param := gz_split(
          p_str              => p_default_value
         ,p_regex            => p_delimiter
         ,p_trim             => 'TRUE'
      );
      
      ary_results := array_varchar2();
      FOR i IN 1 .. ary_param.COUNT
      LOOP
         ary_results.EXTEND();
         ary_results(i) := TO_CHAR(SUBSTR(ary_param(i),1,4000));
      
      END LOOP;
      
      RETURN ary_results;
      
   END query_param_array_varchar2;
   
   ----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_array_number(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  CLOB         DEFAULT NULL
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
   ) RETURN array_number DETERMINISTIC
   AS
      str_loop_key     VARCHAR2(4000 Char);
      ary_clob         array_clob;
      ary_results      array_number;
      num_check        NUMBER;
      
   BEGIN

      str_loop_key := p_clob_dict.FIRST;
      WHILE str_loop_key IS NOT NULL
      LOOP
         IF str_loop_key = p_key
         THEN
            ary_clob := gz_split(
                p_str              => p_clob_dict(str_loop_key)
               ,p_regex            => p_delimiter
               ,p_trim             => 'TRUE'
            );
            
            ary_results := array_number();
            FOR i IN 1 .. ary_clob.COUNT
            LOOP
               num_check := safe_to_number(
                   p_input   => TO_CHAR(SUBSTR(ary_clob(i),1,4000))
               );
               
               IF num_check IS NOT NULL
               THEN
                  ary_results.EXTEND();
                  ary_results(i) := num_check;
                  
               END IF;
            
            END LOOP;
            
            RETURN ary_results;

         END IF;

         str_loop_key := p_clob_dict.NEXT(str_loop_key);

      END LOOP;
      
      IF p_default_value IS NULL
      THEN
         RETURN NULL;
         
      END IF;
      
      ary_clob := gz_split(
          p_str              => p_default_value
         ,p_regex            => p_delimiter
         ,p_trim             => 'TRUE'
      );
      
      ary_results := array_number();
      FOR i IN 1 .. ary_clob.COUNT
      LOOP
         num_check := safe_to_number(
             p_input   => TO_CHAR(SUBSTR(ary_clob(i),1,4000))
         );
         
         IF num_check IS NOT NULL
         THEN
            ary_results.EXTEND();
            ary_results(i) := num_check;
            
         END IF;
      
      END LOOP;
      
      RETURN ary_results;
      
   END query_param_array_number;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_array_date(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  CLOB         DEFAULT NULL
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
      ,p_date_mask        IN  VARCHAR2     DEFAULT 'ISO'
   ) RETURN array_date DETERMINISTIC
   AS
      str_loop_key     VARCHAR2(4000 Char);
      ary_clob         array_clob;
      ary_results      array_date;
      dat_check        DATE;
      
   BEGIN

      str_loop_key := p_clob_dict.FIRST;
      WHILE str_loop_key IS NOT NULL
      LOOP
         IF str_loop_key = p_key
         THEN
            ary_clob := gz_split(
                p_str              => p_clob_dict(str_loop_key)
               ,p_regex            => p_delimiter
               ,p_trim             => 'TRUE'
            );
            
            ary_results := array_date();
            FOR i IN 1 .. ary_clob.COUNT
            LOOP
               dat_check := safe_to_date(
                   p_input     => TO_CHAR(SUBSTR(ary_clob(i),1,4000))
                  ,p_date_mask => p_date_mask
               );
               
               IF dat_check IS NOT NULL
               THEN
                  ary_results.EXTEND();
                  ary_results(i) := dat_check;
                  
               END IF;
            
            END LOOP;
            
            RETURN ary_results;

         END IF;

         str_loop_key := p_clob_dict.NEXT(str_loop_key);

      END LOOP;
      
      IF p_default_value IS NULL
      THEN
         RETURN NULL;
         
      END IF;
      
      ary_clob := gz_split(
          p_str              => p_default_value
         ,p_regex            => p_delimiter
         ,p_trim             => 'TRUE'
      );
      
      ary_results := array_date();
      FOR i IN 1 .. ary_clob.COUNT
      LOOP
         dat_check := safe_to_date(
             p_input     => TO_CHAR(SUBSTR(ary_clob(i),1,4000))
            ,p_date_mask => p_date_mask
         );
         
         IF dat_check IS NOT NULL
         THEN
            ary_results.EXTEND();
            ary_results(i) := dat_check;
            
         END IF;
      
      END LOOP;
      
      RETURN ary_results;
      
   END query_param_array_date;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_array_tz(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  CLOB         DEFAULT NULL
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
      ,p_date_mask        IN  VARCHAR2     DEFAULT 'ISO'
   ) RETURN array_tz DETERMINISTIC
   AS
      str_loop_key     VARCHAR2(4000 Char);
      ary_clob         array_clob;
      ary_results      array_tz;
      tz_check         TIMESTAMP WITH TIME ZONE;
      
   BEGIN

      str_loop_key := p_clob_dict.FIRST;
      WHILE str_loop_key IS NOT NULL
      LOOP
         IF str_loop_key = p_key
         THEN
            ary_clob := gz_split(
                p_str              => p_clob_dict(str_loop_key)
               ,p_regex            => p_delimiter
               ,p_trim             => 'TRUE'
            );
            
            ary_results := array_tz();
            FOR i IN 1 .. ary_clob.COUNT
            LOOP
               tz_check := safe_to_tz(
                   p_input     => TO_CHAR(SUBSTR(ary_clob(i),1,4000))
                  ,p_date_mask => p_date_mask
               );
               
               IF tz_check IS NOT NULL
               THEN
                  ary_results.EXTEND();
                  ary_results(i) := tz_check;
                  
               END IF;
            
            END LOOP;
            
            RETURN ary_results;

         END IF;

         str_loop_key := p_clob_dict.NEXT(str_loop_key);

      END LOOP;
      
      IF p_default_value IS NULL
      THEN
         RETURN NULL;
         
      END IF;
      
      ary_clob := gz_split(
          p_str              => p_default_value
         ,p_regex            => p_delimiter
         ,p_trim             => 'TRUE'
      );
      
      ary_results := array_tz();
      FOR i IN 1 .. ary_clob.COUNT
      LOOP
         tz_check := safe_to_tz(
             p_input     => TO_CHAR(SUBSTR(ary_clob(i),1,4000))
            ,p_date_mask => p_date_mask
         );
         
         IF tz_check IS NOT NULL
         THEN
            ary_results.EXTEND();
            ary_results(i) := tz_check;
            
         END IF;
      
      END LOOP;
      
      RETURN ary_results;
      
   END query_param_array_tz;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION array_clob_to_clob(
       p_input            IN  array_clob
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
   ) RETURN CLOB DETERMINISTIC
   AS
      clob_results CLOB;
      
   BEGIN
   
      IF p_input IS NULL
      OR p_input.COUNT = 0
      THEN
         RETURN NULL;
         
      END IF;
      
      clob_results := '';      
      FOR i IN 1 .. p_input.COUNT
      LOOP
         clob_results := clob_results || p_input(i);
      
         IF i < p_input.COUNT
         THEN
            clob_results := clob_results || p_delimiter;
         
         END IF;
      
      END LOOP;
   
      RETURN clob_results;
   
   END array_clob_to_clob;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION array_varchar2_to_clob(
       p_input            IN  array_varchar2
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
   ) RETURN CLOB DETERMINISTIC
   AS
      clob_results CLOB;
   
   BEGIN
   
      IF p_input IS NULL
      OR p_input.COUNT = 0
      THEN
         RETURN NULL;
         
      END IF;
      
      clob_results := '';      
      FOR i IN 1 .. p_input.COUNT
      LOOP
         clob_results := clob_results || p_input(i);
      
         IF i < p_input.COUNT
         THEN
            clob_results := clob_results || p_delimiter;
         
         END IF;
      
      END LOOP;
   
      RETURN clob_results;

   END array_varchar2_to_clob;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION array_number_to_clob(
       p_input            IN  array_number
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
   ) RETURN CLOB DETERMINISTIC
   AS
      clob_results CLOB;
   
   BEGIN
   
      IF p_input IS NULL
      OR p_input.COUNT = 0
      THEN
         RETURN NULL;
         
      END IF;
      
      clob_results := '';      
      FOR i IN 1 .. p_input.COUNT
      LOOP
         clob_results := clob_results || TO_CHAR(p_input(i));
      
         IF i < p_input.COUNT
         THEN
            clob_results := clob_results || p_delimiter;
         
         END IF;
      
      END LOOP;
   
      RETURN clob_results;
 
   END array_number_to_clob;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION array_date_to_clob(
       p_input            IN  array_date
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
      ,p_date_mask        IN  VARCHAR2     DEFAULT 'ISO'
   ) RETURN CLOB DETERMINISTIC
   AS
      clob_results   CLOB;
      str_date_mask VARCHAR2(4000 Char);
   
   BEGIN
   
      IF p_input IS NULL
      OR p_input.COUNT = 0
      THEN
         RETURN NULL;
         
      END IF;
      
      IF p_date_mask IS NULL
      OR p_date_mask = 'ISO'
      THEN
         str_date_mask := g_dat_mask;
         
      ELSE
         str_date_mask := p_date_mask;
         
      END IF;
      
      clob_results := '';      
      FOR i IN 1 .. p_input.COUNT
      LOOP
         clob_results := clob_results || TO_CHAR(p_input(i),str_date_mask);
      
         IF i < p_input.COUNT
         THEN
            clob_results := clob_results || p_delimiter;
         
         END IF;
      
      END LOOP;
   
      RETURN clob_results;

   END array_date_to_clob;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION array_tz_to_clob(
       p_input            IN  array_tz
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
      ,p_date_mask        IN  VARCHAR2     DEFAULT 'ISO'
   ) RETURN CLOB DETERMINISTIC
   AS
      clob_results   CLOB;
      str_date_mask VARCHAR2(4000 Char);
   
   BEGIN
   
      IF p_input IS NULL
      OR p_input.COUNT = 0
      THEN
         RETURN NULL;
         
      END IF;
      
      IF p_date_mask IS NULL
      OR p_date_mask = 'ISO'
      THEN
         str_date_mask := g_iso_mask;
         
      ELSE
         str_date_mask := p_date_mask;
         
      END IF;
      
      clob_results := '';      
      FOR i IN 1 .. p_input.COUNT
      LOOP
         clob_results := clob_results || TO_CHAR(p_input(i),str_date_mask);
      
         IF i < p_input.COUNT
         THEN
            clob_results := clob_results || p_delimiter;
         
         END IF;
      
      END LOOP;
   
      RETURN clob_results;
   
   END array_tz_to_clob;
   
END ords_param;
/


