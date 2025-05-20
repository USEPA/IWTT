CREATE OR REPLACE PACKAGE BODY iwtt_rest.iwtt_ords
AS

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE ords_all
   AS
   BEGIN

      ords_util.define_service(
          p_module_name     => 'healthcheck'
         ,p_base_path       => 'healthcheck/'
         ,p_source_get_type => ORDS.SOURCE_TYPE_QUERY_ONE_ROW
         ,p_source_get      => 'SELECT 0 AS "result" FROM dual'
         ,p_source_post     => NULL
      );
      ords_util.define_service(
          p_module_name  => 'art_search_csvv01'
         ,p_base_path    => 'v1/art_search_csv/'
         ,p_source_get   => owrap('art_search_csvv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'art_search_jsonv01'
         ,p_base_path    => 'v1/art_search_json/'
         ,p_source_get   => owrap('art_search_jsonv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'guid_search_d_csvv01'
         ,p_base_path    => 'v1/guid_search_d_csv/'
         ,p_source_get   => owrap('guid_search_d_csvv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'guid_search_i_csvv01'
         ,p_base_path    => 'v1/guid_search_i_csv/'
         ,p_source_get   => owrap('guid_search_i_csvv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'guid_search_jsonv01'
         ,p_base_path    => 'v1/guid_search_json/'
         ,p_source_get   => owrap('guid_search_jsonv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'guid_search_p_csvv01'
         ,p_base_path    => 'v1/guid_search_p_csv/'
         ,p_source_get   => owrap('guid_search_p_csvv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'guid_search_raw'
         ,p_base_path    => 'v1/guid_search_raw/'
         ,p_source_get   => owrap('guid_search_raw','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'guid_search_t_csvv01'
         ,p_base_path    => 'v1/guid_search_t_csv/'
         ,p_source_get   => owrap('guid_search_t_csvv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'lookup_doc_type_jsonv01'
         ,p_base_path    => 'v1/lookup_doc_type_json/'
         ,p_source_get   => owrap('lookup_doc_type_jsonv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'lookup_industry_jsonv01'
         ,p_base_path    => 'v1/lookup_industry_json/'
         ,p_source_get   => owrap('lookup_industry_jsonv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'lookup_motiv_cat_jsonv01'
         ,p_base_path    => 'v1/lookup_motiv_cat_json/'
         ,p_source_get   => owrap('lookup_motiv_cat_jsonv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'lookup_naics_jsonv01'
         ,p_base_path    => 'v1/lookup_naics_json/'
         ,p_source_get   => owrap('lookup_naics_jsonv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'lookup_parameter_jsonv01'
         ,p_base_path    => 'v1/lookup_parameter_json/'
         ,p_source_get   => owrap('lookup_parameter_jsonv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'lookup_sic_jsonv01'
         ,p_base_path    => 'v1/lookup_sic_json/'
         ,p_source_get   => owrap('lookup_sic_jsonv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'lookup_treat_tech_jsonv01'
         ,p_base_path    => 'v1/lookup_treat_tech_json/'
         ,p_source_get   => owrap('lookup_treat_tech_jsonv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'lookup_year_jsonv01'
         ,p_base_path    => 'v1/lookup_year_json/'
         ,p_source_get   => owrap('lookup_year_jsonv01','get')
         ,p_source_post  => NULL
      );
      ords_util.define_service(
          p_module_name  => 'report_jsonv01'
         ,p_base_path    => 'v1/report_json/'
         ,p_source_get   => owrap('report_jsonv01','get')
         ,p_source_post  => NULL
      );

   END ords_all;
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION owrap(
       p_service            IN  VARCHAR2
      ,p_method             IN  VARCHAR2
   ) RETURN CLOB
   AS
      str_results CLOB;
      str_header  VARCHAR2(4000);
      
   BEGIN
   
      str_header := ords_util.get_header_name();
   
      str_results := q'[
         DECLARE
            boo_check BOOLEAN;
      ]';
      
      IF p_method IN ('post')
      THEN
         str_results := str_results || q'[
            dict_body ords_param.param_dict;
         ]';
         
      END IF;
      
      str_results := str_results || q'[
         BEGIN
      ]';
      
      IF p_method IN ('post')
      THEN
         str_results := str_results || q'[
            dict_body := ords_param.body_parse(:body_text);
         ]';
         
      END IF;
      
      IF str_header = 'NA'
      THEN
         str_results := str_results || q'[
            IF 1=1
            THEN
         ]';
         
      ELSE
         str_results := str_results 
                     || '      '
                     || 'boo_check := ords_util.chk_header(:' || REPLACE(str_header,'-','_') || ');';
         
         str_results := str_results || q'[
            
            IF boo_check
            THEN
         ]';
         
      END IF;
      
      str_results := str_results || ocode(p_service,p_method);
      
      str_results := str_results || q'[
            ELSE
               ords_util.reject_request();
               
            END IF;
      ]';
      
      IF ords_util.get_env() IN ('stage','dev')
      THEN         
         str_results := str_results || q'[
         EXCEPTION
            WHEN OTHERS
            THEN
               HTP.P(SQLERRM);
         
         ]';
         
      END IF;

      str_results := str_results || q'[     
         END;
      ]';
      
      RETURN str_results;
   
   END owrap;

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   FUNCTION ocode(
       p_service            IN  VARCHAR2
      ,p_method             IN  VARCHAR2
   ) RETURN CLOB
   AS
   BEGIN
      
      IF    p_service = 'art_search_csvv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.art_search_csvv01(
                p_point_source_category_code    => :p_point_source_category_code
               ,p_point_source_category_desc    => :p_point_source_category_desc
               ,p_treatment_technology_code     => :p_treatment_technology_code
               ,p_treatment_technology_desc     => :p_treatment_technology_desc
               ,p_treatment_scale               => :p_treatment_scale
               ,p_pollutant_search_term         => :p_pollutant_search_term
               ,p_pollutant_search_term_wc      => :p_pollutant_search_term_wc
               ,p_percent_removal_flag          => :p_percent_removal_flag
               ,p_percent_min                   => :p_percent_min
               ,p_percent_max                   => :p_percent_max
               ,p_sic                           => :p_sic
               ,p_naics                         => :p_naics
               ,p_year_min                      => :p_year_min
               ,p_year_max                      => :p_year_max
               ,p_motivation_category           => :p_motivation_category
               ,p_document_type                 => :p_document_type
               ,p_keyword                       => :p_keyword
               ,p_author                        => :p_author
               ,p_filename_override             => :p_filename_override
               ,p_add_bom                       => :p_add_bom
               ,f                               => :f
               ,api_key                         => :api_key
            );
         ]';

      ELSIF p_service = 'art_search_jsonv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.art_search_jsonv01(
                p_point_source_category_code    => :p_point_source_category_code
               ,p_point_source_category_desc    => :p_point_source_category_desc
               ,p_treatment_technology_code     => :p_treatment_technology_code
               ,p_treatment_technology_desc     => :p_treatment_technology_desc
               ,p_treatment_scale               => :p_treatment_scale
               ,p_pollutant_search_term         => :p_pollutant_search_term
               ,p_pollutant_search_term_wc      => :p_pollutant_search_term_wc
               ,p_percent_removal_flag          => :p_percent_removal_flag
               ,p_percent_min                   => :p_percent_min
               ,p_percent_max                   => :p_percent_max
               ,p_sic                           => :p_sic
               ,p_naics                         => :p_naics
               ,p_year_min                      => :p_year_min
               ,p_year_max                      => :p_year_max
               ,p_motivation_category           => :p_motivation_category
               ,p_document_type                 => :p_document_type
               ,p_keyword                       => :p_keyword
               ,p_author                        => :p_author
               ,p_pretty_print                  => :p_pretty_print
               ,f                               => :f
               ,api_key                         => :api_key
            );   
         ]';

      ELSIF p_service = 'guid_search_d_csvv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.guid_search_d_csvv01(
                p_point_source_category_code    => :p_point_source_category_code
               ,p_point_source_category_desc    => :p_point_source_category_desc
               ,p_treatment_technology_code     => :p_treatment_technology_code
               ,p_treatment_technology_desc     => :p_treatment_technology_desc
               ,p_pollutant_search_term         => :p_pollutant_search_term
               ,p_pollutant_search_term_wc      => :p_pollutant_search_term_wc
               ,p_parameter_desc                => :p_parameter_desc
               ,p_filename_override             => :p_filename_override
               ,p_add_bom                       => :p_add_bom
               ,f                               => :f
               ,api_key                         => :api_key
            ); 
         ]';

      ELSIF p_service = 'guid_search_i_csvv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.guid_search_i_csvv01(
                p_point_source_category_code    => :p_point_source_category_code
               ,p_point_source_category_desc    => :p_point_source_category_desc
               ,p_treatment_technology_code     => :p_treatment_technology_code
               ,p_treatment_technology_desc     => :p_treatment_technology_desc
               ,p_pollutant_search_term         => :p_pollutant_search_term
               ,p_pollutant_search_term_wc      => :p_pollutant_search_term_wc
               ,p_parameter_desc                => :p_parameter_desc
               ,p_filename_override             => :p_filename_override
               ,p_add_bom                       => :p_add_bom
               ,f                               => :f
               ,api_key                         => :api_key
            );  
         ]';

      ELSIF p_service = 'guid_search_jsonv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.guid_search_jsonv01(
                p_point_source_category_code    => :p_point_source_category_code
               ,p_point_source_category_desc    => :p_point_source_category_desc
               ,p_treatment_technology_code     => :p_treatment_technology_code
               ,p_treatment_technology_desc     => :p_treatment_technology_desc
               ,p_pollutant_search_term         => :p_pollutant_search_term
               ,p_pollutant_search_term_wc      => :p_pollutant_search_term_wc
               ,p_parameter_desc                => :p_parameter_desc
               ,p_pretty_print                  => :p_pretty_print
               ,f                               => :f
               ,api_key                         => :api_key
            );
         ]';

      ELSIF p_service = 'guid_search_p_csvv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.guid_search_p_csvv01(
                p_point_source_category_code    => :p_point_source_category_code
               ,p_point_source_category_desc    => :p_point_source_category_desc
               ,p_treatment_technology_code     => :p_treatment_technology_code
               ,p_treatment_technology_desc     => :p_treatment_technology_desc
               ,p_pollutant_search_term         => :p_pollutant_search_term
               ,p_pollutant_search_term_wc      => :p_pollutant_search_term_wc
               ,p_parameter_desc                => :p_parameter_desc
               ,p_filename_override             => :p_filename_override
               ,p_add_bom                       => :p_add_bom
               ,f                               => :f
               ,api_key                         => :api_key
            );  
         ]';

      ELSIF p_service = 'guid_search_raw'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.guid_search_raw(
                p_point_source_category_code => :p_point_source_category_code
               ,p_point_source_category_desc => :p_point_source_category_desc
               ,p_treatment_technology_code  => :p_treatment_technology_code
               ,p_treatment_technology_desc  => :p_treatment_technology_desc
               ,p_pollutant_search_term      => :p_pollutant_search_term
               ,p_pollutant_search_term_wc   => :p_pollutant_search_term_wc
               ,p_parameter_desc             => :p_parameter_desc
               ,p_filename_override          => :p_filename_override
               ,p_add_bom                    => :p_add_bom
               ,f                            => :f
               ,api_key                      => :api_key
            );
         ]';

      ELSIF p_service = 'guid_search_t_csvv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.guid_search_t_csvv01(
                p_point_source_category_code    => :p_point_source_category_code
               ,p_point_source_category_desc    => :p_point_source_category_desc
               ,p_treatment_technology_code     => :p_treatment_technology_code
               ,p_treatment_technology_desc     => :p_treatment_technology_desc
               ,p_pollutant_search_term         => :p_pollutant_search_term
               ,p_pollutant_search_term_wc      => :p_pollutant_search_term_wc
               ,p_parameter_desc                => :p_parameter_desc
               ,p_filename_override             => :p_filename_override
               ,p_add_bom                       => :p_add_bom
               ,f                               => :f
               ,api_key                         => :api_key
            );
               
         ]';

      ELSIF p_service = 'lookup_doc_type_jsonv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.lookup_document_type_jsonv01(
                p_document_type                 => :p_document_type
               ,p_pretty_print                  => :p_pretty_print
               ,f                               => :f
               ,api_key                         => :api_key
            ); 
         ]';

      ELSIF p_service = 'lookup_industry_jsonv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.lookup_industry_jsonv01(
                p_industry_id                   => :p_industry_id
               ,p_pretty_print                  => :p_pretty_print
               ,f                               => :f
               ,api_key                         => :api_key
            ); 
         ]';

      ELSIF p_service = 'lookup_motiv_cat_jsonv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.lookup_motivation_cat_jsonv01(
                p_motivation_cat                => :p_motivation_cat
               ,p_pretty_print                  => :p_pretty_print
               ,f                               => :f
               ,api_key                         => :api_key
            );
         ]';

      ELSIF p_service = 'lookup_naics_jsonv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.lookup_naics_jsonv01(
                p_naics_code                    => :p_naics_code
               ,p_naics_desc                    => :p_naics_desc
               ,p_pretty_print                  => :p_pretty_print
               ,f                               => :f
               ,api_key                         => :api_key
            ); 
         ]';

      ELSIF p_service = 'lookup_parameter_jsonv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.lookup_parameter_jsonv01(
                p_pollutant_search_term         => :p_pollutant_search_term
               ,p_pretty_print                  => :p_pretty_print
               ,f                               => :f
               ,api_key                         => :api_key
            );  
         ]';

      ELSIF p_service = 'lookup_sic_jsonv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.lookup_sic_jsonv01(
                p_sic_code                      => :p_sic_code
               ,p_sic_desc                      => :p_sic_desc
               ,p_pretty_print                  => :p_pretty_print
               ,f                               => :f
               ,api_key                         => :api_key
            ); 
         ]';

      ELSIF p_service = 'lookup_treat_tech_jsonv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.lookup_treatment_tech_jsonv01(
                p_treatment_technology_code     => :p_treatment_technology_code
               ,p_pretty_print                  => :p_pretty_print
               ,f                               => :f
               ,api_key                         => :api_key
            );
         ]';

      ELSIF p_service = 'lookup_year_jsonv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.lookup_year_jsonv01(
                p_pretty_print                  => :p_pretty_print
               ,f                               => :f
               ,api_key                         => :api_key
            ); 
         ]';

      ELSIF p_service = 'report_jsonv01'
      AND   p_method = 'get'
      THEN
         RETURN q'[
            iwtt.iwtt_services.report_jsonv01(
                p_ref_id                        => :p_ref_id
               ,p_pretty_print                  => :p_pretty_print
               ,f                               => :f
               ,api_key                         => :api_key
            );
         ]';

      ELSE
         RAISE_APPLICATION_ERROR(-20001,'err ' || p_service || ':' || p_method);
      
      END IF; 

   END ocode;

END iwtt_ords;
/

