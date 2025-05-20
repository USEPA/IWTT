create or replace PACKAGE ords_param
AUTHID CURRENT_USER
AS

   TYPE array_clob     IS TABLE OF CLOB;
   TYPE array_varchar2 IS TABLE OF VARCHAR(4000 Char);
   TYPE array_number   IS TABLE OF NUMBER;
   TYPE array_date     IS TABLE OF DATE;
   TYPE array_tz       IS TABLE OF TIMESTAMP WITH TIME ZONE;
   
   TYPE param_dict IS TABLE OF CLOB
   INDEX BY VARCHAR2(4000 Char);

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION body_parse(
       p_str              IN  CLOB
   ) RETURN param_dict DETERMINISTIC;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  CLOB         DEFAULT NULL
   ) RETURN CLOB DETERMINISTIC;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_varchar2(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  VARCHAR2     DEFAULT NULL
   ) RETURN VARCHAR2 DETERMINISTIC;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_number(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  NUMBER       DEFAULT NULL
   ) RETURN NUMBER DETERMINISTIC;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_date(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  DATE         DEFAULT NULL
      ,p_date_mask        IN  VARCHAR2     DEFAULT 'ISO'
   ) RETURN DATE DETERMINISTIC;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_tz(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  TIMESTAMP WITH TIME ZONE DEFAULT NULL
      ,p_date_mask        IN  VARCHAR2     DEFAULT 'ISO'
   ) RETURN TIMESTAMP WITH TIME ZONE DETERMINISTIC;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_array_clob(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  CLOB         DEFAULT NULL
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
   ) RETURN array_clob DETERMINISTIC;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_array_varchar2(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  CLOB         DEFAULT NULL
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
   ) RETURN array_varchar2 DETERMINISTIC;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_array_number(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  CLOB         DEFAULT NULL
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
   ) RETURN array_number DETERMINISTIC;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_array_date(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  CLOB         DEFAULT NULL
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
      ,p_date_mask        IN  VARCHAR2     DEFAULT 'ISO'
   ) RETURN array_date DETERMINISTIC;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION query_param_array_tz(
       p_clob_dict        IN  param_dict
      ,p_key              IN  VARCHAR2
      ,p_default_value    IN  CLOB         DEFAULT NULL
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
      ,p_date_mask        IN  VARCHAR2     DEFAULT 'ISO'
   ) RETURN array_tz DETERMINISTIC;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION array_clob_to_clob(
       p_input            IN  array_clob
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
   ) RETURN CLOB DETERMINISTIC;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION array_varchar2_to_clob(
       p_input            IN  array_varchar2
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
   ) RETURN CLOB DETERMINISTIC;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION array_number_to_clob(
       p_input            IN  array_number
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
   ) RETURN CLOB DETERMINISTIC;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION array_date_to_clob(
       p_input            IN  array_date
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
      ,p_date_mask        IN  VARCHAR2     DEFAULT 'ISO'
   ) RETURN CLOB DETERMINISTIC;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION array_tz_to_clob(
       p_input            IN  array_tz
      ,p_delimiter        IN  VARCHAR2     DEFAULT ','
      ,p_date_mask        IN  VARCHAR2     DEFAULT 'ISO'
   ) RETURN CLOB DETERMINISTIC;

END ords_param;
/

GRANT EXECUTE ON ords_param TO PUBLIC;

