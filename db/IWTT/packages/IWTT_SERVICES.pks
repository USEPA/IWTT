CREATE OR REPLACE PACKAGE iwtt.iwtt_services
AUTHID CURRENT_USER
AS

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
   );
   
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
   );
   
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
   );
   
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
   );
   
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
   );
   
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
   );
   
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
   );
   
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
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE report_jsonv01(
       p_REF_ID                     IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_industry_jsonv01(
       p_industry_ID                IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_parameter_jsonv01(
       p_pollutant_search_term      IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_treatment_tech_jsonv01(
       p_treatment_technology_code  IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   );

   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_year_jsonv01(
       p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_document_type_jsonv01(
       p_document_type              IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_motivation_cat_jsonv01(
       p_motivation_cat             IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_sic_jsonv01(
       p_sic_code                   IN  VARCHAR2 DEFAULT NULL
      ,p_sic_desc                   IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   );
   
   -----------------------------------------------------------------------------
   -----------------------------------------------------------------------------
   PROCEDURE lookup_naics_jsonv01(
       p_naics_code                 IN  VARCHAR2 DEFAULT NULL
      ,p_naics_desc                 IN  VARCHAR2 DEFAULT NULL
      ,p_pretty_print               IN  VARCHAR2 DEFAULT NULL
      ,f                            IN  VARCHAR2 DEFAULT NULL
      ,api_key                      IN  VARCHAR2 DEFAULT NULL
   );

END iwtt_services;
/

GRANT EXECUTE ON iwtt.iwtt_services TO PUBLIC;
