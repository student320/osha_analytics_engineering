{# 
    This macro returns a descriptive string for record_of_injuries_illnesses
#}

{% macro get_record_of_injuries_illnesses_description(record_of_injuries_illnesses) -%}
    case {{ record_of_injuries_illnesses }}
        when 1 then 'yes'
        when 2 then 'no'
        else 'EMPTY'
    end
{%- endmacro %}
