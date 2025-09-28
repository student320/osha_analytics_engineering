{# 
    This macro returns a descriptive string for size

    #}

{% macro get_size_description(size) -%}
    case {{ size }}
        when 1 then ' < 20 employees'
        when 2 then '20-249 employees'
        when 21 then '20-99 employees'
        when 22 then '100-249 employees'
        when 3 then '250+ employees'
        else 'EMPTY'
    end
{%- endmacro %}