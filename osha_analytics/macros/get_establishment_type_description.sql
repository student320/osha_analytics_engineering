{# 
    This macro returns a descriptive string for establishment_type
#}

{% macro get_establishment_type_description(establishment_type) -%}
    case {{ establishment_type }}
        when 1 then 'Not a government entity'
        when 2 then 'State government entity'
        when 3 then 'Local government entity'
        else 'EMPTY'
    end
{%- endmacro %}
